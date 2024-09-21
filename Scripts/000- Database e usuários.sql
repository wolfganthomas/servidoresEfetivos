/*========================================================================*/
/*  Autor do Script: Thomas Wolfgan			                  */
/*  Data de criação: 21/09/2024				                  */
/*  Finalidade do script:				                  */
/*     Criar database e usuários que serão utilizados                     */ 
/*  Sumário do Script:                                                    */
/*     1. Cria a database SERVIDOR_EFETIVO                                */
/*     2. Cria o usuário de usr_servidorefetivo                           */
/*     3. Cria o usuário de usr_servidorefetivo_bi                        */
/*========================================================================*/

USE MASTER
GO
CREATE DATABASE SERVIDOR_EFETIVO

CREATE LOGIN usr_servidorefetivo WITH PASSWORD='usr_servidorefetivo', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF

USE SERVIDOR_EFETIVO
GO
CREATE USER usr_servidorefetivo FOR LOGIN usr_servidorefetivo
GO

CREATE LOGIN usr_servidorefetivo_bi WITH PASSWORD='usr_servidorefetivo_bi', CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF

USE SERVIDOR_EFETIVO
GO
CREATE USER usr_servidorefetivo_bi FOR LOGIN usr_servidorefetivo_bi
GO
