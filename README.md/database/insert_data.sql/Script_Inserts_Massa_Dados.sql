-- 1. pessoa
INSERT INTO `pessoa` VALUES (6,'Marcos Almeida','90000000001','marcos.almeida@petvida.com.br','Rua das Flores','125',NULL,'Vila Gomes Cardim','São Paulo','SP','03309000'),(7,'Camila Rodrigues','90000000002','camila.rodrigues@email.com','Rua Serra de Japi','450',NULL,'Tatuapé','São Paulo','SP','03309001'),(13,'Juliana Martins','12345678901','juliana.martins@email.com','Rua Cantagalo','320',NULL,'Tatuapé','São Paulo','SP','03319000'),(14,'Roberto Santos','23456789012','roberto.santos@email.com','Rua Emília Marengo','85',NULL,'Vila Regente Feijó','São Paulo','SP','03336000'),(15,'Fernanda Oliveira','34567890123','fernanda.oliveira@email.com','Rua Itapura','700',NULL,'Tatuapé','São Paulo','SP','03310000'),(16,'Andre Ferreira','45678901234','andre.ferreira@petvida.com.br','Rua Apucarana','210',NULL,'Tatuapé','São Paulo','SP','03311000');

-- 2. perfil_acesso
INSERT INTO `perfil_acesso` VALUES (6,'GERENTE','Gerenciamento administrativo do PetShop'),(7,'ATENDENTE','Atendimento e operação do PetShop');

-- 3. servico
INSERT INTO `servico` VALUES (1,'Banho Completo','Banho com shampoo neutro, secagem e escovação',60.00,45,1),(2,'Tosa Higienica','Tosa das regiões de higiene do animal',45.00,30,1),(3,'Corte de Unhas','Corte e acabamento das unhas do animal',20.00,15,1),(4,'Banho e Tosa','Banho completo acompanhado de tosa',95.00,90,1);

-- 4. produto
INSERT INTO `produto` VALUES (7,'Ração Premium para Cães','Ração premium para cães adultos, vendida por quilo','Alimentação','KG',50.00,2,1),(8,'Shampoo Neutro Pet','Shampoo neutro para higiene de cães e gatos','Higiene','UN',30.00,1,1),(9,'Areia Higienica para Gatos','Areia higiênica para gatos, embalagem de 4 kg','Higiene','UN',32.90,3,1),(10,'Coleira Ajustavel para Caes','Coleira ajustável de nylon para cães','Acessorios','UN',24.90,2,1),(11,'Petisco para Caes','Petisco sabor carne para cães','Alimentacao','UN',15.90,5,1);

-- 5. fornecedor
INSERT INTO `fornecedor` VALUES (6,'Distribuidora Pet Brasil LTDA','Pet Brasil Distribuidora','90000000000100','vendas@petbrasil.com.br','Avenida Aricanduva','1500',NULL,'Aricanduva','São Paulo','SP','03527000',1),(10,'Mundo Animal Produtos LTDA','Mundo Animal','56789012000199','contato@mundoanimal.com.br','Rua do Oratorio','900',NULL,'Mooca','São Paulo','SP','03117000',1);

-- 6. cliente
INSERT INTO `cliente` VALUES (7,'2026-11-04',1),(13,'2026-11-05',1),(14,'2026-11-05',1),(15,'2026-11-05',1);

-- 7. funcionario
INSERT INTO `funcionario` VALUES (6,7,'Atendente','2026-11-04',1),(16,6,'Gerente','2026-11-05',1);

-- 8. fornecedor_telefone
INSERT INTO `fornecedor_telefone` VALUES (6,'(11) 3333-4455');

-- 9. pessoa_telefone
INSERT INTO `pessoa_telefone` VALUES (13,'(11) 98765-4321'),(14,'(11) 97654-3210'),(15,'(11) 96543-2109'),(16,'(11) 95432-1098');

-- 10. produto_fornecedor
INSERT INTO `produto_fornecedor` VALUES (6,7),(6,8),(10,9),(10,10),(10,11);

-- 11. animal
INSERT INTO `animal` VALUES (1,7,'Rex','Cachorro','Labrador','Médio','2022-01-10',1,'Animal dócil e sociável',1),(2,13,'Luna','Gato','Siamês','Pequeno','2023-04-15',1,'Animal tranquilo',1),(3,14,'Thor','Cachorro','Golden Retriever','Grande','2021-08-20',1,'Animal ativo e brincalhão',1),(4,15,'Mel','Cachorro','Shih Tzu','Pequeno','2024-02-10',1,'Possui pelagem longa',1);

-- 12. compra
INSERT INTO `compra` VALUES (6,6,6,'2026-11-04','CONCLUIDA','NF-TESTE-001','Compra temporaria para testes de integridade financeira'),(14,10,16,'2026-11-05','CONCLUIDA','NF-2026-002','Compra de reposição de produtos para estoque');

