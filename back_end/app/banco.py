import mysql.connector
import logging
from config1.config import DATABASE_CONFIG

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def conectar():
    try:
        conexao = mysql.connector.connect(
            host=DATABASE_CONFIG['host'],
            database=DATABASE_CONFIG['database'],
            user=DATABASE_CONFIG['user'],
            password=DATABASE_CONFIG['password'],
            port=DATABASE_CONFIG['port']
        )
        cursor = conexao.cursor()
        logging.info("Conectado ao banco de dados com sucesso.")
        return conexao, cursor
    except mysql.connector.Error as e:
        logging.error("Erro ao conectar ao banco de dados: %s", e)
        return None, None