/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan					  */
/*  Data de criação: 21/09/2024					          */
/*  Finalidade do script:						  */
/*     Possibilitar remoção da base de dados. 				  */ 
/*     Script criado para facilitar testes, só deve ser utilizado se  	  */ 
/*     desejar recriar o ambiente do zero                        	  */ 
/*  Sumário do Script:                                                    */
/*     1. Remove a base de dados SERVIDOR_EFETIVO	    		  */
/*========================================================================*/


USE MASTER
DROP DATABASE SERVIDOR_EFETIVO

-- ALTERA O BANCO DE DADOS PARA SINGLE_USER, FORÇANDO A DESCONEXÃO DE TODOS OS USUÁRIOS
ALTER DATABASE SERVIDOR_EFETIVO 
SET SINGLE_USER 
WITH ROLLBACK IMMEDIATE;

-- EXCLUI O BANCO DE DADOS
DROP DATABASE SERVIDOR_EFETIVO;
