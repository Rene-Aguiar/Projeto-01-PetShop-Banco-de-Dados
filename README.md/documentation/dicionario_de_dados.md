# DICIONÁRIO DE DADOS ATUALIZADO — PROJETO PETSHOP
**Instituição:** Universidade Cidade de São Paulo - UNICID  
**Curso:** Engenharia de Software | **Disciplina:** Banco de Dados  
**Professor:** Clovis Jose Ramos Ferraro  
**Data de Referência:** 05/11/2026  

---

## SUMÁRIO DE TABELAS (INVENTÁRIO FÍSICO)
O banco de dados do PetShop é composto por **27 tabelas** normalizadas, utilizando o mecanismo **InnoDB** (MySQL 8.4.11), com integridade referencial mantida por **40 Chaves Estrangeiras (FK)**, **27 Restrições CHECK**, **15 Índices UNIQUE** e **18 Triggers de Negócio**.

1. [pessoa](#1-tabela-pessoa)
2. [pessoa_telefone](#2-tabela-pessoa_telefone)
3. [perfil_acesso](#3-tabela-perfil_acesso)
4. [cliente](#4-tabela-cliente)
5. [funcionario](#5-tabela-funcionario)
6. [animal](#6-tabela-animal)
7. [servico](#7-tabela-servico)
8. [agendamento](#8-tabela-agendamento)
9. [agendamento_servico](#9-tabela-agendamento_servico)
10. [atendimento](#10-tabela-atendimento)
11. [atendimento_servico](#11-tabela-atendimento_servico)
12. [transporte](#12-tabela-transporte)
13. [fornecedor](#13-tabela-fornecedor)
14. [fornecedor_telefone](#14-tabela-fornecedor_telefone)
15. [produto](#15-tabela-produto)
16. [produto_fornecedor](#16-tabela-produto_fornecedor)
17. [compra](#17-tabela-compra)
18. [item_compra](#18-tabela-item_compra)
19. [lote](#19-tabela-lote)
20. [venda](#20-tabela-venda)
21. [item_venda](#21-tabela-item_venda)
22. [baixa_lote](#22-tabela-baixa_lote)
23. [conta_receber](#23-tabela-conta_receber)
24. [conta_pagar](#24-tabela-conta_pagar)
25. [recebimento](#25-tabela-recebimento)
26. [pagamento](#26-tabela-pagamento)
27. [movimento_caixa](#27-tabela-movimento_caixa)

---

### 1. TABELA: `pessoa`
**Descrição:** Armazena o cadastro geral e dados de identificação/endereço de pessoas físicas no sistema (base compartilhada para clientes e funcionários).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_pessoa` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `nome` | `VARCHAR(120)` | Não | Não | Não | Nome completo da pessoa. |
| `cpf` | `CHAR(11)` | Não | Não | Não | CPF da pessoa. Restrição `UNIQUE`. |
| `email` | `VARCHAR(150)` | Sim | Não | Não | Endereço de e-mail de contato. |
| `end_logradouro` | `VARCHAR(150)` | Sim | Não | Não | Logradouro (rua, avenida, etc.). |
| `end_numero` | `VARCHAR(10)` | Sim | Não | Não | Número do endereço. |
| `end_complemento` | `VARCHAR(60)` | Sim | Não | Não | Complemento do endereço. |
| `end_bairro` | `VARCHAR(80)` | Sim | Não | Não | Bairro. |
| `end_cidade` | `VARCHAR(80)` | Sim | Não | Não | Cidade. |
| `end_uf` | `CHAR(2)` | Sim | Não | Não | Sigla do Estado (UF). |
| `end_cep` | `CHAR(8)` | Sim | Não | Não | Código de Endereçamento Postal (somente números). |

---

### 2. TABELA: `pessoa_telefone`
**Descrição:** Armazena os números de telefone associados a cada pessoa (relacionamento $1:N$).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_pessoa` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `pessoa(id_pessoa)`. Comportamento `ON DELETE CASCADE`. |
| `telefone` | `VARCHAR(20)` | Não | **Sim** | Não | Número de telefone formatado ou numérico. |

---

### 3. TABELA: `perfil_acesso`
**Descrição:** Define os perfis de acesso e privilégios dos funcionários no sistema (ex: GERENTE, ATENDENTE).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_perfil` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `nome` | `VARCHAR(60)` | Não | Não | Não | Nome do perfil. Restrição `UNIQUE`. |
| `descricao` | `VARCHAR(255)` | Sim | Não | Não | Descrição detalhada das permissões do perfil. |

---

### 4. TABELA: `cliente`
**Descrição:** Especialização da tabela `pessoa`. Registra as informações específicas dos clientes (tutores dos animais).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_pessoa` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `pessoa(id_pessoa)`. Herança $1:1$. |
| `data_cadastro` | `DATE` | Não | Não | Não | Data em que o cliente foi cadastrado no sistema. |
| `ativo` | `TINYINT(1)` | Não | Não | Não | Status de atividade (`1` = Ativo, `0` = Inativo). Valor `DEFAULT 1`. |

---

### 5. TABELA: `funcionario`
**Descrição:** Especialização da tabela `pessoa`. Armazena dados funcionais e de perfil de acesso dos colaboradores.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_pessoa` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `pessoa(id_pessoa)`. Herança $1:1$. |
| `id_perfil` | `BIGINT` | Não | Não | **Sim** | Ref: `perfil_acesso(id_perfil)`. |
| `cargo` | `VARCHAR(60)` | Não | Não | Não | Cargo ocupado pelo funcionário. |
| `data_admissao` | `DATE` | Não | Não | Não | Data de admissão do funcionário. |
| `ativo` | `TINYINT(1)` | Não | Não | Não | Status funcional (`1` = Ativo, `0` = Inativo). Valor `DEFAULT 1`. |

---

### 6. TABELA: `animal`
**Descrição:** Cadastra os pets pertencentes aos clientes para atendimento e histórico veterinário/estético.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_animal` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_cliente` | `BIGINT` | Não | Não | **Sim** | Ref: `cliente(id_pessoa)`. Proprietário do pet. |
| `nome` | `VARCHAR(80)` | Não | Não | Não | Nome do pet. |
| `especie` | `VARCHAR(40)` | Não | Não | Não | Espécie do animal (ex: Cachorro, Gato). |
| `raca` | `VARCHAR(60)` | Sim | Não | Não | Raça do animal. |
| `porte` | `VARCHAR(20)` | Sim | Não | Não | Porte do animal (Pequeno, Médio, Grande). |
| `data_nascimento` | `DATE` | Sim | Não | Não | Data de nascimento (Idade derivada na visão `vw_animal`). |
| `vacinacao_em_dia`| `TINYINT(1)` | Não | Não | Não | Indicador de vacinação (`1` = Sim, `0` = Não). `DEFAULT 0`. |
| `observacoes_saude`| `TEXT` | Sim | Não | Não | Histórico de saúde, alergias ou observações comportamentais. |
| `ativo` | `TINYINT(1)` | Não | Não | Não | Status do cadastro (`1` = Ativo, `0` = Inativo). `DEFAULT 1`. |

*Índice Único:* Restrição `animal_index_0` em (`id_animal`, `id_cliente`).

---

### 7. TABELA: `servico`
**Descrição:** Catálogo dos serviços oferecidos pelo petshop (ex: Banho, Tosa Higiênica, Corte de Unhas).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_servico` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `nome` | `VARCHAR(80)` | Não | Não | Não | Nome comercial do serviço. |
| `descricao` | `VARCHAR(255)` | Sim | Não | Não | Descrição detalhada dos procedimentos inclusos. |
| `preco_base` | `DECIMAL(10,2)` | Não | Não | Não | Preço padrão do serviço. `CHECK (preco_base >= 0)`. |
| `duracao_estimada_min` | `INT` | Sim | Não | Não | Tempo estimado em minutos. `CHECK (duracao_estimada_min > 0)`. |
| `ativo` | `TINYINT(1)` | Não | Não | Não | Status de comercialização (`1` = Ativo, `0` = Inativo). `DEFAULT 1`. |

---

### 8. TABELA: `agendamento`
**Descrição:** Registra a marcação prévia de atendimentos solicitados pelos clientes para seus pets.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_agendamento` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_cliente` | `BIGINT` | Não | Não | **Sim** | Ref: `cliente(id_pessoa)`. |
| `id_animal` | `BIGINT` | Não | Não | **Sim** | Ref: `animal(id_animal, id_cliente)` via chave composta. |
| `id_funcionario` | `BIGINT` | Não | Não | **Sim** | Ref: `funcionario(id_pessoa)`. Atendente/Agendador. |
| `data_hora_agendada`| `TIMESTAMP` | Não | Não | Não | Data e hora previstas para o serviço. |
| `status` | `VARCHAR(20)` | Não | Não | Não | Situação (ex: 'AGENDADO', 'CONCLUIDO', 'CANCELADO'). |
| `motivo_cancelamento`| `VARCHAR(255)`| Sim | Não | Não | Justificativa em caso de cancelamento. |
| `observacoes` | `TEXT` | Sim | Não | Não | Notas adicionais sobre o agendamento. |
| `data_registro` | `TIMESTAMP` | Não | Não | Não | Data/hora de inclusão do registro no banco. |

---

### 9. TABELA: `agendamento_servico`
**Descrição:** Tabela associativa ($N:M$) que relaciona um agendamento aos serviços solicitados.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_agendamento` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `agendamento(id_agendamento)`. |
| `id_servico` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `servico(id_servico)`. |

---

### 10. TABELA: `atendimento`
**Descrição:** Registra a execução real do serviço a partir de um agendamento prévio.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_atendimento` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_agendamento` | `BIGINT` | Não | Não | **Sim** | Ref: `agendamento(id_agendamento)`. Restrição `UNIQUE`. |
| `id_funcionario` | `BIGINT` | Não | Não | **Sim** | Ref: `funcionario(id_pessoa)`. Responsável pela execução. |
| `data_hora_inicio` | `TIMESTAMP` | Não | Não | Não | Momento de início do atendimento. |
| `data_hora_fim` | `TIMESTAMP` | Sim | Não | Não | Momento de conclusão. `CHECK (data_hora_fim >= data_hora_inicio)`. |
| `status` | `VARCHAR(20)` | Não | Não | Não | Status (ex: 'EM_ANDAMENTO', 'CONCLUIDO'). |
| `observacoes` | `TEXT` | Sim | Não | Não | Observações do profissional durante o atendimento. |

---

### 11. TABELA: `atendimento_servico`
**Descrição:** Detalha os serviços efetivamente executados em um atendimento, quantidades e valores cobrados.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_atendimento` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `atendimento(id_atendimento)`. |
| `id_servico` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `servico(id_servico)`. |
| `quantidade` | `INT` | Não | Não | Não | Quantidade de realizações. `CHECK (quantidade > 0)`. |
| `valor_cobrado` | `DECIMAL(10,2)`| Não | Não | Não | Valor cobrado na ocasião. `CHECK (valor_cobrado >= 0)`. |

---

### 12. TABELA: `transporte`
**Descrição:** Gerencia o serviço de leva e traz (táxi dog) vinculado a um atendimento.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_transporte` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_atendimento` | `BIGINT` | Não | Não | **Sim** | Ref: `atendimento(id_atendimento)`. Restrição `UNIQUE`. |
| `id_funcionario` | `BIGINT` | Sim | Não | **Sim** | Ref: `funcionario(id_pessoa)`. Motorista responsável. |
| `tipo` | `VARCHAR(30)` | Não | Não | Não | Tipo de transporte (ex: 'BUSCA', 'ENTREGA', 'AMBOS'). |
| `origem_logradouro`| `VARCHAR(150)`| Sim | Não | Não | Endereço de origem. |
| `origem_numero` | `VARCHAR(10)` | Sim | Não | Não | Número da origem. |
| `origem_complemento`|`VARCHAR(60)` | Sim | Não | Não | Complemento da origem. |
| `origem_bairro` | `VARCHAR(80)` | Sim | Não | Não | Bairro da origem. |
| `origem_cidade` | `VARCHAR(80)` | Sim | Não | Não | Cidade da origem. |
| `origem_uf` | `CHAR(2)` | Sim | Não | Não | UF da origem. |
| `origem_cep` | `CHAR(8)` | Sim | Não | Não | CEP da origem. |
| `destino_logradouro`|`VARCHAR(150)`| Sim | Não | Não | Endereço de destino. |
| `destino_numero` | `VARCHAR(10)` | Sim | Não | Não | Número do destino. |
| `destino_complemento`|`VARCHAR(60)`| Sim | Não | Não | Complemento do destino. |
| `destino_bairro` | `VARCHAR(80)` | Sim | Não | Não | Bairro do destino. |
| `destino_cidade` | `VARCHAR(80)` | Sim | Não | Não | Cidade do destino. |
| `destino_uf` | `CHAR(2)` | Sim | Não | Não | UF do destino. |
| `destino_cep` | `CHAR(8)` | Sim | Não | Não | CEP do destino. |
| `data_hora_prevista`|`TIMESTAMP` | Sim | Não | Não | Horário previsto para a realização do transporte. |
| `valor` | `DECIMAL(10,2)`| Não | Não | Não | Taxa cobrada pelo transporte. `CHECK (valor >= 0)`. |
| `status` | `VARCHAR(20)` | Não | Não | Não | Status do transporte (ex: 'PENDENTE', 'CONCLUIDO'). |

---

### 13. TABELA: `fornecedor`
**Descrição:** Armazena o cadastro das empresas fornecedoras de produtos e insumos.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_fornecedor` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `razao_social` | `VARCHAR(150)` | Não | Não | Não | Razão social oficial do fornecedor. |
| `nome_fantasia` | `VARCHAR(150)` | Sim | Não | Não | Nome comercial/fantasia. |
| `cnpj` | `CHAR(14)` | Não | Não | Não | CNPJ (14 dígitos). Restrição `UNIQUE`. |
| `email` | `VARCHAR(150)` | Sim | Não | Não | E-mail corporativo. |
| `end_logradouro` | `VARCHAR(150)` | Sim | Não | Não | Logradouro. |
| `end_numero` | `VARCHAR(10)` | Sim | Não | Não | Número do endereço. |
| `end_complemento` | `VARCHAR(60)` | Sim | Não | Não | Complemento. |
| `end_bairro` | `VARCHAR(80)` | Sim | Não | Não | Bairro. |
| `end_cidade` | `VARCHAR(80)` | Sim | Não | Não | Cidade. |
| `end_uf` | `CHAR(2)` | Sim | Não | Não | Estado (UF). |
| `end_cep` | `CHAR(8)` | Sim | Não | Não | CEP. |
| `ativo` | `TINYINT(1)` | Não | Não | Não | Status do cadastro (`1` = Ativo, `0` = Inativo). `DEFAULT 1`. |

---

### 14. TABELA: `fornecedor_telefone`
**Descrição:** Armazena os telefones de contato dos fornecedores ($1:N$).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_fornecedor` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `fornecedor(id_fornecedor)`. |
| `telefone` | `VARCHAR(20)` | Não | **Sim** | Não | Telefone de contato. |

---

### 15. TABELA: `produto`
**Descrição:** Cadastro dos produtos comercializados ou utilizados nos atendimentos operacionais do PetShop.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_produto` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `nome` | `VARCHAR(120)` | Não | Não | Não | Nome comercial do produto. |
| `descricao` | `VARCHAR(255)` | Sim | Não | Não | Especificações e detalhes do produto. |
| `categoria` | `VARCHAR(60)` | Sim | Não | Não | Categoria (ex: Alimentação, Higiene, Acessórios). |
| `unidade_medida` | `VARCHAR(10)` | Não | Não | Não | Unidade de comercialização (ex: 'UN', 'KG', 'CX'). |
| `preco_venda` | `DECIMAL(10,2)`| Não | Não | Não | Preço de venda praticado. `CHECK (preco_venda >= 0)`. |
| `estoque_minimo` | `INT` | Não | Não | Não | Nível de estoque para alerta. `CHECK (estoque_minimo >= 0)`. |
| `ativo` | `TINYINT(1)` | Não | Não | Não | Status (`1` = Ativo, `0` = Inativo). `DEFAULT 1`. |

---

### 16. TABELA: `produto_fornecedor`
**Descrição:** Tabela associativa ($N:M$) ligando os produtos aos fornecedores capacitados a vendê-los.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_fornecedor` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `fornecedor(id_fornecedor)`. |
| `id_produto` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `produto(id_produto)`. |

---

### 17. TABELA: `compra`
**Descrição:** Registra os pedidos de compra de produtos e mercadorias realizados com fornecedores.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_compra` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_fornecedor` | `BIGINT` | Não | Não | **Sim** | Ref: `fornecedor(id_fornecedor)`. |
| `id_funcionario` | `BIGINT` | Não | Não | **Sim** | Ref: `funcionario(id_pessoa)`. Comprador/Responsável. |
| `data_compra` | `DATE` | Não | Não | Não | Data de emissão da compra. |
| `status` | `VARCHAR(20)` | Não | Não | Não | Status da compra (ex: 'CONCLUIDA', 'PENDENTE'). |
| `numero_nota_fiscal`|`VARCHAR(30)` | Sim | Não | Não | Número do documento fiscal. |
| `observacoes` | `TEXT` | Sim | Não | Não | Notas adicionais do pedido. |

*Índice Único:* Restrição `compra_index_1` em (`id_fornecedor`, `numero_nota_fiscal`).

---

### 18. TABELA: `item_compra`
**Descrição:** Detalha os itens de produtos pertencentes a cada ordem de compra.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_item_compra` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_compra` | `BIGINT` | Não | Não | **Sim** | Ref: `compra(id_compra)`. |
| `id_produto` | `BIGINT` | Não | Não | **Sim** | Ref: `produto(id_produto)`. |
| `quantidade_comprada`|`INT` | Não | Não | Não | Qtd de itens adquiridos. `CHECK (quantidade_comprada > 0)`. |
| `custo_unitario` | `DECIMAL(10,2)`| Não | Não | Não | Valor unitário pago. `CHECK (custo_unitario >= 0)`. |
| `subtotal` | `DECIMAL(12,2)`| Sim | Não | Não | Campo gerado (`STORED`): `quantidade_comprada * custo_unitario`. |

*Índice Único:* Restrição `item_compra_index_2` em (`id_compra`, `id_produto`).  
*Triggers de Proteção:* `trg_item_compra_before_update` (Impede alterar chaves/custo e reduzir quantidade abaixo dos lotes já criados).

---

### 19. TABELA: `lote`
**Descrição:** Armazena os lotes de entrada física de produtos recebidos a partir de compras efetuadas.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_lote` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_item_compra` | `BIGINT` | Não | Não | **Sim** | Ref: `item_compra(id_item_compra)`. |
| `codigo_lote` | `VARCHAR(40)` | Não | Não | Não | Código de rastreabilidade do lote do fabricante. |
| `data_entrada` | `DATE` | Não | Não | Não | Data em que o lote deu entrada no estoque. |
| `data_validade` | `DATE` | Sim | Não | Não | Data de validade. `CHECK (data_validade >= data_entrada)`. |
| `quantidade_recebida`|`INT` | Não | Não | Não | Quantidade de itens recebidos neste lote. `CHECK (quantidade_recebida > 0)`. |

*Índice Único:* Restrição `lote_index_3` em (`id_item_compra`, `codigo_lote`).  
*Triggers de Proteção:* `trg_lote_before_insert`, `trg_lote_before_update` (Valida se lote não excede compra e impede reduzir abaixo do que já foi baixado).

---

### 20. TABELA: `venda`
**Descrição:** Registra os cabeçalhos de vendas comerciais efetuadas aos clientes (balcão ou vinculadas a um atendimento).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_venda` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_cliente` | `BIGINT` | Não | Não | **Sim** | Ref: `cliente(id_pessoa)`. Comprador. |
| `id_funcionario` | `BIGINT` | Não | Não | **Sim** | Ref: `funcionario(id_pessoa)`. Vendedor. |
| `id_atendimento` | `BIGINT` | Sim | Não | **Sim** | Ref: `atendimento(id_atendimento)`. Restrição `UNIQUE`. |
| `data_hora_venda` | `TIMESTAMP` | Não | Não | Não | Data e hora em que a venda foi efetuada. |
| `status` | `VARCHAR(20)` | Não | Não | Não | Status (ex: 'CONCLUIDA', 'CANCELADA'). |
| `desconto_total` | `DECIMAL(10,2)`| Não | Não | Não | Desconto geral aplicado à venda. `CHECK (desconto_total >= 0)`. |
| `observacoes` | `TEXT` | Sim | Não | Não | Notas explicativas da venda. |

---

### 21. TABELA: `item_venda`
**Descrição:** Especifica cada produto constante em uma venda efetuada.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_item_venda` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_venda` | `BIGINT` | Não | Não | **Sim** | Ref: `venda(id_venda)`. |
| `id_produto` | `BIGINT` | Não | Não | **Sim** | Ref: `produto(id_produto)`. |
| `quantidade` | `INT` | Não | Não | Não | Quantidade comercializada. `CHECK (quantidade > 0)`. |
| `preco_unitario` | `DECIMAL(10,2)`| Não | Não | Não | Preço praticado por unidade. `CHECK (preco_unitario >= 0)`. |
| `desconto_item` | `DECIMAL(10,2)`| Não | Não | Não | Abatimento no item. `CHECK (desconto_item <= quantidade * preco_unitario)`. |
| `subtotal` | `DECIMAL(12,2)`| Sim | Não | Não | Campo gerado (`STORED`): `(quantidade * preco_unitario) - desconto_item`. |

*Índice Único:* Restrição `item_venda_index_4` em (`id_venda`, `id_produto`).  
*Triggers de Proteção:* `trg_item_venda_before_update` (Impede alterar chaves/valores pós-baixa de estoque e proíbe reduzir quantidade vendida abaixo das baixas realizadas).

---

### 22. TABELA: `baixa_lote`
**Descrição:** Tabela de junção que realiza o consumo físico do estoque, vinculando o produto vendido no `item_venda` ao seu respectivo `lote` de origem.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_item_venda` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `item_venda(id_item_venda)`. |
| `id_lote` | `BIGINT` | Não | **Sim** | **Sim** | Ref: `lote(id_lote)`. |
| `quantidade_baixada`|`INT` | Não | Não | Não | Qtd subtraída do lote. `CHECK (quantidade_baixada > 0)`. |
| `data_hora_baixa` | `TIMESTAMP` | Não | Não | Não | Data e hora em que o estoque foi consumido. |

*Triggers de Proteção:* `trg_baixa_lote_before_insert`, `trg_baixa_lote_before_update` (Valida correspondência entre o produto do lote e o produto vendido; impede dar baixa maior que a quantidade do lote ou maior que a quantidade vendida).

---

### 23. TABELA: `conta_receber`
**Descrição:** Registra as parcelas financeiras a serem recebidas pelo petshop decorrentes das vendas efetuadas.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_conta_receber` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_venda` | `BIGINT` | Não | Não | **Sim** | Ref: `venda(id_venda)`. |
| `numero_parcela` | `INT` | Não | Não | Não | Número ordinal da parcela. `CHECK (numero_parcela > 0)`. |
| `valor` | `DECIMAL(12,2)`| Não | Não | Não | Valor nominal da parcela. `CHECK (valor > 0)`. |
| `data_emissao` | `DATE` | Não | Não | Não | Data de lançamento do título. |
| `data_vencimento` | `DATE` | Não | Não | Não | Data estipulada para pagamento. `CHECK (data_vencimento >= data_emissao)`. |
| `status` | `VARCHAR(20)` | Não | Não | Não | Situação financeira (ex: 'PENDENTE', 'QUITADO'). |

*Índice Único:* Restrição `conta_receber_index_5` em (`id_venda`, `numero_parcela`).  
*Triggers de Proteção:* `trg_conta_receber_before_update` (Impede alterar venda/parcela e proíbe diminuir o valor da conta abaixo do montante já recebido).

---

### 24. TABELA: `conta_pagar`
**Descrição:** Registra os títulos e parcelas financeiras que o petshop deve pagar aos fornecedores por conta de compras efetuadas.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_conta_pagar` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_compra` | `BIGINT` | Não | Não | **Sim** | Ref: `compra(id_compra)`. |
| `numero_parcela` | `INT` | Não | Não | Não | Número ordinal da parcela. `CHECK (numero_parcela > 0)`. |
| `valor` | `DECIMAL(12,2)`| Não | Não | Não | Valor nominal a pagar. `CHECK (valor > 0)`. |
| `data_emissao` | `DATE` | Não | Não | Não | Data de lançamento da obrigação. |
| `data_vencimento` | `DATE` | Não | Não | Não | Data limite para pagamento. `CHECK (data_vencimento >= data_emissao)`. |
| `status` | `VARCHAR(20)` | Não | Não | Não | Situação financeira (ex: 'PENDENTE', 'QUITADO'). |

*Índice Único:* Restrição `conta_pagar_index_6` em (`id_compra`, `numero_parcela`).  
*Triggers de Proteção:* `trg_conta_pagar_before_update` (Impede alterar compra/parcela e proíbe reduzir o valor da conta abaixo do montante já pago).

---

### 25. TABELA: `recebimento`
**Descrição:** Registra os fluxos financeiros de entrada (pagamentos efetuados pelos clientes referente a uma `conta_receber`).

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_recebimento` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_conta_receber` | `BIGINT` | Não | Não | **Sim** | Ref: `conta_receber(id_conta_receber)`. |
| `id_funcionario` | `BIGINT` | Não | Não | **Sim** | Ref: `funcionario(id_pessoa)`. operador de caixa. |
| `data_hora` | `TIMESTAMP` | Não | Não | Não | Momento do recebimento. |
| `valor_recebido` | `DECIMAL(12,2)`| Não | Não | Não | Valor pago pelo cliente. `CHECK (valor_recebido > 0)`. |
| `forma_pagamento` | `VARCHAR(30)` | Não | Não | Não | Meio financeiro (ex: 'DINHEIRO', 'PIX', 'CARTÃO_CRÉDITO'). |

*Triggers de Integração:*  
- `trg_recebimento_before_insert` / `trg_recebimento_before_update`: Valida se o montante acumulado de recebimentos não ultrapassa o valor total da `conta_receber`.  
- `trg_recebimento_after_insert`: Gera automaticamente registro de `ENTRADA` na tabela `movimento_caixa`.  
- `trg_recebimento_after_update`: Atualiza automaticamente a movimentação de caixa correspondente.  
- `trg_recebimento_before_delete`: Exclui a entrada do caixa em caso de estorno do recebimento.

---

### 26. TABELA: `pagamento`
**Descrição:** Registra as baixas e pagamentos executados pelo petshop para quitar uma `conta_pagar`.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_pagamento` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_conta_pagar` | `BIGINT` | Não | Não | **Sim** | Ref: `conta_pagar(id_conta_pagar)`. |
| `id_funcionario` | `BIGINT` | Não | Não | **Sim** | Ref: `funcionario(id_pessoa)`. Operador financeiro. |
| `data_hora` | `TIMESTAMP` | Não | Não | Não | Momento do desembolso. |
| `valor_pago` | `DECIMAL(12,2)`| Não | Não | Não | Valor liquidado. `CHECK (valor_pago > 0)`. |
| `forma_pagamento` | `VARCHAR(30)` | Não | Não | Não | Forma de pagamento utilizada (ex: 'PIX', 'TED', 'BOLETO'). |

*Triggers de Integração:*  
- `trg_pagamento_before_insert` / `trg_pagamento_before_update`: Valida se o somatório dos pagamentos não ultrapassa o valor da `conta_pagar`.  
- `trg_pagamento_after_insert`: Cria automaticamente uma movimentação de `SAIDA` na tabela `movimento_caixa`.  
- `trg_pagamento_after_update`: Sincroniza as alterações do pagamento com o `movimento_caixa`.  
- `trg_pagamento_before_delete`: Exclui a movimentação do caixa associada em caso de cancelamento/deletabilidade.

---

### 27. TABELA: `movimento_caixa`
**Descrição:** Livro Caixa central do petshop. Registra todas as entradas e saídas de capital financeiro no estabelecimento.

| Atributo | Tipo de Dado | Nulo? | PK | FK | Referência / Regras / Observações |
| :--- | :--- | :---: | :---: | :---: | :--- |
| `id_movimento` | `BIGINT` | Não | **Sim** | Não | Identificador único (`AUTO_INCREMENT`). |
| `id_funcionario` | `BIGINT` | Não | Não | **Sim** | Ref: `funcionario(id_pessoa)`. Responsável pelo caixa. |
| `id_recebimento` | `BIGINT` | Sim | Não | **Sim** | Ref: `recebimento(id_recebimento)`. Restrição `UNIQUE`. |
| `id_pagamento` | `BIGINT` | Sim | Não | **Sim** | Ref: `pagamento(id_pagamento)`. Restrição `UNIQUE`. |
| `data_hora` | `TIMESTAMP` | Não | Não | Não | Data e hora exata da movimentação. |
| `tipo` | `VARCHAR(10)` | Não | Não | Não | Tipo de fluxo ('ENTRADA' ou 'SAIDA'). |
| `valor` | `DECIMAL(12,2)`| Não | Não | Não | Valor movimentado. `CHECK (valor > 0)`. |
| `descricao` | `VARCHAR(255)`| Sim | Não | Não | Histórico resumido da operação. |

*Regra CHECK Combinada (`chk_movimento_origem_tipo`):*  
Exige que, se `id_recebimento IS NOT NULL`, `id_pagamento IS NULL` e `tipo = 'ENTRADA'`. Se `id_pagamento IS NOT NULL`, `id_recebimento IS NULL` e `tipo = 'SAIDA'`.