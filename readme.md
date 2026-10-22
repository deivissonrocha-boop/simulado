# Controle de Manutenção Industrial

## Descrição
Projeto de banco de dados relacional para apoiar o controle de ativos industriais, ordens de serviço de manutenção, intervenções técnicas e auditoria das operações.

## Objetivos
- Cadastrar e consultar usuários do sistema.
- Registrar equipamentos e seus estados.
- Controlar ordens de serviço e prioridades.
- Registrar intervenções realizadas pelos técnicos.
- Manter registros de auditoria.
- Aplicar permissões de acesso de acordo com os papéis dos usuários.

## Tecnologias
- MariaDB 10.4.32
- SQL
- Git

## Estrutura do projeto
- `sql/01_estrutura.sql`: criação do banco e das tabelas.
- `sql/02_dados_teste.sql`: inserção de dados para testes.
- `sql/03_operacoes.sql`: operações de consulta e manipulação de dados.
- `sql/04_seguranca.sql`: usuários, papéis e permissões.

## Execução
Execute os scripts na ordem indicada, utilizando o MariaDB e uma ferramenta de administração SQL, como o MySQL Workbench.

## Segurança
As senhas e os dados utilizados para homologação são demonstrativos. Antes de usar em produção, devem ser substituídos por credenciais seguras e hashes de senha válidos.

## Versionamento
O projeto utiliza Git para registrar as alterações realizadas durante o desenvolvimento.