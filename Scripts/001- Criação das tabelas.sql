/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan			                  */
/*  Data de criação: 21/09/2024				                  */
/*  Finalidade do script:						  */
/*     Criar tabelas do modelo de dados        				  */ 
/*  Sumário do Script:                                                    */
/*     1. Cria a tabela AUDITORIA                                         */
/*     2. Cria a tabela CARGO                                             */
/*     3. Cria a tabela LOTACAO_SERVIDOR                                  */
/*     4. Cria a tabela SERVIDOR                                          */
/*     5. Cria a tabela SETOR                                             */
/*========================================================================*/


USE SERVIDOR_EFETIVO
go


CREATE TABLE DBO.AUDITORIA (
   ID_AUDITORIA         BIGINT               IDENTITY,
   TP_OPERACAO          CHAR(1)              NOT NULL,
   DT_OPERACAO          DATETIME             NOT NULL,
   NM_USUARIO_OPERACAO  VARCHAR(100)         NOT NULL,
   NM_TABELA_OPERACAO   VARCHAR(100)         NOT NULL,
   DS_OPERACAO          VARCHAR(1000)        NOT NULL,
   CONSTRAINT PK_AUDITORIA PRIMARY KEY (ID_AUDITORIA)
)
go

ALTER TABLE AUDITORIA
	ADD CONSTRAINT CK_AUDITORIA_TPOPERACAO CHECK (TP_OPERACAO IN ('I','U','D'))
go

EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description',  
   'Registra as alterações realizadas nas tabelas SERVIDOR, LOTACAO_SERVIDOR e VINCULO_SERVIDOR', 
   'schema', 'DBO', 'table', 'AUDITORIA'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o registro de auditoria. Chave gerada automaticamente por identity.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'ID_AUDITORIA'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Indica o tipo de alteração que gerou o registro de log.
   Valores posssíveis:
   
   I - Insert
   U - Update
   D - Delete',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'TP_OPERACAO'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data e hora em que a operação foi realizada.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'DT_OPERACAO'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica o usuário de banco de dados utilizado para realizar a operação.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'NM_USUARIO_OPERACAO'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Nome da tabela sobre a qual foi realizada a alteração.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'NM_TABELA_OPERACAO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Descrição da alteração realizada.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'DS_OPERACAO'
go


CREATE TABLE DBO.CARGO (
   ID_CARGO             INT                  IDENTITY,
   NM_CARGO             VARCHAR(100)         NOT NULL,
   FG_REGISTRO_ATIVO    BIT                  NOT NULL,
   CONSTRAINT PK_CARGO PRIMARY KEY (ID_CARGO)
)
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description',  
   'Armazena os cargos que podem ser exercidos por servidores.', 
   'schema', 'DBO', 'table', 'CARGO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o cargo. Chave gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'CARGO', 'column', 'ID_CARGO'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Nome do cargo.',
   'schema', 'DBO', 'table', 'CARGO', 'column', 'NM_CARGO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se o registro está excluído logicamente ou não.
   Valores possíveis:
   
   1 - Ativo
   0 - Inativo',
   'schema', 'DBO', 'table', 'CARGO', 'column', 'FG_REGISTRO_ATIVO'
go


CREATE TABLE DBO.LOTACAO_SERVIDOR (
   ID_LOTACAO_SERVIDOR  INT                  IDENTITY,
   ID_SERVIDOR          INT                  NOT NULL,
   ID_SETOR             INT                  NOT NULL,
   DT_INICIO_LOTACAO    DATE                 NOT NULL,
   DT_FIM_LOTACAO       DATE                 NULL,
   FG_LOTACAO_ATIVA     BIT                  NOT NULL,
   FG_REGISTRO_ATIVO    BIT                  NOT NULL,
   CONSTRAINT PK_LOTACAO_SERVIDOR PRIMARY KEY (ID_LOTACAO_SERVIDOR)
)
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description',  
   'Registra a lotação dos servidores, ou seja, o vínculo entre servidor e lotação.', 
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Chave primária (artificial) da tabela de vínculo de servidores. Gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'ID_LOTACAO_SERVIDOR'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o registro de servidor. Chave gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'ID_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o setor. Chave gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'ID_SETOR'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data de início da lotação do servidor no setor.',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'DT_INICIO_LOTACAO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data final da lotação do servidor no setor.',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'DT_FIM_LOTACAO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se essa é a lotação ativa (atual) do servidor.
   Valores possíveis:
   1 - Sim
   0 - Não',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'FG_LOTACAO_ATIVA'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se a lotação está ativa ou inativa.
   Valores possíveis:
   
   1 - Ativo
   0 - Inativo',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'FG_REGISTRO_ATIVO'
go





CREATE TABLE DBO.SERVIDOR (
   ID_SERVIDOR          INT                  IDENTITY,
   CD_SIAPE             INT                  NOT NULL,
   NM_SERVIDOR          VARCHAR(100)         NOT NULL,
   TP_SEXO              CHAR(1)              NOT NULL 
      CONSTRAINT CK_SERVIDOR_CDSEXO CHECK (TP_SEXO IN ('F','M')),
   DT_NASCIMENTO        DATE                 NOT NULL,
   NR_CPF               VARCHAR(11)          NOT NULL,
   FG_REGISTRO_ATIVO    BIT                  NOT NULL,
   CONSTRAINT PK_SERVIDOR PRIMARY KEY (ID_SERVIDOR)
)
go

ALTER TABLE DBO.SERVIDOR
   ADD CONSTRAINT UK_SERVIDOR_CDSIAPE UNIQUE (CD_SIAPE)
go

EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description',  
   'Armazena os registros de servidores.', 
   'schema', 'DBO', 'table', 'SERVIDOR'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o registro de servidor. Chave gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'ID_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Código SIAPE do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'CD_SIAPE'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Nome do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'NM_SERVIDOR'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Idica o sexo do servidor.  Valores possíveis: 
   M - Masculino 
   F- Feminino',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'TP_SEXO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data de nascimento do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'DT_NASCIMENTO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Número do CPF (Cadastro Nacional de Pessoa Física) do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'NR_CPF'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se o registro está excluído logicamente ou não.
   Valores possíveis:
   
   1 - Ativo
   0 - Inativo',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'FG_REGISTRO_ATIVO'
go


CREATE TABLE DBO.SETOR (
   ID_SETOR             INT                  IDENTITY,
   SG_SETOR             VARCHAR(20)          NOT NULL,
   NM_SETOR             VARCHAR(100)         NOT NULL,
   FG_REGISTRO_ATIVO    BIT                  NOT NULL,
   CONSTRAINT PK_SETOR PRIMARY KEY (ID_SETOR)
)
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description',  
   'Armazena os setores da instituição.', 
   'schema', 'DBO', 'table', 'SETOR'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o setor. Chave gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'SETOR', 'column', 'ID_SETOR'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Sigla do setor.',
   'schema', 'DBO', 'table', 'SETOR', 'column', 'SG_SETOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Nome do setor.',
   'schema', 'DBO', 'table', 'SETOR', 'column', 'NM_SETOR'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se o registro está excluído logicamente ou não.
   Valores possíveis:
   
   1 - Ativo
   0 - Inativo',
   'schema', 'DBO', 'table', 'SETOR', 'column', 'FG_REGISTRO_ATIVO'
go


CREATE TABLE DBO.VINCULO_SERVIDOR (
   ID_VINCULO_SERVIDOR  INT                  IDENTITY,
   ID_SERVIDOR          INT                  NOT NULL,
   ID_CARGO             INT                  NOT NULL,
   DT_INICIO_VINCULO    DATE                 NOT NULL,
   DT_FIM_VINCULO       DATE                 NULL,
   FG_VINCULO_ATIVO     BIT                  NOT NULL,
   FG_REGISTRO_ATIVO    BIT                  NOT NULL,
   CONSTRAINT PK_VINCULO_SERVIDOR PRIMARY KEY (ID_VINCULO_SERVIDOR)
)
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description',  
   'Registra a relação entre servidores e cargos.', 
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Chave primária (artificial) da tabela de vínculo de servidores. Gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'ID_VINCULO_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o registro de servidor. Chave gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'ID_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o cargo. Chave gerada automaticamente por meio de identity.',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'ID_CARGO'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data em que o vínculo do servidor no cargo atual foi iniciado.',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'DT_INICIO_VINCULO'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data em que o vínculo do servidor no cargo atual se encerrou.',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'DT_FIM_VINCULO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se esse é o vínculo ativo (atual) do servidor.
   Valores possíveis:
   1 - Sim
   0 - Não',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'FG_VINCULO_ATIVO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se o vínculo está ativo ou inativo.
   Valores possíveis:
   
   1 - Ativo
   0 - Inativo',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'FG_REGISTRO_ATIVO'
go



ALTER TABLE DBO.LOTACAO_SERVIDOR
   ADD CONSTRAINT FK_LOTACAOSERVIDOR_SERVIDOR FOREIGN KEY (ID_SERVIDOR)
      REFERENCES DBO.SERVIDOR (ID_SERVIDOR)
go

ALTER TABLE DBO.LOTACAO_SERVIDOR
   ADD CONSTRAINT FK_LOTACAOSERVIDOR_SETOR FOREIGN KEY (ID_SETOR)
      REFERENCES DBO.SETOR (ID_SETOR)
go

ALTER TABLE DBO.VINCULO_SERVIDOR
   ADD CONSTRAINT FK_VINCULOSERVIDOR_CARGO FOREIGN KEY (ID_CARGO)
      REFERENCES DBO.CARGO (ID_CARGO)
go

ALTER TABLE DBO.VINCULO_SERVIDOR
   ADD CONSTRAINT FK_VINCULOSERVIDOR_SERVIDOR FOREIGN KEY (ID_SERVIDOR)
      REFERENCES DBO.SERVIDOR (ID_SERVIDOR)
go


GRANT SELECT, INSERT, UPDATE ON SERVIDOR TO USR_SERVIDOREFETIVO
GRANT SELECT, INSERT, UPDATE ON SETOR TO USR_SERVIDOREFETIVO
GRANT SELECT, INSERT, UPDATE ON CARGO TO USR_SERVIDOREFETIVO
GRANT SELECT, INSERT, UPDATE ON LOTACAO_SERVIDOR TO USR_SERVIDOREFETIVO
GRANT SELECT, INSERT, UPDATE ON VINCULO_SERVIDOR TO USR_SERVIDOREFETIVO
GRANT SELECT ON AUDITORIA TO USR_SERVIDOREFETIVO

GRANT SELECT ON SERVIDOR TO USR_SERVIDOREFETIVO_BI 
GRANT SELECT ON SETOR TO USR_SERVIDOREFETIVO_BI 
GRANT SELECT ON CARGO TO USR_SERVIDOREFETIVO_BI 
GRANT SELECT ON LOTACAO_SERVIDOR TO USR_SERVIDOREFETIVO_BI 
GRANT SELECT ON VINCULO_SERVIDOR TO USR_SERVIDOREFETIVO_BI 
GRANT SELECT ON AUDITORIA TO USR_SERVIDOREFETIVO_BI 
