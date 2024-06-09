import pandas as pd
from datetime import datetime
from dateutil.relativedelta import relativedelta

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
