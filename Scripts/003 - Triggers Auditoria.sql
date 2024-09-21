/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan					  */
/*  Data de criação: 21/09/2024				                  */
/*  Finalidade do script:						  */
/*     Criar triggers de auditoria de tabelas				  */ 
/*  Sumário do Script:                                                    */
/*     1. Cria trigger de auditoria para a tabela SERVIDOR                */
/*     2. Cria trigger de auditoria para a tabela LOTACAO_SERVIDOR        */
/*     3. Cria trigger de auditoria para a tabela VINCULO_SERVIDOR        */
/*========================================================================*/


/*=====================================================*/
/* -- Trigger auditoria tabela SERVIDOR		     --*/
/*=====================================================*/

USE SERVIDOR_EFETIVO
GO

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
                                   WHEN EXISTS(SELECT 1 FROM INSERTED) THEN 'U' -- UPDATE
                                   ELSE 'D'                                     -- DELETE
       END;
	IF @TP_OPERACAO='I'
		BEGIN	
			INSERT INTO AUDITORIA
			SELECT
				@TP_OPERACAO
				,GETDATE()
				,SUSER_NAME()
				,'SERVIDOR'
				,CONCAT(
						'Cadastro de servidor realizado. Dados:'
						,' ID_SERVIDOR: ',I.ID_SERVIDOR
						,'; CD_SIAPE: ',I.CD_SIAPE
						,'; NM_SERVIDOR: ',I.NM_SERVIDOR
						,'; TP_SEXO: ',I.TP_SEXO
						,'; DT_NASCIMENTO: ',I.DT_NASCIMENTO
						,'; NR_CPF: ',I.NR_CPF
                        ,'; DT_EFETIVACAO: ',I.DT_EFETIVACAO
                        ,'; DT_EXONERACAO: ',I.DT_EXONERACAO
						,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO
					)
			FROM INSERTED I
			
		END;

	IF @TP_OPERACAO='U'
		BEGIN
			INSERT INTO AUDITORIA 
			SELECT @TP_OPERACAO
					,GETDATE()
					,SUSER_NAME()
					,'SERVIDOR'
					,CONCAT(
							'Alteração de cadastro de servidor. ** Dados antes a alteração:'
							,'ID_SERVIDOR: ',D.ID_SERVIDOR
							,'; CD_SIAPE: ',D.CD_SIAPE
							,'; NM_SERVIDOR: ',D.NM_SERVIDOR
							,'; TP_SEXO: ',D.TP_SEXO
							,'; DT_NASCIMENTO: ',D.DT_NASCIMENTO
							,'; NR_CPF: ',D.NR_CPF
                            ,'; DT_EFETIVACAO: ',D.DT_EFETIVACAO
                            ,'; DT_EXONERACAO: ',D.DT_EXONERACAO
							,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO

							,'; ** Dados após a alteração:'
							,' ID_SERVIDOR: ',I.ID_SERVIDOR
							,'; CD_SIAPE: ',I.CD_SIAPE
							,'; NM_SERVIDOR: ',I.NM_SERVIDOR
							,'; TP_SEXO: ',I.TP_SEXO
							,'; DT_NASCIMENTO: ',I.DT_NASCIMENTO
							,'; NR_CPF: ',I.NR_CPF
                            ,'; DT_EFETIVACAO: ',I.DT_EFETIVACAO
                            ,'; DT_EXONERACAO: ',I.DT_EXONERACAO
							,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO				
						)
			FROM DELETED D
			INNER JOIN INSERTED I ON I.ID_SERVIDOR=D.ID_SERVIDOR
		END;
