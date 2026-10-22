
# Projeto Integrado de Banco de Dados — Controle de Manutenção Industrial

## 1. Identificação do projeto

**Projeto:** Controle de Manutenção Industrial  
**SGBD:** MariaDB 10.4  
**Linguagem:** SQL  
**Versionamento:** Git  
**Banco de dados:** controle_manutencao

## 2. Objetivo

O projeto tem como objetivo estruturar um banco de dados para centralizar as informações relacionadas aos ativos industriais, às ordens de serviço e às intervenções realizadas nos equipamentos. A solução busca facilitar a rastreabilidade das atividades de manutenção, organizar os registros e controlar o acesso às informações conforme o perfil de cada usuário.

## 3. Levantamento de requisitos

### 3.1 Requisitos funcionais

- RF01: cadastrar e consultar usuários do sistema.
- RF02: registrar ativos industriais, incluindo código, nome, localização e situação.
- RF03: registrar ordens de serviço vinculadas aos ativos.
- RF04: identificar o solicitante e o responsável por cada ordem de serviço.
- RF05: classificar as ordens por tipo, prioridade e situação.
- RF06: registrar as intervenções realizadas, identificando o técnico, a descrição, a duração e o resultado.
- RF07: consultar ordens de serviço e seus respectivos ativos e responsáveis.
- RF08: registrar informações de auditoria sobre operações relevantes.
- RF09: restringir o acesso aos dados de acordo com os papéis de segurança.
- RF10: permitir consultas e atualizações necessárias às rotinas de manutenção.

### 3.2 Requisitos não funcionais

- RNF01: utilizar um SGBD relacional.
- RNF02: manter integridade referencial entre as tabelas.
- RNF03: padronizar os nomes das tabelas, colunas e chaves.
- RNF04: aplicar permissões de acesso seguindo o princípio do menor privilégio.
- RNF05: organizar os scripts SQL em arquivos separados por finalidade.
- RNF06: utilizar Git para registrar as alterações do desenvolvimento.
- RNF07: armazenar senhas utilizando hashes seguros, nunca em texto puro.
- RNF08: possibilitar consultas organizadas por meio de relacionamentos e índices.

## 4. Escolha do banco de dados

Foi escolhido o MariaDB 10.4 por ser um sistema gerenciador de banco de dados relacional compatível com SQL e adequado ao armazenamento de dados estruturados. O uso de chaves primárias, chaves estrangeiras, restrições e índices contribui para a integridade e a organização das informações.

## 5. Entidades e atributos

### 5.1 Usuarios

Armazena os dados dos usuários autorizados a acessar o sistema.

- id: identificador único do usuário, chave primária.
- nome: nome do usuário.
- email: endereço de e-mail, com restrição de unicidade.
- senha_hash: hash da senha.
- perfil: papel do usuário, como ADMINISTRADOR, TECNICO ou CONSULTA.
- ativo: indica se a conta está ativa.
- criado_em: data e hora do cadastro.

### 5.2 Ativos

Armazena os equipamentos e demais ativos industriais.

- id: identificador único, chave primária.
- codigo: código de identificação do ativo.
- nome: nome do equipamento.
- descricao: informações complementares.
- localizacao: local onde o ativo está instalado.
- status: situação do ativo, como ATIVO, INATIVO ou MANUTENCAO.
- criado_em: data e hora do cadastro.

### 5.3 Ordens de serviço

Registra as solicitações e atividades de manutenção.

- id: identificador único, chave primária.
- ativo_id: referência ao ativo relacionado.
- solicitante_id: referência ao usuário solicitante.
- responsavel_id: referência ao usuário responsável.
- tipo: classificação da manutenção.
- prioridade: nível de prioridade.
- status: situação da ordem.
- descricao: descrição do serviço solicitado.
- criada_em: data e hora de criação.
- atualizada_em: data e hora da última atualização.
- concluida_em: data e hora da conclusão, quando aplicável.

### 5.4 Intervencoes

Registra as atividades executadas durante uma ordem de serviço.

