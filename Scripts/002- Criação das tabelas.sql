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
   'Registra as altera��es realizadas nas tabelas SERVIDOR, LOTACAO_SERVIDOR e VINCULO_SERVIDOR', 
   'schema', 'DBO', 'table', 'AUDITORIA'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica univocamente o registro de auditoria. Chave gerada automaticamente por identity.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'ID_AUDITORIA'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Indica o tipo de altera��o que gerou o registro de log.
   Valores posss�veis:
   
   I - Insert
   U - Update
   D - Delete',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'TP_OPERACAO'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data e hora em que a opera��o foi realizada.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'DT_OPERACAO'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Identifica o usu�rio de banco de dados utilizado para realizar a opera��o.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'NM_USUARIO_OPERACAO'
go


EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Nome da tabela sobre a qual foi realizada a altera��o.',
   'schema', 'DBO', 'table', 'AUDITORIA', 'column', 'NM_TABELA_OPERACAO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Descri��o da altera��o realizada.',
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
   'Flag que indica se o registro est� exclu�do logicamente ou n�o.
   Valores poss�veis:
   
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
   'Registra a lota��o dos servidores, ou seja, o v�nculo entre servidor e lota��o.', 
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Chave prim�ria (artificial) da tabela de v�nculo de servidores. Gerada automaticamente por meio de identity.',
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
   'Data de in�cio da lota��o do servidor no setor.',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'DT_INICIO_LOTACAO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data final da lota��o do servidor no setor.',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'DT_FIM_LOTACAO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se essa � a lota��o ativa (atual) do servidor.
   Valores poss�veis:
   1 - Sim
   0 - N�o',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'FG_LOTACAO_ATIVA'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se a lota��o est� ativa ou inativa.
   Valores poss�veis:
   
   1 - Ativo
   0 - Inativo',
   'schema', 'DBO', 'table', 'LOTACAO_SERVIDOR', 'column', 'FG_REGISTRO_ATIVO'
go

CREATE UNIQUE NONCLUSTERED INDEX IX_LOTACAOSERVIDOR_IDSERVIDOR ON DBO.LOTACAO_SERVIDOR 
	(ID_SERVIDOR ASC)
	WHERE FG_LOTACAO_ATIVA = 1
go


CREATE NONCLUSTERED INDEX IX_LOTACAOSERVIDOR_IDSETOR ON DBO.LOTACAO_SERVIDOR 
(ID_SETOR ASC)
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
   'C�digo SIAPE do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'CD_SIAPE'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Nome do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'NM_SERVIDOR'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Idica o sexo do servidor.  Valores poss�veis: 
   M - Masculino 
   F- Feminino',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'TP_SEXO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data de nascimento do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'DT_NASCIMENTO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'N�mero do CPF (Cadastro Nacional de Pessoa F�sica) do servidor.',
   'schema', 'DBO', 'table', 'SERVIDOR', 'column', 'NR_CPF'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se o registro est� exclu�do logicamente ou n�o.
   Valores poss�veis:
   
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
   'Armazena os setores da institui��o.', 
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
   'Flag que indica se o registro est� exclu�do logicamente ou n�o.
   Valores poss�veis:
   
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
   'Registra a rela��o entre servidores e cargos.', 
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Chave prim�ria (artificial) da tabela de v�nculo de servidores. Gerada automaticamente por meio de identity.',
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
   'Data em que o v�nculo do servidor no cargo atual foi iniciado.',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'DT_INICIO_VINCULO'
go




EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Data em que o v�nculo do servidor no cargo atual se encerrou.',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'DT_FIM_VINCULO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se esse � o v�nculo ativo (atual) do servidor.
   Valores poss�veis:
   1 - Sim
   0 - N�o',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'FG_VINCULO_ATIVO'
go



EXECUTE SP_ADDEXTENDEDPROPERTY 'MS_Description', 
   'Flag que indica se o v�nculo est� ativo ou inativo.
   Valores poss�veis:
   
   1 - Ativo
   0 - Inativo',
   'schema', 'DBO', 'table', 'VINCULO_SERVIDOR', 'column', 'FG_REGISTRO_ATIVO'
go

CREATE UNIQUE NONCLUSTERED INDEX IX_VINCULOSERVIDOR_IDSERVIDOR ON DBO.VINCULO_SERVIDOR 
	(ID_SERVIDOR ASC)
   WHERE FG_VINCULO_ATIVO=1
go


CREATE NONCLUSTERED INDEX IX_VINCULOSERVIDOR_IDCARGO ON DBO.VINCULO_SERVIDOR 
(ID_CARGO ASC)
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