-- Como as tabelas possuem flag para exclusão lógica, os usuários de aplicação não receberam permissão DELETE, mas por precaução a há previsão de auditoria para essa operação, conforme a seguir:
	IF @TP_OPERACAO='D'
		BEGIN	
			INSERT INTO AUDITORIA 
			SELECT @TP_OPERACAO
					,GETDATE()
					,SUSER_NAME()
					,'SERVIDOR'
					,CONCAT(
							'Exclusão física de cadastro de servidor. ** Dados:'
							,'ID_SERVIDOR: ',D.ID_SERVIDOR
							,'; CD_SIAPE: ',D.CD_SIAPE
							,'; NM_SERVIDOR: ',D.NM_SERVIDOR
							,'; TP_SEXO: ',D.TP_SEXO
							,'; DT_NASCIMENTO: ',D.DT_NASCIMENTO
							,'; NR_CPF: ',D.NR_CPF
							,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO
			
						)
			FROM DELETED D
			
		END;
		
	
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
                                   WHEN EXISTS(SELECT 1 FROM INSERTED) THEN 'U' -- UPDATE
                                   ELSE 'D'                                     -- DELETE
       END;
	IF @TP_OPERACAO='I'
		BEGIN	
			INSERT INTO AUDITORIA
			SELECT
				@TP_OPERACAO
				,GETDATE()
				,SUSER_NAME()
				,'LOTACAO_SERVIDOR'
				,CONCAT(
						'Cadastro de lotação de servidor realizado. Dados:'
						,' ID_SERVIDOR: ',I.ID_SERVIDOR
						,'; ID_SETOR ',I.ID_SETOR
						,'; SG_SETOR: ',ST.SG_SETOR
						,'; DT_INICIO_LOTACAO: ',I.DT_INICIO_LOTACAO
						,'; DT_FIM_LOTACAO: ',I.DT_FIM_LOTACAO
						,'; FG_LOTACAO_ATIVA: ',I.FG_LOTACAO_ATIVA
						,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO
					)
			FROM INSERTED I
			INNER JOIN SETOR ST ON ST.ID_SETOR=I.ID_SETOR
			
		END;

	IF @TP_OPERACAO='U'
		BEGIN
			INSERT INTO AUDITORIA 
			SELECT @TP_OPERACAO
					,GETDATE()
					,SUSER_NAME()
					,'LOTACAO_SERVIDOR'
					,CONCAT(
							'Alteração de cadastro de servidor. ** Dados antes a alteração:'
							,' ID_SERVIDOR: ',D.ID_SERVIDOR
							,'; ID_SETOR ',D.ID_SETOR
							,'; SG_SETOR: ',STD.SG_SETOR
							,'; DT_INICIO_LOTACAO: ',D.DT_INICIO_LOTACAO
							,'; DT_FIM_LOTACAO: ',D.DT_FIM_LOTACAO
							,'; FG_LOTACAO_ATIVA: ',D.FG_LOTACAO_ATIVA
							,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO	

							,' ID_SERVIDOR: ',I.ID_SERVIDOR
							,'; ID_SETOR ',I.ID_SETOR
							,'; SG_SETOR: ',STI.SG_SETOR
							,'; DT_INICIO_LOTACAO: ',I.DT_INICIO_LOTACAO
							,'; DT_FIM_LOTACAO: ',I.DT_FIM_LOTACAO
							,'; FG_LOTACAO_ATIVA: ',I.FG_LOTACAO_ATIVA
							,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO			
						)
			FROM DELETED D
			INNER JOIN SETOR STD ON STD.ID_SETOR=D.ID_SETOR
			INNER JOIN INSERTED I ON I.ID_SERVIDOR=D.ID_SERVIDOR
			INNER JOIN SETOR STI ON STI.ID_SETOR=D.ID_SETOR
		END;
-- Como as tabelas possuem flag para exclusão lógica, os usuários de aplicação não receberam permissão DELETE, mas por precaução a há previsão de auditoria para essa operação, conforme a seguir:
	IF @TP_OPERACAO='D'
		BEGIN	
			INSERT INTO AUDITORIA 
			SELECT @TP_OPERACAO
					,GETDATE()
					,SUSER_NAME()
					,'LOTACAO_SERVIDOR'
					,CONCAT(
							'Exclusão física de lotação de servidor. ** Dados:'
							,' ID_SERVIDOR: ',D.ID_SERVIDOR
							,'; ID_SETOR ',D.ID_SETOR
							,'; SG_SETOR: ',ST.SG_SETOR
							,'; DT_INICIO_LOTACAO: ',D.DT_INICIO_LOTACAO
							,'; DT_FIM_LOTACAO: ',D.DT_FIM_LOTACAO
							,'; FG_LOTACAO_ATIVA: ',D.FG_LOTACAO_ATIVA
							,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO	
			
						)
			FROM DELETED D
			INNER JOIN SETOR ST ON ST.ID_SETOR=D.ID_SETOR
			
		END;
		
	
END
GO


/*=====================================================*/
/* -- Trigger auditoria tabela VINCULO_SERVIDOR 	 --*/
/*=====================================================*/

IF EXISTS(SELECT 1 FROM SYS.triggers WHERE NAME='TG_AUD_VINCULOSERVIDOR')
	DROP TRIGGER TG_AUD_VINCULOSERVIDOR
GO


