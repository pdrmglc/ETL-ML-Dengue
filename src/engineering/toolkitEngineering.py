from typing import Tuple
from dotenv import load_dotenv
import os
import psycopg2
from psycopg2.extensions import cursor, connection
from psycopg2 import errors
import csv


def conectar_banco(caminho_dotenv: str) -> Tuple[cursor, connection]:

    # Carregar as variáveis do arquivo .env
    load_dotenv(caminho_dotenv)

    # Configurar as credenciais Postgres
    db_user = os.getenv('DB_USER')
    db_password = os.getenv('DB_PASSWORD')
    db_host = os.getenv('DB_HOST')
    db_port = os.getenv('DB_PORT')
    db_name = os.getenv('DB_NAME')

    # Conexão com o banco de dados PostgreSQL
    conn = psycopg2.connect(
        dbname=db_name,
        user=db_user,
        password=db_password,
        host=db_host,
        port=db_port
    )
    cursor = conn.cursor()

    return cursor, conn


def inserir_no_banco(
        cursor: cursor, conn: connection, caminho_arquivo: str,
        nome_tabela: str, delimiter: str, add_id: bool,
        diretorio_dotenv: str, encoding: str = 'utf-8') -> None:

    # Abrir o arquivo delimitado
    with open(caminho_arquivo, 'r', encoding=encoding) as f:
        reader = csv.reader(f, delimiter=delimiter)
        colunas = next(reader)  # Lê o cabeçalho do arquivo

        # Se add_id for True, não incluímos a coluna de ID autoincremental
        if not add_id:
            colunas_str = ', '.join(colunas)
        else:
            colunas_str = 'id, ' + ', '.join(colunas)  # Adiciona 'id' como a primeira coluna

        placeholders = ', '.join(['%s'] * len(colunas))

        # Inserir cada linha do arquivo na tabela
        for row in reader:
            row = [None if campo == '' else campo for campo in row]
            try:
                if cursor.closed:
                    cursor, conn = conectar_banco(diretorio_dotenv)

                cursor.execute(
                    f'INSERT INTO "{nome_tabela}" ({colunas_str}) VALUES ({placeholders})',
                    row
                )
            except errors.UniqueViolation as e:
                print(f"Aviso: Chave já existente para a linha {row}. Pulando inserção.")
                conn.rollback()  # Desfaz apenas a transação atual para continuar com as próximas
            except Exception as e:
                print(f"Erro ao inserir a linha {row}: {e}")
                conn.rollback()  # Desfaz apenas a transação atual para continuar com as próximas

    # Confirmar as mudanças no banco de dados
    conn.commit()

    # Fechar o cursor e a conexão
    cursor.close()
    conn.close()