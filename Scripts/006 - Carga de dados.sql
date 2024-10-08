/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan					  */
/*  Data de criação: 21/09/2024				                  */
/*  Finalidade do script:						  */
/*     Carregar massa de dados nas tabelas				  */ 
/*  Sumário do Script:                                                    */
/*     1. Carrega massa de dados nas tabelas			          */
/*========================================================================*/

USE SERVIDOR_EFETIVO
GO
-- Cargos
INSERT INTO CARGO (NM_CARGO, FG_REGISTRO_ATIVO) 
VALUES 
('Analista de Sistemas', 1),
('Administrador de Banco de Dados', 1),
('Desenvolvedor', 1),
('Gestor de TI', 1),
('Suporte Técnico', 1),
('Engenheiro de Software', 1),
('Analista de BI', 1),
('Arquiteto de Dados', 1),
('Coordenador de TI', 1),
('Diretor de TI', 1);

-- Setores
INSERT INTO SETOR (SG_SETOR, NM_SETOR, FG_REGISTRO_ATIVO) 
VALUES 
('TI', 'Tecnologia da Informação', 1),
('RH', 'Recursos Humanos', 1),
('FIN', 'Financeiro', 1),
('ADM', 'Administrativo', 1),
('COM', 'Comercial', 1),
('SUP', 'Suporte', 1),
('OPR', 'Operações', 1),
('LOG', 'Logística', 1),
('MKT', 'Marketing', 1),
('DIR', 'Diretoria', 1);

-- Servidores
INSERT INTO SERVIDOR (CD_SIAPE, NM_SERVIDOR, TP_SEXO, DT_NASCIMENTO, NR_CPF, FG_REGISTRO_ATIVO,DT_EFETIVACAO)
VALUES 
(1001, 'Servidor 1', 'M', '1990-01-01', '00000000001',  1,'2020-01-06' ),
(1002, 'Servidor 2', 'F', '1991-02-02', '00000000002',  1,'2020-01-06' ),
(1003, 'Servidor 3', 'M', '1992-03-03', '00000000003',  1,'2020-01-06' ),
(1004, 'Servidor 4', 'F', '1993-04-04', '00000000004',  1,'2021-02-01' ),
(1005, 'Servidor 5', 'M', '1994-05-05', '00000000005',  1,'2021-02-01' ),
(1006, 'Servidor 6', 'F', '1995-06-06', '00000000006',  1,'2021-02-01' ),
(1007, 'Servidor 7', 'M', '1996-07-07', '00000000007',  1,'2021-02-01' ),
(1008, 'Servidor 8', 'F', '1997-08-08', '00000000008',  1,'2021-02-01' ),
(1009, 'Servidor 9', 'M', '1998-09-09', '00000000009',  1,'2023-08-07' ),
(1010, 'Servidor 10', 'F', '1999-10-10', '00000000010', 1,'2023-08-07' ),
(1011, 'Servidor 11', 'M', '1989-01-11', '00000000011', 1,'2023-08-07' ),
(1012, 'Servidor 12', 'F', '1988-12-12', '00000000012', 1,'2023-08-07' ),
(1013, 'Servidor 13', 'M', '1987-11-13', '00000000013', 1,'2023-08-07' ),
(1014, 'Servidor 14', 'F', '1986-10-14', '00000000014', 1,'2023-08-07' ),
(1015, 'Servidor 15', 'M', '1985-09-15', '00000000015', 1,'2023-08-07' ),
(1016, 'Servidor 16', 'F', '1984-08-16', '00000000016', 1,'2023-08-07' ),
(1017, 'Servidor 17', 'M', '1983-07-17', '00000000017', 1,'2024-01-08' ),
(1018, 'Servidor 18', 'F', '1982-06-18', '00000000018', 1,'2024-01-08' ),
(1019, 'Servidor 19', 'M', '1981-05-19', '00000000019', 1,'2024-01-08' ),
(1020, 'Servidor 20', 'F', '1980-04-20', '00000000020', 1,'2024-01-08' ),
(1021, 'Servidor 21', 'M', '1979-03-21', '00000000021', 1,'2024-01-08' ),
(1022, 'Servidor 22', 'F', '1978-02-22', '00000000022', 1,'2024-01-08' ),
(1023, 'Servidor 23', 'M', '1977-01-23', '00000000023', 1,'2024-01-08' ),
(1024, 'Servidor 24', 'F', '1976-12-24', '00000000024', 1,'2024-01-08' ),
(1025, 'Servidor 25', 'M', '1975-11-25', '00000000025', 1,'2024-01-08' );

