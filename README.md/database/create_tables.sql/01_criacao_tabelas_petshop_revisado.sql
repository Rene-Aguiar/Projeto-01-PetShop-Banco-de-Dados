CREATE TABLE `pessoa` (
  `id_pessoa` bigint PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `cpf` char(11) UNIQUE NOT NULL,
  `email` varchar(150),
  `end_logradouro` varchar(150),
  `end_numero` varchar(10),
  `end_complemento` varchar(60),
  `end_bairro` varchar(80),
  `end_cidade` varchar(80),
  `end_uf` char(2),
  `end_cep` char(8)
);

CREATE TABLE `pessoa_telefone` (
  `id_pessoa` bigint NOT NULL,
  `telefone` varchar(20) NOT NULL,
  PRIMARY KEY (`id_pessoa`, `telefone`)
);

CREATE TABLE `perfil_acesso` (
  `id_perfil` bigint PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(60) UNIQUE NOT NULL,
  `descricao` varchar(255)
);

CREATE TABLE `cliente` (
  `id_pessoa` bigint PRIMARY KEY,
  `data_cadastro` date NOT NULL,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `funcionario` (
  `id_pessoa` bigint PRIMARY KEY,
  `id_perfil` bigint NOT NULL,
  `cargo` varchar(60) NOT NULL,
  `data_admissao` date NOT NULL,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `animal` (
  `id_animal` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_cliente` bigint NOT NULL,
  `nome` varchar(80) NOT NULL,
  `especie` varchar(40) NOT NULL,
  `raca` varchar(60),
  `porte` varchar(20),
  `data_nascimento` date,
  `vacinacao_em_dia` boolean NOT NULL DEFAULT false,
  `observacoes_saude` text,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `servico` (
  `id_servico` bigint PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(80) NOT NULL,
  `descricao` varchar(255),
  `preco_base` numeric(10,2) NOT NULL,
  `duracao_estimada_min` int,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `agendamento` (
  `id_agendamento` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_cliente` bigint NOT NULL,
  `id_animal` bigint NOT NULL,
  `id_funcionario` bigint NOT NULL,
  `data_hora_agendada` timestamp NOT NULL,
  `status` varchar(20) NOT NULL,
  `motivo_cancelamento` varchar(255),
  `observacoes` text,
  `data_registro` timestamp NOT NULL
);

CREATE TABLE `agendamento_servico` (
  `id_agendamento` bigint NOT NULL,
  `id_servico` bigint NOT NULL,
  PRIMARY KEY (`id_agendamento`, `id_servico`)
);

CREATE TABLE `atendimento` (
  `id_atendimento` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_agendamento` bigint UNIQUE NOT NULL,
  `id_funcionario` bigint NOT NULL,
  `data_hora_inicio` timestamp NOT NULL,
  `data_hora_fim` timestamp,
  `status` varchar(20) NOT NULL,
  `observacoes` text
);

CREATE TABLE `atendimento_servico` (
  `id_atendimento` bigint NOT NULL,
  `id_servico` bigint NOT NULL,
  `quantidade` int NOT NULL,
  `valor_cobrado` numeric(10,2) NOT NULL,
  PRIMARY KEY (`id_atendimento`, `id_servico`)
);

CREATE TABLE `transporte` (
  `id_transporte` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_atendimento` bigint UNIQUE NOT NULL,
  `id_funcionario` bigint,
  `tipo` varchar(30) NOT NULL,
  `origem_logradouro` varchar(150),
  `origem_numero` varchar(10),
  `origem_complemento` varchar(60),
  `origem_bairro` varchar(80),
  `origem_cidade` varchar(80),
  `origem_uf` char(2),
  `origem_cep` char(8),
  `destino_logradouro` varchar(150),
  `destino_numero` varchar(10),
  `destino_complemento` varchar(60),
  `destino_bairro` varchar(80),
  `destino_cidade` varchar(80),
  `destino_uf` char(2),
  `destino_cep` char(8),
  `data_hora_prevista` timestamp,
  `valor` numeric(10,2) NOT NULL,
  `status` varchar(20) NOT NULL
);

CREATE TABLE `fornecedor` (
  `id_fornecedor` bigint PRIMARY KEY AUTO_INCREMENT,
  `razao_social` varchar(150) NOT NULL,
  `nome_fantasia` varchar(150),
  `cnpj` char(14) UNIQUE NOT NULL,
  `email` varchar(150),
  `end_logradouro` varchar(150),
  `end_numero` varchar(10),
  `end_complemento` varchar(60),
  `end_bairro` varchar(80),
  `end_cidade` varchar(80),
  `end_uf` char(2),
  `end_cep` char(8),
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `fornecedor_telefone` (
  `id_fornecedor` bigint NOT NULL,
  `telefone` varchar(20) NOT NULL,
  PRIMARY KEY (`id_fornecedor`, `telefone`)
);

CREATE TABLE `produto` (
  `id_produto` bigint PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(120) NOT NULL,
  `descricao` varchar(255),
  `categoria` varchar(60),
  `unidade_medida` varchar(10) NOT NULL,
  `preco_venda` numeric(10,2) NOT NULL,
  `estoque_minimo` int NOT NULL,
  `ativo` boolean NOT NULL DEFAULT true
);

CREATE TABLE `produto_fornecedor` (
  `id_fornecedor` bigint NOT NULL,
  `id_produto` bigint NOT NULL,
  PRIMARY KEY (`id_fornecedor`, `id_produto`)
);

CREATE TABLE `compra` (
  `id_compra` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_fornecedor` bigint NOT NULL,
  `id_funcionario` bigint NOT NULL,
  `data_compra` date NOT NULL,
  `status` varchar(20) NOT NULL,
  `numero_nota_fiscal` varchar(30),
  `observacoes` text
);

CREATE TABLE `item_compra` (
  `id_item_compra` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_compra` bigint NOT NULL,
  `id_produto` bigint NOT NULL,
  `quantidade_comprada` int NOT NULL,
  `custo_unitario` numeric(10,2) NOT NULL,
  `subtotal` numeric(12,2) COMMENT 'gerado: quantidade_comprada * custo_unitario'
);

CREATE TABLE `lote` (
  `id_lote` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_item_compra` bigint NOT NULL,
  `codigo_lote` varchar(40) NOT NULL,
  `data_entrada` date NOT NULL,
  `data_validade` date,
  `quantidade_recebida` int NOT NULL
);

CREATE TABLE `venda` (
  `id_venda` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_cliente` bigint NOT NULL,
  `id_funcionario` bigint NOT NULL,
  `id_atendimento` bigint UNIQUE,
  `data_hora_venda` timestamp NOT NULL,
  `status` varchar(20) NOT NULL,
  `desconto_total` numeric(10,2) NOT NULL,
  `observacoes` text
);

CREATE TABLE `item_venda` (
  `id_item_venda` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_venda` bigint NOT NULL,
  `id_produto` bigint NOT NULL,
  `quantidade` int NOT NULL,
  `preco_unitario` numeric(10,2) NOT NULL,
  `desconto_item` numeric(10,2) NOT NULL,
  `subtotal` numeric(12,2) COMMENT 'gerado: quantidade * preco_unitario - desconto_item'
);

CREATE TABLE `baixa_lote` (
  `id_item_venda` bigint NOT NULL,
  `id_lote` bigint NOT NULL,
  `quantidade_baixada` int NOT NULL,
  `data_hora_baixa` timestamp NOT NULL,
  PRIMARY KEY (`id_item_venda`, `id_lote`)
);

CREATE TABLE `conta_receber` (
  `id_conta_receber` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_venda` bigint NOT NULL,
  `numero_parcela` int NOT NULL,
  `valor` numeric(12,2) NOT NULL,
  `data_emissao` date NOT NULL,
  `data_vencimento` date NOT NULL,
  `status` varchar(20) NOT NULL
);

CREATE TABLE `conta_pagar` (
  `id_conta_pagar` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_compra` bigint NOT NULL,
  `numero_parcela` int NOT NULL,
  `valor` numeric(12,2) NOT NULL,
  `data_emissao` date NOT NULL,
  `data_vencimento` date NOT NULL,
  `status` varchar(20) NOT NULL
);

CREATE TABLE `recebimento` (
  `id_recebimento` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_conta_receber` bigint NOT NULL,
  `data_hora` timestamp NOT NULL,
  `valor_recebido` numeric(12,2) NOT NULL,
  `forma_pagamento` varchar(30) NOT NULL
);

CREATE TABLE `pagamento` (
  `id_pagamento` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_conta_pagar` bigint NOT NULL,
  `data_hora` timestamp NOT NULL,
  `valor_pago` numeric(12,2) NOT NULL,
  `forma_pagamento` varchar(30) NOT NULL
);

CREATE TABLE `movimento_caixa` (
  `id_movimento` bigint PRIMARY KEY AUTO_INCREMENT,
  `id_funcionario` bigint NOT NULL,
  `id_recebimento` bigint UNIQUE,
  `id_pagamento` bigint UNIQUE,
  `data_hora` timestamp NOT NULL,
  `tipo` varchar(10) NOT NULL COMMENT 'ENTRADA ou SAIDA',
  `valor` numeric(12,2) NOT NULL,
  `descricao` varchar(255)
);

CREATE UNIQUE INDEX `animal_index_0` ON `animal` (`id_animal`, `id_cliente`);

CREATE UNIQUE INDEX `compra_index_1` ON `compra` (`id_fornecedor`, `numero_nota_fiscal`);

CREATE UNIQUE INDEX `item_compra_index_2` ON `item_compra` (`id_compra`, `id_produto`);

CREATE UNIQUE INDEX `lote_index_3` ON `lote` (`id_item_compra`, `codigo_lote`);

CREATE UNIQUE INDEX `item_venda_index_4` ON `item_venda` (`id_venda`, `id_produto`);

CREATE UNIQUE INDEX `conta_receber_index_5` ON `conta_receber` (`id_venda`, `numero_parcela`);

CREATE UNIQUE INDEX `conta_pagar_index_6` ON `conta_pagar` (`id_compra`, `numero_parcela`);

ALTER TABLE `animal` COMMENT = 'idade é derivada de data_nascimento (view vw_animal)';

ALTER TABLE `atendimento` COMMENT = 'valor_total_servicos é derivado (view vw_atendimento)';

ALTER TABLE `produto` COMMENT = 'estoque_atual é derivado (view vw_produto)';

ALTER TABLE `compra` COMMENT = 'valor_total é derivado (view vw_compra)';

ALTER TABLE `lote` COMMENT = 'quantidade_atual é derivada (view vw_lote)';

ALTER TABLE `venda` COMMENT = 'valor_total é derivado (view vw_venda)';

ALTER TABLE `conta_receber` COMMENT = 'valor_recebido e saldo_devedor são derivados (view vw_conta_receber)';

ALTER TABLE `conta_pagar` COMMENT = 'valor_pago e saldo_devedor são derivados (view vw_conta_pagar)';

ALTER TABLE `pessoa_telefone` ADD FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`) ON DELETE CASCADE;

ALTER TABLE `funcionario` ADD FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`);

ALTER TABLE `cliente` ADD FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa` (`id_pessoa`);

ALTER TABLE `funcionario` ADD FOREIGN KEY (`id_perfil`) REFERENCES `perfil_acesso` (`id_perfil`);

ALTER TABLE `animal` ADD FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_pessoa`);

ALTER TABLE `agendamento` ADD FOREIGN KEY (`id_animal`, `id_cliente`) REFERENCES `animal` (`id_animal`, `id_cliente`);

ALTER TABLE `agendamento` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_pessoa`);

ALTER TABLE `agendamento_servico` ADD FOREIGN KEY (`id_agendamento`) REFERENCES `agendamento` (`id_agendamento`);

ALTER TABLE `agendamento_servico` ADD FOREIGN KEY (`id_servico`) REFERENCES `servico` (`id_servico`);

ALTER TABLE `atendimento` ADD FOREIGN KEY (`id_agendamento`) REFERENCES `agendamento` (`id_agendamento`);

ALTER TABLE `atendimento` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_pessoa`);

ALTER TABLE `atendimento_servico` ADD FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`);

ALTER TABLE `atendimento_servico` ADD FOREIGN KEY (`id_servico`) REFERENCES `servico` (`id_servico`);

ALTER TABLE `transporte` ADD FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`);

ALTER TABLE `transporte` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_pessoa`);

