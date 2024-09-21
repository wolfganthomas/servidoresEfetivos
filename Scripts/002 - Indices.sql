/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan						                  */
/*  Data de criação: 21/09/2024				                              */
/*  Finalidade do script:											      */
/*     Criar  índices nas tabelas							              */ 
/*  Sumário do Script:                                                    */
/*     1. Cria indices na tabela  LOTACAO_SERVIDOR                        */
/*     2. Cria indices na tabela  VINCULO_SERVIDOR                        */
/*========================================================================*/

USE SERVIDOR_EFETIVO
GO
CREATE UNIQUE NONCLUSTERED INDEX IX_LOTACAOSERVIDOR_IDSERVIDOR ON DBO.LOTACAO_SERVIDOR 
	(ID_SERVIDOR ASC)
	WHERE FG_LOTACAO_ATIVA = 1
go


CREATE NONCLUSTERED INDEX IX_LOTACAOSERVIDOR_IDSETOR ON DBO.LOTACAO_SERVIDOR 
(ID_SETOR ASC)
go


CREATE UNIQUE NONCLUSTERED INDEX IX_VINCULOSERVIDOR_IDSERVIDOR ON DBO.VINCULO_SERVIDOR 
	(ID_SERVIDOR ASC)
   WHERE FG_VINCULO_ATIVO=1
go

-- Data de início do vinculo incluída porque a regra negocial demanda a ordenação por este campo
CREATE NONCLUSTERED INDEX IX_VINCULOSERVIDOR_IDCARGO_DTINICIOVINCULO ON DBO.VINCULO_SERVIDOR 
(ID_CARGO ASC,DT_INICIO_VINCULO ASC)
go