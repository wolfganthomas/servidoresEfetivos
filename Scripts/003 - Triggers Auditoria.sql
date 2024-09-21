/*=====================================================*/
/* -- Procedure utilizada para inserção de auditoria --*/
/*=====================================================*/
USE SERVIDOR_EFETIVO
GO

IF EXISTS (SELECT 1 FROM SYS.procedures WHERE NAME='InserirAuditoria')
	DROP PROCEDURE InserirAuditoria
GO

CREATE PROCEDURE InserirAuditoria
	@TP_OPERACAO CHAR(1),
	@NM_TABELA_OPERACAO VARCHAR(100),
	@DS_OPERACAO VARCHAR(1000)
	
AS
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO AUDITORIA (TP_OPERACAO,DT_OPERACAO,NM_USUARIO_OPERACAO,NM_TABELA_OPERACAO,DS_OPERACAO)
	VALUES (@TP_OPERACAO,GETDATE(),SUSER_SNAME(),@NM_TABELA_OPERACAO,@DS_OPERACAO)
    
END
GO

GRANT EXECUTE ON InserirAuditoria TO USR_SERVIDOREFETIVO
GO
/*=====================================================*/
/* -- Trigger auditoria tabela SERVIDOR				 --*/
/*=====================================================*/

IF EXISTS(SELECT 1 FROM SYS.triggers WHERE NAME='TG_AUD_SERVIDOR')
	DROP TRIGGER TG_AUD_SERVIDOR
GO


CREATE TRIGGER TG_AUD_SERVIDOR
   ON  SERVIDOR
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @TP_OPERACAO CHAR(1)='I',
			@DS_OPERACAO VARCHAR(1000);

	

    -- Identificar a operação realizada
     IF  (EXISTS(SELECT 1 FROM DELETED))
          SET @TP_OPERACAO = CASE
                                   WHEN EXISTS(SELECT * FROM INSERTED) THEN 'U' -- UPDATE
                                   ELSE 'D'                                     -- DELETE
       END;
	IF @TP_OPERACAO='I'
		BEGIN	
			SET @DS_OPERACAO=(
							SELECT 
								CONCAT('Cadastro de servidor realizado. Dados:'
								,'; ID_SERVIDOR: ',I.ID_SERVIDOR
								,'; CD_SIAPE: ',I.CD_SIAPE
								,'; NM_SERVIDOR: ',I.NM_SERVIDOR
								,'; TP_SEXO: ',I.TP_SEXO
								,'; DT_NASCIMENTO: ',I.DT_NASCIMENTO
								,'; NR_CPF: ',I.NR_CPF
								,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO
								)
							FROM INSERTED I
						)

			
		END;

	IF @TP_OPERACAO='U'
		BEGIN
			SET @DS_OPERACAO=(CONCAT(	
										'Alteração de cadastro de servidor. ** Dados antes a alteração:'
										,(SELECT CONCAT(
											' ID_SERVIDOR: ',D.ID_SERVIDOR
											,'; CD_SIAPE: ',D.CD_SIAPE
											,'; NM_SERVIDOR: ',D.NM_SERVIDOR
											,'; TP_SEXO: ',D.TP_SEXO
											,'; DT_NASCIMENTO: ',D.DT_NASCIMENTO
											,'; NR_CPF: ',D.NR_CPF
											,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO)
											FROM DELETED D)
										,'** Dados após a alteração:'
										,(SELECT CONCAT(
											' ID_SERVIDOR: ',I.ID_SERVIDOR
											,'; CD_SIAPE: ',I.CD_SIAPE
											,'; NM_SERVIDOR: ',I.NM_SERVIDOR
											,'; TP_SEXO: ',I.TP_SEXO
											,'; DT_NASCIMENTO: ',I.DT_NASCIMENTO
											,'; NR_CPF: ',I.NR_CPF
											,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO)
											FROM INSERTED I)
										)
										
							)
		END;

	IF @TP_OPERACAO='D'
		BEGIN	
			SET @DS_OPERACAO=(
							SELECT 
								CONCAT('Exclusão física de cadastro de servidor. Dados:'
								,'; ID_SERVIDOR: ',D.ID_SERVIDOR
								,'; CD_SIAPE: ',D.CD_SIAPE
								,'; NM_SERVIDOR: ',D.NM_SERVIDOR
								,'; TP_SEXO: ',D.TP_SEXO
								,'; DT_NASCIMENTO: ',D.DT_NASCIMENTO
								,'; NR_CPF: ',D.NR_CPF
								,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO
								)
							FROM DELETED D
						)

			
		END;
	EXEC InserirAuditoria @TP_OPERACAO,'SERVIDOR',@DS_OPERACAO
END
GO

/*=====================================================*/
/* -- Trigger auditoria tabela LOTACAO_SERVIDOR		 --*/
/*=====================================================*/

IF EXISTS(SELECT 1 FROM SYS.triggers WHERE NAME='TG_AUD_LOTACAOSERVIDOR')
	DROP TRIGGER TG_AUD_LOTACAOSERVIDOR
