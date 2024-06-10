import urllib.request
import requests
from tqdm import tqdm
import os
import zipfile
import shutil
import pandas as pd
from dbfread import DBF
import subprocess
from datetime import datetime
from dateutil.relativedelta import relativedelta
import numpy as np
from math import radians, sin, cos, sqrt, atan2




def baixar_arquivos_ftp(url: str, filename: str) -> None:

    urllib.request.urlretrieve(url, filename)

def baixar_arquivos_http(url: str, filename: str) -> None:
    
    response = requests.get(url)
    # Verificar se a solicitação foi bem-sucedida (código de status 200)
    if response.status_code == 200:
        # Abrir o arquivo em modo de escrita binária e escrever os dados baixados nele
        with open(filename, 'wb') as f:
            f.write(response.content)

def intervalo_anos(inicio: int, fim: int) -> range:
    return (range(inicio, fim+1))

def loop_download_anos(
        inicio: int, fim: int,
        diretorio_download: str,
        link: str,
        prefixo: str,
        extensao: str,
        ftp: bool = True) -> list:
    
    """
    Faz o download por ano de arquivos por ftp ou http
    """

    lista_anos = intervalo_anos(inicio=inicio, fim=fim)

    for ano in tqdm(lista_anos):
        falhas = []
        filename = f'{prefixo}{str(ano)}.{extensao}'
        filename_path = os.path.join(diretorio_download, filename)
        url = f'{link}{filename}'
        
        if not os.path.exists(filename_path):
            if ftp:
                baixar_arquivos_ftp(url=url, filename=filename_path)
            else:
                baixar_arquivos_http(url=url, filename=filename_path)
        if not os.path.exists(filename_path): # segunda verificação pois se não baixou, informa qual não funcionou
            falhas.append((filename, url))
    return falhas


def loop_download_anos_estados(
        inicio: int, fim: int,
        diretorio_download: str,
        link: str,
        prefixo: str,
        extensao: str,
        lista_estados: list,
        ftp: bool = True) -> list:
    
    """
    Faz o download por ano e estado de arquivos por ftp ou http
    O milênio foi hardcoded ex: > 2000
    """
    falhas_estados = []
    for estado in lista_estados:
        tmp_prefixo = prefixo + estado +"20"

        falhas = loop_download_anos(inicio=inicio, fim=fim,
        diretorio_download=diretorio_download,
        link=link,
        prefixo=tmp_prefixo,
        extensao=extensao,
        ftp=ftp)

        falhas_estados.append((estado, falhas))
    
    return falhas_estados

def unzip_and_move_csv(diretorio_zip: str, diretorio_final: str, extensao_extraido: str) -> None:
    """
    Extrai arquivos unzip de uma pasta e envia os arquivos para outro
    """
    
    # Lista todos os arquivos no diretório zip
    arquivos = os.listdir(diretorio_zip)
    
    for arquivo in arquivos:
        # Verifica se o arquivo é um .zip
        if arquivo.endswith('.zip'):
            caminho_arquivo_zip = os.path.join(diretorio_zip, arquivo)
            
            # Abre o arquivo .zip
            with zipfile.ZipFile(caminho_arquivo_zip, 'r') as zip_ref:
                # Extrai todos os arquivos do zip para um diretório temporário
                temp_dir = os.path.join(diretorio_zip, 'temp_unzip')
                zip_ref.extractall(temp_dir)
                
                # Move os arquivos com a extensao escolhida para o diretório de destino
                for root, _, files in os.walk(temp_dir):
                    for file in files:

                        if file.endswith(f'.{extensao_extraido}') or file.endswith(f'.{extensao_extraido.upper()}'):
                            caminho_arquivo = os.path.join(root, file)
                            caminho_final = os.path.join(diretorio_final, file)
                            if not os.path.exists(caminho_final):
                                shutil.move(caminho_arquivo, caminho_final.lower())
                
                # Remove o diretório temporário
                shutil.rmtree(temp_dir)

