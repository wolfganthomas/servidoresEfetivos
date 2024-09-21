
/*=====================================================*/
/* -- Procedure utilizada para cadastro de servidor	 --*/
/*=====================================================*/

USE SERVIDOR_EFETIVO
GO

IF EXISTS (SELECT 1 FROM SYS.procedures WHERE NAME='InserirServidor')
	DROP PROCEDURE InserirServidor
GO
CREATE PROCEDURE InserirServidor
	@CD_SIAPE INT,
	@NM_SERVIDOR VARCHAR(100),
	@TP_SEXO CHAR(1),
	@DT_NASCIMENTO DATE,
	@NR_CPF VARCHAR(11),
	@FG_REGISTRO_ATIVO BIT
	
AS
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO SERVIDOR (CD_SIAPE,NM_SERVIDOR,TP_SEXO,DT_NASCIMENTO,NR_CPF,FG_REGISTRO_ATIVO)
	VALUES (@CD_SIAPE,@NM_SERVIDOR,	@TP_SEXO,@DT_NASCIMENTO,@NR_CPF,@FG_REGISTRO_ATIVO)
    
END
GO

GRANT EXECUTE ON InserirServidor TO USR_SERVIDOREFETIVO