GO

CREATE TRIGGER TG_AUD_LOTACAOSERVIDOR
   ON  LOTACAO_SERVIDOR
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @TP_OPERACAO CHAR(1)='I',
			@DS_OPERACAO VARCHAR(1000);

	

    -- Identificar a operação realizada
     IF  (EXISTS(SELECT 1 FROM DELETED))
          SET @TP_OPERACAO = CASE
                                   WHEN EXISTS(SELECT * FROM INSERTED) THEN 'U' -- UPDATE
                                   ELSE 'D'                                     -- DELETE
       END;
	IF @TP_OPERACAO='I'
		BEGIN	
			SET @DS_OPERACAO=(
							SELECT 
								CONCAT('Cadastro de lotação para servidor. Dados:'
								,'; ID_SERVIDOR: ',I.ID_SERVIDOR
								,'; NM_SERVIDOR: ',S.NM_SERVIDOR
								,'; ID_SETOR: ',I.ID_SETOR
								,'; SG_SETOR: ',ST.SG_SETOR
								,'; DT_INICIO_LOTACAO: ',I.DT_INICIO_LOTACAO
								,'; DT_FIM_LOTACAO: ',I.DT_FIM_LOTACAO
								,'; FG_LOTACAO_ATIVA: ',I.FG_LOTACAO_ATIVA
								,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO
								)
							FROM INSERTED I
							INNER JOIN SERVIDOR S ON S.ID_SERVIDOR=I.ID_SERVIDOR
							INNER JOIN SETOR ST ON ST.ID_SETOR=I.ID_SETOR
						)

			
		END;

	IF @TP_OPERACAO='U'
		BEGIN
			SET @DS_OPERACAO=(CONCAT(	
										'Alteração na lotação de servidor. ** Dados antes a alteração:'
										,(SELECT CONCAT(
											' ID_SERVIDOR: ',D.ID_SERVIDOR
											,'; NM_SERVIDOR: ',S.NM_SERVIDOR
											,'; ID_SETOR: ',D.ID_SETOR
											,'; SG_SETOR: ',ST.SG_SETOR
											,'; DT_INICIO_LOTACAO: ',D.DT_INICIO_LOTACAO
											,'; DT_FIM_LOTACAO: ',D.DT_FIM_LOTACAO
											,'; FG_LOTACAO_ATIVA: ',D.FG_LOTACAO_ATIVA
											,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO)
											FROM DELETED D
											INNER JOIN SERVIDOR S ON S.ID_SERVIDOR=D.ID_SERVIDOR
											INNER JOIN SETOR ST ON ST.ID_SETOR=D.ID_SETOR
											)
										,'** Dados após a alteração:'
										,(SELECT CONCAT(
											' ID_SERVIDOR: ',I.ID_SERVIDOR
											,'; NM_SERVIDOR: ',S.NM_SERVIDOR
											,'; ID_SETOR: ',I.ID_SETOR
											,'; SG_SETOR: ',ST.SG_SETOR
											,'; DT_INICIO_LOTACAO: ',I.DT_INICIO_LOTACAO
											,'; DT_FIM_LOTACAO: ',I.DT_FIM_LOTACAO
											,'; FG_LOTACAO_ATIVA: ',I.FG_LOTACAO_ATIVA
											,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO)
											FROM INSERTED I
											INNER JOIN SERVIDOR S ON S.ID_SERVIDOR=I.ID_SERVIDOR
											INNER JOIN SETOR ST ON ST.ID_SETOR=I.ID_SETOR)
										)
										
							)
		END;

	IF @TP_OPERACAO='D'
		BEGIN	
			SET @DS_OPERACAO=(					 
									(SELECT CONCAT(
											'Exclusão física de lotação de servidor. Dados:'
											,' ID_SERVIDOR: ',D.ID_SERVIDOR
											,'; NM_SERVIDOR: ',S.NM_SERVIDOR
											,'; ID_SETOR: ',D.ID_SETOR
											,'; SG_SETOR: ',ST.SG_SETOR
											,'; DT_INICIO_LOTACAO: ',D.DT_INICIO_LOTACAO
											,'; DT_FIM_LOTACAO: ',D.DT_FIM_LOTACAO
											,'; FG_LOTACAO_ATIVA: ',D.FG_LOTACAO_ATIVA
											,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO)
								
							FROM DELETED D
							INNER JOIN SERVIDOR S ON S.ID_SERVIDOR=D.ID_SERVIDOR
							INNER JOIN SETOR ST ON ST.ID_SETOR=D.ID_SETOR
							)
						)
		
		END;
	EXEC InserirAuditoria @TP_OPERACAO,'LOTACAO_SERVIDOR',@DS_OPERACAO
END
GO


SELECT * FROM LOTACAO_SERVIDOR
GO
SELECT * FROM AUDITORIA

INSERT INTO LOTACAO_SERVIDOR VALUES (1,