def convert_dbf_to_csv(diretorio_dbf: str, diretorio_csv: str) -> None:
    """
    Converte arquivos dbf de uma pasta e envia os arquivos csv para outro
    """
    # Verifica se o diretório de destino para os CSVs existe, se não, cria-o
    if not os.path.exists(diretorio_csv):
        os.makedirs(diretorio_csv)
    
    # Lista todos os arquivos no diretório DBF
    arquivos = os.listdir(diretorio_dbf)
    
    for arquivo in arquivos:
        # Verifica se o arquivo é um .dbf
        if arquivo.endswith('.dbf'):
            caminho_arquivo_dbf = os.path.join(diretorio_dbf, arquivo)
            
            # Converte o arquivo .dbf em um DataFrame
            try:
                dbf_table = DBF(caminho_arquivo_dbf, encoding='latin1')
                df = pd.DataFrame(iter(dbf_table))
            except Exception as e:
                print(f"Erro ao processar o arquivo {arquivo}: {e}")
                continue
            
            # Define o caminho para o arquivo CSV de saída
            nome_csv = f'{os.path.splitext(arquivo)[0]}.csv'
            caminho_csv = os.path.join(diretorio_csv, nome_csv)

            if not os.path.exists(caminho_csv):
                # Salva o DataFrame como um arquivo CSV
                df.to_csv(caminho_csv, index=False, encoding='utf-8')
            
def run_r_script_dbc2csv(input_dir: str, output_dir: str, r_script_path: str) -> None:

    # Caminho para o script R
    r_script_path = r_script_path
    
    # Comando para chamar o script R com argumentos
    command = ["Rscript", r_script_path, input_dir, output_dir]
    
    # Executa o comando
    result = subprocess.run(command, capture_output=True, text=True)
    
    # Exibe a saída e erros (se houver)
    print(result.stdout)
    if result.returncode != 0:
        print(result.stderr)

def get_estado(valor):
    local_separado = valor.split(" / ")
    if len(local_separado) > 2:
        return local_separado[2].strip()
    else:
        return pd.NA

def get_municipio(valor):
    local_separado = valor.split(" / ")
    if len(local_separado) > 3:
        return local_separado[3].strip()
    else:
        return pd.NA

def get_distancia_mais_proxima_sorotipo_genotipo(df_dist: pd.DataFrame, df_tratado_metadados: pd.DataFrame, ano: int, mes: int, cod_municipio: int,
                                                 genotipo: str, sorotipo: str, subtracao_mes: int) -> int:
    
    novo_ano, novo_mes = subtrair_meses(ano, mes, subtracao_mes)
    
    tmp_df = df_tratado_metadados[
        (df_tratado_metadados['Ano'] == novo_ano) &
        (df_tratado_metadados['Mes'] == novo_mes) &
        (df_tratado_metadados['Serotype'] == sorotipo) &
        (df_tratado_metadados['Genotype'] == genotipo)].copy()
            
    lista_municipios_dengue = tmp_df['Código Município Completo'].unique()

    min_dist = float('inf')

    for municipio in lista_municipios_dengue:
        if municipio == cod_municipio:
            min_dist = 0
            return min_dist
        if (municipio in df_dist['orig'].values):
            if cod_municipio in df_dist[(df_dist['orig'] == municipio)]['dest'].values:
                tmp_valor = df_dist[(df_dist['orig'] == cod_municipio) & (df_dist['dest'] == municipio)]['dist'].values
                if len(tmp_valor) < 1:
                    continue
                tmp_valor = tmp_valor[0]
                if tmp_valor < min_dist:
                    min_dist = tmp_valor
            else:
                if (municipio in df_dist['dest'].values):
                    if cod_municipio in df_dist[(df_dist['dest'] == municipio)]['orig'].values:
                        tmp_valor = df_dist[(df_dist['dest'] == municipio) & (df_dist['orig'] == cod_municipio)]['dist'].values
                        if len(tmp_valor) < 1:
                            continue
                        tmp_valor = tmp_valor[0]
                        if tmp_valor < min_dist:
                            min_dist = tmp_valor
                    else:
                        print(f'município {cod_municipio} não encontrado', lista_municipios_dengue)
                        return pd.NA
    if min_dist == float('inf'):
        return pd.NA
    return min_dist

def subtrair_meses(ano: int, mes: int, X: int):
    data = datetime(ano, mes, 1)

    nova_data = data-relativedelta(months=X)

    novo_ano = nova_data.year
    novo_mes = nova_data.month
    
    return novo_ano, novo_mes

def haversine_distance(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    # Converter de graus para radianos
    lat1, lon1, lat2, lon2 = map(radians, [lat1, lon1, lat2, lon2])
    # Fórmula de Haversine
    dlat = lat2 - lat1
    dlon = lon2 - lon1
    a = sin(dlat / 2)**2 + cos(lat1) * cos(lat2) * sin(dlon / 2)**2
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    # Raio da Terra em km (use 6371 para km, 3956 para milhas)
    r = 6371
    return c * r