CREATE TRIGGER TG_AUD_VINCULOSERVIDOR
   ON  VINCULO_SERVIDOR
   AFTER INSERT,DELETE,UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @TP_OPERACAO CHAR(1)='I',
			@DS_OPERACAO VARCHAR(1000);

	

    -- Identificar a operação realizada
     IF  (EXISTS(SELECT 1 FROM DELETED))
          SET @TP_OPERACAO = CASE
                                   WHEN EXISTS(SELECT 1 FROM INSERTED) THEN 'U' -- UPDATE
                                   ELSE 'D'                                     -- DELETE
       END;
	IF @TP_OPERACAO='I'
		BEGIN	
			INSERT INTO AUDITORIA
			SELECT
				@TP_OPERACAO
				,GETDATE()
				,SUSER_NAME()
				,'VINCULO_SERVIDOR'
				,CONCAT(
						'Cadastro de vínculo de servidor realizado. Dados:'
						,' ID_SERVIDOR: ',I.ID_SERVIDOR
						,'; ID_CARGO ',I.ID_CARGO
						,'; NM_CARGO: ',C.NM_CARGO
						,'; DT_INICIO_VINCULO: ',I.DT_INICIO_VINCULO
						,'; DT_FIM_VINCULO: ',I.DT_FIM_VINCULO
						,'; FG_VINCULO_ATIVO: ',I.FG_VINCULO_ATIVO
						,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO
					)
			FROM INSERTED I
			INNER JOIN CARGO C ON C.ID_CARGO=I.ID_CARGO
			
		END;

	IF @TP_OPERACAO='U'
		BEGIN
			INSERT INTO AUDITORIA 
			SELECT @TP_OPERACAO
					,GETDATE()
					,SUSER_NAME()
					,'VINCULO_SERVIDOR'
					,CONCAT(
							'Alteração de vinculo de servidor. ** Dados antes a alteração:'
							,' ID_SERVIDOR: ',D.ID_SERVIDOR
							,'; ID_CARGO ',D.ID_CARGO
							,'; NM_CARGO: ',CD.NM_CARGO
							,'; DT_INICIO_VINCULO: ',D.DT_INICIO_VINCULO
							,'; DT_FIM_VINCULO: ',D.DT_FIM_VINCULO
							,'; FG_VINCULO_ATIVO: ',D.FG_VINCULO_ATIVO
							,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO		

							,' ID_SERVIDOR: ',I.ID_SERVIDOR
							,'; ID_CARGO ',I.ID_CARGO
							,'; NM_CARGO: ',CI.NM_CARGO
							,'; DT_INICIO_VINCULO: ',I.DT_INICIO_VINCULO
							,'; DT_FIM_VINCULO: ',I.DT_FIM_VINCULO
							,'; FG_VINCULO_ATIVO: ',I.FG_VINCULO_ATIVO
							,'; FG_REGISTRO_ATIVO: ',I.FG_REGISTRO_ATIVO		
						)
			FROM DELETED D
			INNER JOIN CARGO CD ON CD.ID_CARGO=D.ID_CARGO
			INNER JOIN INSERTED I ON I.ID_SERVIDOR=D.ID_SERVIDOR
			INNER JOIN CARGO CI ON CI.ID_CARGO=D.ID_CARGO
		END;
-- Como as tabelas possuem flag para exclusão lógica, os usuários de aplicação não receberam permissão DELETE, mas por precaução a há previsão de auditoria para essa operação, conforme a seguir:
	IF @TP_OPERACAO='D'
		BEGIN	
			INSERT INTO AUDITORIA 
			SELECT @TP_OPERACAO
					,GETDATE()
					,SUSER_NAME()
					,'VINCULO_SERVIDOR'
					,CONCAT(
							'Exclusão física de vinculo de servidor. ** Dados:'
							,' ID_SERVIDOR: ',D.ID_SERVIDOR
							,'; ID_CARGO ',D.ID_CARGO
							,'; NM_CARGO: ',C.NM_CARGO
							,'; DT_INICIO_VINCULO: ',D.DT_INICIO_VINCULO
							,'; DT_FIM_VINCULO: ',D.DT_FIM_VINCULO
							,'; FG_VINCULO_ATIVO: ',D.FG_VINCULO_ATIVO
							,'; FG_REGISTRO_ATIVO: ',D.FG_REGISTRO_ATIVO		
			
						)
			FROM DELETED D
			INNER JOIN CARGO C ON C.ID_CARGO=D.ID_CARGO
			
		END;
		
	
END
GO
