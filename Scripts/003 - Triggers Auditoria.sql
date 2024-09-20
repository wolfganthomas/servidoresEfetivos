/*=====================================================*/
/* -- Procedure utilizada para inserção de auditoria --*/
/*=====================================================*/

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


CREATE TRIGGER TG_AUD_SERVIDOR
--ALTER TRIGGER TG_AUD_SERVIDOR
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

			EXEC InserirAuditoria @TP_OPERACAO,'SERVIDOR',@DS_OPERACAO
		END;

END
GO



SELECT * FROM SERVIDOR

INSERT INTO SERVIDOR VALUES (1,'SERVIDOR TESTE 2','M','19940101','11111111111',1)

SELECT * FROM AUDITORIA