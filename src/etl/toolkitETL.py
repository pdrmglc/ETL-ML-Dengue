import urllib.request
import requests
from tqdm import tqdm
import os
import zipfile
import shutil
import pandas as pd
from dbfread import DBF
import subprocess



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