ALTER TABLE `fornecedor_telefone` ADD FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`);

ALTER TABLE `produto_fornecedor` ADD FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`);

ALTER TABLE `produto_fornecedor` ADD FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);

ALTER TABLE `compra` ADD FOREIGN KEY (`id_fornecedor`) REFERENCES `fornecedor` (`id_fornecedor`);

ALTER TABLE `compra` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_pessoa`);

ALTER TABLE `item_compra` ADD FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`);

ALTER TABLE `item_compra` ADD FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);

ALTER TABLE `lote` ADD FOREIGN KEY (`id_item_compra`) REFERENCES `item_compra` (`id_item_compra`);

ALTER TABLE `venda` ADD FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_pessoa`);

ALTER TABLE `venda` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_pessoa`);

ALTER TABLE `venda` ADD FOREIGN KEY (`id_atendimento`) REFERENCES `atendimento` (`id_atendimento`);

ALTER TABLE `item_venda` ADD FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`);

ALTER TABLE `item_venda` ADD FOREIGN KEY (`id_produto`) REFERENCES `produto` (`id_produto`);

ALTER TABLE `baixa_lote` ADD FOREIGN KEY (`id_item_venda`) REFERENCES `item_venda` (`id_item_venda`);

ALTER TABLE `baixa_lote` ADD FOREIGN KEY (`id_lote`) REFERENCES `lote` (`id_lote`);

ALTER TABLE `conta_receber` ADD FOREIGN KEY (`id_venda`) REFERENCES `venda` (`id_venda`);

ALTER TABLE `conta_pagar` ADD FOREIGN KEY (`id_compra`) REFERENCES `compra` (`id_compra`);

ALTER TABLE `recebimento` ADD FOREIGN KEY (`id_conta_receber`) REFERENCES `conta_receber` (`id_conta_receber`);

ALTER TABLE `pagamento` ADD FOREIGN KEY (`id_conta_pagar`) REFERENCES `conta_pagar` (`id_conta_pagar`);

ALTER TABLE `movimento_caixa` ADD FOREIGN KEY (`id_funcionario`) REFERENCES `funcionario` (`id_pessoa`);

ALTER TABLE `movimento_caixa` ADD FOREIGN KEY (`id_recebimento`) REFERENCES `recebimento` (`id_recebimento`);

ALTER TABLE `movimento_caixa` ADD FOREIGN KEY (`id_pagamento`) REFERENCES `pagamento` (`id_pagamento`);

ALTER TABLE `agendamento` ADD FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_pessoa`);
