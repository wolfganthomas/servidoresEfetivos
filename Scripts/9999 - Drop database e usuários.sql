/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan					                      */
/*  Data de cria��o: 21/09/2024				                              */
/*  Finalidade do script:						                          */
/*     Possibilitar remo��o da base de dados. 				              */ 
/*     Script criado para facilitar testes, s� deve ser utilizado se	  */ 
/*     desejar recriar o ambiente do zero                        		  */ 
/*  Sum�rio do Script:                                                    */
/*     1. Remove a base de dados SERVIDOR_EFETIVO	    		          */
/*========================================================================*/


USE MASTER
DROP DATABASE SERVIDOR_EFETIVO

-- ALTERA O BANCO DE DADOS PARA SINGLE_USER, FOR�ANDO A DESCONEX�O DE TODOS OS USU�RIOS
ALTER DATABASE SERVIDOR_EFETIVO 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;

-- EXCLUI O BANCO DE DADOS
DROP DATABASE SERVIDOR_EFETIVO;