-- 13. item_compra
INSERT INTO `item_compra` (`id_item_compra`, `id_compra`, `id_produto`, `quantidade_comprada`, `custo_unitario`) VALUES (7,6,7,10,25.00),(8,6,8,5,10.00),(16,14,9,10,18.00),(17,14,10,8,12.00),(18,14,11,20,6.00);

-- 14. lote
INSERT INTO `lote` VALUES (4,7,'LOTE-TESTE-001','2026-11-05','2027-11-05',10),(5,8,'LOTE-TESTE-002','2026-11-05','2027-11-05',5),(7,16,'AREIA-2026-001','2026-11-05','2027-11-05',10),(8,17,'COLEIRA-2026-001','2026-11-05','2027-11-05',8),(9,18,'PETISCO-2026-001','2026-11-05','2027-11-05',20);

-- 15. agendamento
INSERT INTO `agendamento` VALUES (1,7,1,6,'2026-11-06 00:59:37','AGENDADO',NULL,'Banho completo agendado para Rex','2026-11-05 00:59:37'),(2,13,2,6,'2026-11-07 09:00:00','AGENDADO',NULL,'Tosa higiênica da Luna','2026-11-05 02:27:46'),(3,14,3,6,'2026-11-07 10:00:00','AGENDADO',NULL,'Corte de unhas do Thor','2026-11-05 02:27:46'),(4,15,4,6,'2026-11-07 11:00:00','AGENDADO',NULL,'Banho e tosa da Mel','2026-11-05 02:27:46');

-- 16. agendamento_servico
INSERT INTO `agendamento_servico` VALUES (1,1),(2,2),(3,3),(4,4);

-- 17. atendimento
INSERT INTO `atendimento` VALUES (1,1,6,'2026-11-05 00:59:38',NULL,'EM_ANDAMENTO','Atendimento temporário para testes');

-- 18. atendimento_servico
INSERT INTO `atendimento_servico` VALUES (1,1,1,60.00);

-- 19. transporte
INSERT INTO `transporte` VALUES (1,1,6,'ENTREGA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0.00,'PENDENTE');

-- 20. venda
INSERT INTO `venda` VALUES (6,7,6,NULL,'2026-11-04 04:16:52','CONCLUIDA',0.00,'Venda temporaria para testes de integridade financeira'),(7,7,6,1,'2026-11-05 00:59:38','CONCLUIDA',0.00,'Venda temporária para testes de integridade'),(9,13,6,NULL,'2026-11-05 02:39:04','CONCLUIDA',0.00,'Venda de areia higienica para gatos'),(10,14,6,NULL,'2026-11-05 02:39:05','CONCLUIDA',0.00,'Venda de coleira ajustavel para caes'),(11,15,6,NULL,'2026-11-05 02:39:05','CONCLUIDA',0.00,'Venda de petiscos para caes');

-- 21. item_venda
INSERT INTO `item_venda` (`id_item_venda`, `id_venda`, `id_produto`, `quantidade`, `preco_unitario`, `desconto_item`) VALUES (4,7,7,3,50.00,0.00),(6,9,9,2,32.90,0.00),(7,10,10,1,24.90,0.00),(8,11,11,3,15.90,0.00);

-- 22. baixa_lote
INSERT INTO `baixa_lote` VALUES (4,4,3,'2026-11-05 01:10:24'),(6,7,2,'2026-11-05 02:39:04'),(7,8,1,'2026-11-05 02:39:05'),(8,9,3,'2026-11-05 02:39:06');

-- 23. conta_pagar
INSERT INTO `conta_pagar` VALUES (3,6,1,180.00,'2026-11-04','2026-11-11','PENDENTE'),(4,6,2,120.00,'2026-11-04','2026-11-18','PENDENTE'),(6,14,1,198.00,'2026-11-05','2026-11-12','PENDENTE'),(7,14,2,198.00,'2026-11-05','2026-11-19','PENDENTE');

-- 24. conta_receber
INSERT INTO `conta_receber` VALUES (3,7,1,100.00,'2026-11-04','2026-11-11','PENDENTE'),(4,7,2,50.00,'2026-11-04','2026-11-18','PENDENTE'),(6,9,1,65.80,'2026-11-05','2026-11-12','PENDENTE'),(7,10,1,24.90,'2026-11-05','2026-11-12','PENDENTE'),(8,11,1,47.70,'2026-11-05','2026-11-12','PENDENTE');

-- 25. recebimento (Gera automaticamente os movimentos de ENTRADA)
INSERT INTO `recebimento` VALUES (7,6,6,'2026-11-05 02:42:02',65.80,'PIX'),(8,7,6,'2026-11-05 02:42:02',24.90,'PIX');

-- 26. pagamento (Gera automaticamente os movimentos de SAIDA)
INSERT INTO `pagamento` VALUES (6,6,16,'2026-11-05 02:42:02',198.00,'PIX');