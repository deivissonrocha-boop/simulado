
-- =====================================================
-- PROJETO: CONTROLE DE MANUTENCAO INDUSTRIAL
-- ARQUIVO: 04_seguranca.sql
-- Usuarios, papeis e permissoes
-- SGBD: MariaDB 10.4
-- =====================================================

USE controle_manutencao;

-- Criar papeis de acesso
CREATE ROLE IF NOT EXISTS papel_admin;
CREATE ROLE IF NOT EXISTS papel_tecnico;
CREATE ROLE IF NOT EXISTS papel_consulta;

-- Permissoes do administrador
GRANT ALL PRIVILEGES
ON controle_manutencao.*
TO papel_admin;

-- Permissoes do tecnico
GRANT SELECT
ON controle_manutencao.ativos
TO papel_tecnico;

GRANT SELECT
ON controle_manutencao.usuarios
TO papel_tecnico;

GRANT SELECT, UPDATE (responsavel_id, status, concluida_em)
ON controle_manutencao.ordens_servico
TO papel_tecnico;

GRANT SELECT, INSERT
ON controle_manutencao.intervencoes
TO papel_tecnico;

-- Permissoes do perfil de consulta
GRANT SELECT
ON controle_manutencao.ativos
TO papel_consulta;

GRANT SELECT
ON controle_manutencao.ordens_servico
TO papel_consulta;

-- Criar contas de aplicacao
-- Substitua as senhas antes de usar em ambiente real.
CREATE USER IF NOT EXISTS 'app_admin'@'localhost'
IDENTIFIED BY 'Troque_Esta_Senha_Admin@123';

CREATE USER IF NOT EXISTS 'app_tecnico'@'localhost'
IDENTIFIED BY 'Troque_Esta_Senha_Tecnico@123';

CREATE USER IF NOT EXISTS 'app_consulta'@'localhost'
IDENTIFIED BY 'Troque_Esta_Senha_Consulta@123';

-- Associar papeis as contas
GRANT papel_admin TO 'app_admin'@'localhost';
GRANT papel_tecnico TO 'app_tecnico'@'localhost';
GRANT papel_consulta TO 'app_consulta'@'localhost';

-- Definir papeis padrao no MariaDB 10.4
SET DEFAULT ROLE papel_admin FOR 'app_admin'@'localhost';
SET DEFAULT ROLE papel_tecnico FOR 'app_tecnico'@'localhost';
SET DEFAULT ROLE papel_consulta FOR 'app_consulta'@'localhost';

-- Conferir permissoes
SHOW GRANTS FOR 'papel_admin';
SHOW GRANTS FOR 'papel_tecnico';
SHOW GRANTS FOR 'papel_consulta';

SHOW GRANTS FOR 'app_admin'@'localhost';
SHOW GRANTS FOR 'app_tecnico'@'localhost';
SHOW GRANTS FOR 'app_consulta'@'localhost';