- id: identificador único, chave primária.
- ordem_servico_id: referência à ordem de serviço.
- tecnico_id: referência ao usuário técnico.
- descricao: descrição da intervenção.
- duracao_minutos: duração da atividade em minutos.
- resultado: resultado obtido na intervenção.
- criada_em: data e hora do registro.

### 5.5 Auditoria

Armazena registros de operações relevantes para rastreabilidade.

- id: identificador único, chave primária.
- usuario_id: usuário que realizou a operação, quando identificado.
- acao: tipo de operação registrada.
- tabela_afetada: tabela relacionada à operação.
- registro_id: identificador do registro afetado.
- detalhes: informações complementares da operação.
- criado_em: data e hora do registro.

## 6. Relacionamentos e cardinalidade

- Usuarios e Ordens de serviço: um usuário pode solicitar várias ordens. Cada ordem possui um solicitante.
- Usuarios e Ordens de serviço: um usuário pode ser responsável por várias ordens. Cada ordem possui um responsável definido no modelo.
- Ativos e Ordens de serviço: um ativo pode possuir várias ordens ao longo do tempo. Cada ordem está relacionada a um ativo.
- Ordens de serviço e Intervencoes: uma ordem pode possuir várias intervenções. Cada intervenção pertence a uma ordem.
- Usuarios e Intervencoes: um técnico pode registrar várias intervenções. Cada intervenção está associada a um técnico.
- Usuarios e Auditoria: um usuário pode estar relacionado a vários registros de auditoria. Um registro de auditoria pode não ter um usuário associado, conforme a regra de exclusão definida.

### Resumo das cardinalidades

- Usuarios (1) — (N) Ordens de serviço, pelo papel de solicitante.
- Usuarios (1) — (N) Ordens de serviço, pelo papel de responsável.
- Ativos (1) — (N) Ordens de serviço.
- Ordens de serviço (1) — (N) Intervencoes.
- Usuarios (1) — (N) Intervencoes.
- Usuarios (0..1) — (N) Auditoria, considerando a possibilidade de o usuário não estar associado ao registro.

## 7. Regras de negócio e restrições

- Cada usuário deve possuir um identificador único.
- O e-mail do usuário não deve ser duplicado.
- Cada ativo deve possuir um código de identificação único.
- Uma ordem de serviço deve estar vinculada a um ativo existente.
- O solicitante e o responsável devem referenciar usuários cadastrados.
- Uma intervenção deve estar vinculada a uma ordem de serviço existente e a um técnico cadastrado.
- A duração de uma intervenção deve ser maior que zero.
- Os valores de tipo, prioridade e situação devem respeitar os domínios definidos no banco.
- A conclusão de uma ordem deve ser registrada quando aplicável.
- O acesso às tabelas deve respeitar as permissões concedidas a cada papel.
- As senhas não devem ser armazenadas em texto puro.
- Registros de auditoria devem permitir identificar a operação, a tabela afetada e a data do evento.

As restrições devem ser implementadas no banco sempre que possível, utilizando chaves primárias, chaves estrangeiras, índices, valores enumerados e restrições de validação compatíveis com a versão do MariaDB.

## 8. Modelagem relacional

O modelo relacional é composto pelas seguintes relações:

- USUARIOS (id, nome, email, senha_hash, perfil, ativo, criado_em)
- ATIVOS (id, codigo, nome, descricao, localizacao, status, criado_em)
- ORDENS_SERVICO (id, ativo_id, solicitante_id, responsavel_id, tipo, prioridade, status, descricao, criada_em, atualizada_em, concluida_em)
- INTERVENCOES (id, ordem_servico_id, tecnico_id, descricao, duracao_minutos, resultado, criada_em)
- AUDITORIA (id, usuario_id, acao, tabela_afetada, registro_id, detalhes, criado_em)

As chaves estrangeiras conectam as relações e evitam referências a registros inexistentes, de acordo com as regras de integridade definidas no esquema.

## 9. Normalização

### Primeira Forma Normal (1FN)

Cada tabela possui uma chave primária e os atributos foram planejados para armazenar valores individuais, sem listas de valores dentro de uma mesma coluna. Por exemplo, cada intervenção é registrada em uma linha própria.

### Segunda Forma Normal (2FN)

