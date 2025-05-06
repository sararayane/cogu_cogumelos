CREATE TABLE IF NOT EXISTS produtos (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  categoria VARCHAR(50),
  descricao TEXT,
  preco DECIMAL(10,2),
  quantidade INT
);

CREATE TABLE IF NOT EXISTS fornecedor (
  codigo INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100),
  categoria VARCHAR(50),
  descricao TEXT,
  quantidade INT
);