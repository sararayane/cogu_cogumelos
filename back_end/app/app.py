from flask import Flask, jsonify, request
from functools import wraps
import logging
from banco import (
    conectar, adicionar_produto, listar_produtos,
    adicionar_fornecedor, listar_fornecedores,
    atualizar_quantidade_produto,
    deletar_produto, deletar_fornecedor
)

app = Flask(__name__)
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

def com_conexao(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        conn, cursor = conectar()
        if not conn or not cursor:
            return jsonify({'erro': 'Erro ao conectar ao banco de dados'}), 500
        try:
            return func(conn, cursor, *args, **kwargs)
        finally:
            cursor.close()
            conn.close()
    return wrapper

@app.route('/teste_conexao', methods=['GET'])
@com_conexao
def teste_conexao(conn, cursor):
    cursor.execute("SELECT 1")
    return jsonify({'mensagem': 'Conexão OK'}), 200

# ROTAS PRODUTOS
@app.route('/produtos', methods=['GET'])
@com_conexao
def get_produtos(conn, cursor):
    rows = listar_produtos(conn, cursor)
    cols = [d[0] for d in cursor.description]
    return jsonify([dict(zip(cols, r)) for r in rows]), 200

@app.route('/produtos', methods=['POST'])
@com_conexao
def post_produto(conn, cursor):
    dados = request.get_json()
    adicionar_produto(conn, cursor,
        dados['nome'], dados['categoria'],
        dados['descricao'], dados['preco'], dados['quantidade']
    )
    return jsonify({'mensagem': 'Produto adicionado!'}), 201

@app.route('/produtos/estoque', methods=['PUT'])
@com_conexao
def put_estoque(conn, cursor):
    dados = request.get_json()
    atualizar_quantidade_produto(
        conn, cursor,
        dados['nome_produto'], dados['operacao'], dados['quantidade']
    )
    return jsonify({'mensagem': 'Estoque atualizado!'}), 200

# ROTAS FORNECEDORES
@app.route('/fornecedor', methods=['GET'])
@com_conexao
def get_fornecedores(conn, cursor):
    rows = listar_fornecedores(conn, cursor)
    cols = [d[0] for d in cursor.description]
    return jsonify([dict(zip(cols, r)) for r in rows]), 200

@app.route('/fornecedor', methods=['POST'])
@com_conexao
def post_fornecedor(conn, cursor):
    dados = request.get_json()
    adicionar_fornecedor(conn, cursor,
        dados['nome'], dados['categoria'],
        dados['descricao'], dados['quantidade']
    )
    return jsonify({'mensagem': 'Fornecedor adicionado!'}), 201



if __name__ == '__main__':
    app.run(debug=True)