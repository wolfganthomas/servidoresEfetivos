/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan			                  */
/*  Data de criação: 21/09/2024				                  */
/*  Finalidade do script:						  */
/*     Criar views para consulta de lotação e vínculo de servidores	  */ 
/*  Sumário do Script:                                                    */
/*     1. Cria a view VW_SERVIDORES_LOTACOES                              */
/*     2. Cria a view VW_SERVIVORES_VINCULOS                              */
/*========================================================================*/


USE SERVIDOR_EFETIVO
GO
CREATE VIEW VW_SERVIDORES_LOTACOES AS
SELECT 
	S.ID_SERVIDOR
	,S.CD_SIAPE CD_SIAPE
	,S.NM_SERVIDOR NOME
	,ST.SG_SETOR
	,ST.NM_SETOR
	,LS.DT_INICIO_LOTACAO
	,LS.DT_FIM_LOTACAO
FROM SERVIDOR S 
INNER JOIN LOTACAO_SERVIDOR LS ON LS.ID_SERVIDOR=S.ID_SERVIDOR
INNER JOIN SETOR ST ON ST.ID_SETOR=LS.ID_SETOR
GO

GRANT SELECT ON VW_SERVIDORES_LOTACOES TO USR_SERVIDOREFETIVO

GO

CREATE VIEW VW_SERVIVORES_VINCULOS AS
SELECT 
	S.ID_SERVIDOR
	,S.CD_SIAPE CD_SIAPE
	,S.NM_SERVIDOR NOME
	,C.NM_CARGO 
	,VS.DT_INICIO_VINCULO
	,VS.DT_FIM_VINCULO
FROM SERVIDOR S 
INNER JOIN VINCULO_SERVIDOR VS ON VS.ID_SERVIDOR=S.ID_SERVIDOR
INNER JOIN CARGO C ON C.ID_CARGO=VS.ID_CARGO
GO

GRANT SELECT ON VW_SERVIVORES_VINCULOS TO USR_SERVIDOREFETIVO
GO

/*=========================================================================*/
/* = Observação em relação à ordenação da view VW_SERVIVORES_VINCULOS     =*/
/*   No SQL Server, a cláusula order by só funciona diretamente dentro de  */
/*   uma view se for combinada com uma das seguintes cláusulas:            */
/*   TOP, OFFSET or FOR XML                                                */
/*   Portanto, a consulta pode ser ordenada ao consultar a view            */
/*=========================================================================*/

SELECT *
FROM VW_SERVIVORES_VINCULOS 
ORDER BY DT_INICIO_VINCULO
 
