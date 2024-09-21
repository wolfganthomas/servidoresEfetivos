/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan			                  */
/*  Data de criação: 21/09/2024				                  */
/*  Finalidade do script:						  */
/*     Criar procedure para inserção de servidor        		  */ 
/*  Sumário do Script:                                                    */
/*     1. Cria a procedure InserirServidor                                */
/*========================================================================*/


/*=====================================================*/
/* -- Procedure utilizada para cadastro de servidor  --*/
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
    @DT_EFETIVACAO DATE,
    @DT_EXONERACAO DATE,
	@FG_REGISTRO_ATIVO BIT

	
AS
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO SERVIDOR (CD_SIAPE,NM_SERVIDOR,TP_SEXO,DT_NASCIMENTO,NR_CPF,DT_EFETIVACAO,DT_EXONERACAO,FG_REGISTRO_ATIVO)
	VALUES (@CD_SIAPE,@NM_SERVIDOR,	@TP_SEXO,@DT_NASCIMENTO,@NR_CPF,@DT_EFETIVACAO,@DT_EXONERACAO,@FG_REGISTRO_ATIVO)
    
END
GO

GRANT EXECUTE ON InserirServidor TO USR_SERVIDOREFETIVO

/*=====================================================*/
/* -- Comando para testar a procedure                --*/
/*=====================================================*/

/*
DECLARE @CD_SIAPE int= 15487
DECLARE @NM_SERVIDOR varchar(100)='Nome do servidor'
DECLARE @TP_SEXO char(1)='M' -- Valores aceitos 'M' ou 'F', para masculino e feminino, respectivamente
DECLARE @DT_NASCIMENTO date='1990-01-10'
DECLARE @NR_CPF varchar(11)= '00000000000'
DECLARE @DT_EFETIVACAO DATE='2020-01-07'
DECLARE @DT_EXONERACAO DATE=NULL
DECLARE @FG_REGISTRO_ATIVO bit=1 -- Valores aceitos 1 ou 0, para ativo e inativo, respectivamente

EXECUTE InserirServidor
   @CD_SIAPE
  ,@NM_SERVIDOR
  ,@TP_SEXO
  ,@DT_NASCIMENTO
  ,@NR_CPF
  ,@DT_EFETIVACAO
  ,@DT_EXONERACAO
  ,@FG_REGISTRO_ATIVO
GO

*/