As tabelas utilizam chaves primárias simples. Dessa forma, não existem dependências parciais de atributos em relação a uma parte de uma chave primária composta.

### Terceira Forma Normal (3FN)

Os dados foram separados conforme suas entidades e responsabilidades. Os dados dos usuários ficam em USUARIOS, os dados dos ativos em ATIVOS, as solicitações em ORDENS_SERVICO e as atividades executadas em INTERVENCOES. Essa separação reduz a repetição de informações e facilita a manutenção dos registros.

A tabela AUDITORIA possui finalidade específica de rastreabilidade. Sua coluna detalhes pode armazenar informações complementares da operação, conforme o formato definido na implementação.

## 10. Padrão de nomenclatura

- Utilizar nomes de tabelas e colunas em português, sem acentos ou espaços.
- Utilizar nomes em letras minúsculas e separar palavras com sublinhado.
- Utilizar id como identificador primário das tabelas.
- Identificar chaves estrangeiras com o nome da entidade de referência seguido de _id.
- Utilizar nomes descritivos para facilitar a leitura das consultas.
- Manter os nomes dos arquivos SQL numerados conforme sua finalidade.
- Utilizar os mesmos termos nos documentos e nos scripts.

## 11. Segurança e controle de acesso

Foram definidos três papéis de acesso:

- papel_admin: responsável pela administração do banco e das tabelas.
- papel_tecnico: consulta ativos e usuários, consulta e atualiza campos autorizados das ordens e registra intervenções.
- papel_consulta: possui acesso de leitura aos ativos e às ordens de serviço.

A configuração utiliza usuários de banco separados dos papéis de permissão. O objetivo é aplicar o princípio do menor privilégio, concedendo somente as permissões necessárias para cada função.

As credenciais devem ser protegidas, as senhas devem ser armazenadas por meio de hashes seguros e as permissões devem ser verificadas com os comandos SHOW GRANTS.

## 12. Tratamento de dados e operações

Os scripts SQL estão organizados por finalidade:

- sql/01_estrutura.sql: criação do banco e definição das tabelas, chaves e restrições (DDL).
- sql/02_dados_teste.sql: inserção de registros de demonstração (DML).
- sql/03_operacoes.sql: consultas, relacionamentos, filtros e exemplos de atualização e transação.
- sql/04_seguranca.sql: criação e configuração de papéis, usuários e permissões.

As operações de atualização devem ser executadas com atenção às condições da consulta. Transações com COMMIT e ROLLBACK podem ser utilizadas para controlar operações que precisem ser confirmadas ou desfeitas.

Os dados de demonstração servem para validar a estrutura e as consultas, não devendo ser tratados como dados reais de produção.

## 13. Ambiente e versionamento

O desenvolvimento utiliza MariaDB 10.4, scripts SQL e Git. O histórico de alterações é mantido em commits com mensagens descritivas, permitindo identificar etapas do projeto e acompanhar mudanças nos arquivos.

Os scripts são organizados na pasta sql e a documentação do projeto permanece na raiz do repositório.

Para consultar o estado do repositório, utilizar:

    git status

Para visualizar o histórico:

    git log --oneline

Para registrar novas alterações:

    git add -A
    git commit -m "Descrição da alteração"

## 14. Premissas e limitações

O projeto considera que os usuários, ativos, ordens e intervenções são administrados por uma aplicação corporativa com acesso ao banco de dados.

Os papéis e as permissões descritos representam o controle de acesso no nível do banco. A aplicação também deverá validar as operações e autenticar seus usuários adequadamente.

Os dados de teste são fictícios. Antes de utilizar o sistema em produção, é necessário revisar as credenciais, confirmar as restrições e validar os scripts no ambiente definitivo.

A documentação descreve o modelo proposto. A estrutura efetivamente criada no banco deve ser conferida com os scripts e com as definições reais das tabelas.

## 15. Conclusão

O projeto organiza os dados de manutenção industrial em um modelo relacional, com entidades separadas, relacionamentos definidos, regras de integridade, controle de acesso e operações SQL. A separação dos scripts e o uso do Git contribuem para a organização, a rastreabilidade e a manutenção do desenvolvimento.