-- Vinculos
INSERT INTO VINCULO_SERVIDOR (ID_SERVIDOR, ID_CARGO, DT_INICIO_VINCULO, FG_VINCULO_ATIVO, FG_REGISTRO_ATIVO)
VALUES
(1, 1, '2020-01-06', 1, 1),
(2, 2, '2020-01-06', 1, 1),
(3, 3, '2020-01-06', 1, 1),
(4, 4, '2021-02-01', 1, 1),
(5, 5, '2021-02-01', 1, 1),
(6, 6, '2021-02-01', 1, 1),
(7, 7, '2021-02-01', 1, 1),
(8, 8, '2021-02-01', 1, 1),
(9, 9, '2023-08-07', 1, 1),
(10, 10, '2023-08-07', 1, 1),
(11, 1, '2023-08-07', 1, 1),
(12, 2, '2023-08-07', 1, 1),
(13, 3, '2023-08-07', 1, 1),
(14, 4, '2023-08-07', 1, 1),
(15, 5, '2023-08-07', 1, 1),
(16, 6, '2023-08-07', 1, 1),
(17, 7,'2024-01-08', 1, 1),
(18, 8, '2024-01-08', 1, 1),
(19, 9, '2024-01-08', 1, 1),
(20, 10, '2024-01-08', 1, 1),
(21, 1, '2024-01-08', 1, 1),
(22, 2, '2024-01-08', 1, 1),
(23, 3, '2024-01-08', 1, 1),
(24, 4, '2024-01-08', 1, 1),
(25, 5, '2024-01-08', 1, 1);

-- Lotação
INSERT INTO LOTACAO_SERVIDOR (ID_SERVIDOR, ID_SETOR, DT_INICIO_LOTACAO, FG_LOTACAO_ATIVA, FG_REGISTRO_ATIVO)
VALUES
(1, 1, '2020-01-06', 1, 1),
(2, 2, '2020-01-06', 1, 1),
(3, 3, '2020-01-06', 1, 1),
(4, 4, '2021-02-01', 1, 1),
(5, 5, '2021-02-01', 1, 1),
(6, 6, '2021-02-01', 1, 1),
(7, 7, '2021-02-01', 1, 1),
(8, 8, '2021-02-01', 1, 1),
(9, 9, '2023-08-07', 1, 1),
(10, 10, '2023-08-07', 1, 1),
(11, 1, '2023-08-07', 1, 1),
(12, 2, '2023-08-07', 1, 1),
(13, 3,'2023-08-07', 1, 1),
(14, 4, '2023-08-07', 1, 1),
(15, 5, '2023-08-07', 1, 1),
(16, 6, '2023-08-07', 1, 1),
(17, 7, '2024-01-08', 1, 1),
(18, 8, '2024-01-08', 1, 1),
(19, 9, '2024-01-08', 1, 1),
(20, 10, '2024-01-08', 1, 1),
(21, 1, '2024-01-08', 1, 1),
(22, 2, '2024-01-08', 1, 1),
(23, 3, '2024-01-08', 1, 1),
(24, 4, '2024-01-08', 1, 1),
(25, 5, '2024-01-08', 1, 1);

-- Simular mudança de cargo 

UPDATE VINCULO_SERVIDOR
	SET DT_FIM_VINCULO = '2024-01-21', FG_VINCULO_ATIVO = 0
WHERE ID_SERVIDOR IN (6, 7, 8, 9, 10)


INSERT INTO VINCULO_SERVIDOR VALUES
(6,2,'2024-01-21',NULL,1,1)
,(7,10,'2024-01-21',NULL,1,1)
,(8,1,'2024-01-21',NULL,1,1)
,(9,7,'2024-01-21',NULL,1,1)
,(10,5,'2024-01-21',NULL,1,1)

-- Simular mudança de setor

UPDATE LOTACAO_SERVIDOR
	SET  DT_FIM_LOTACAO ='2024-01-21', FG_LOTACAO_ATIVA = 0
WHERE ID_SERVIDOR IN (6, 7, 8, 9, 10)

INSERT INTO LOTACAO_SERVIDOR VALUES
(6,1,'2024-01-21',NULL,1,1)
,(7,10,'2024-01-21',NULL,1,1)
,(8,8,'2024-01-21',NULL,1,1)
,(9,7,'2024-01-21',NULL,1,1)
,(10,9,'2024-01-21',NULL,1,1)

-- Simular inativação de servidor
UPDATE SERVIDOR
	SET DT_EXONERACAO='2022-03-10',FG_REGISTRO_ATIVO=0
WHERE ID_SERVIDOR =10;

UPDATE SERVIDOR
	SET DT_EXONERACAO='2023-04-05',FG_REGISTRO_ATIVO=0
WHERE ID_SERVIDOR =2;

UPDATE SERVIDOR
	SET DT_EXONERACAO='2023-04-05',FG_REGISTRO_ATIVO=0
WHERE ID_SERVIDOR =3;


UPDATE VINCULO_SERVIDOR
	SET DT_INICIO_VINCULO='2022-03-01'
WHERE ID_SERVIDOR =2

UPDATE VINCULO_SERVIDOR
	SET DT_INICIO_VINCULO='2022-03-01',DT_FIM_VINCULO='2024-09-20'
WHERE ID_SERVIDOR =2

-- Alterar datas de operação na tabela de auditoria apenas para permitir uma melhor avaliação do Relatório de Log de Modificações
----- Esse trecho precisa ser executado com usuário que possua privilégios elevados, dado que os usuários usr_servidorefetivo e usr_servidorefetivo_bi não podem alterar registros de auditoria

/*
WITH C_AUDITORIA AS(
	SELECT ID_AUDITORIA
			,DT_OPERACAO
			,DATEADD(DAY, 
               ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, '2024-01-01', GETDATE()), 
               '2024-01-01') DT_ALEATORIA
	FROM AUDITORIA
)

UPDATE C_AUDITORIA SET DT_OPERACAO=DT_ALEATORIA

*/