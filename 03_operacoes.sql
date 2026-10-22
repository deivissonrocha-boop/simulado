
-- =====================================================
-- PROJETO: CONTROLE DE MANUTENCAO INDUSTRIAL
-- ARQUIVO: 03_operacoes.sql
-- Consultas e operacoes do sistema
-- =====================================================

USE controle_manutencao;

-- 1. Consultar todos os ativos
SELECT
    id,
    codigo,
    nome,
    localizacao,
    status
FROM ativos
ORDER BY codigo;

-- 2. Consultar ordens de servico com ativo e responsavel
SELECT
    os.id AS ordem_id,
    a.codigo AS codigo_ativo,
    a.nome AS ativo,
    solicitante.nome AS solicitante,
    responsavel.nome AS tecnico_responsavel,
    os.tipo,
    os.prioridade,
    os.status,
    os.descricao,
    os.criada_em
FROM ordens_servico AS os
INNER JOIN ativos AS a
    ON a.id = os.ativo_id
INNER JOIN usuarios AS solicitante
    ON solicitante.id = os.solicitante_id
LEFT JOIN usuarios AS responsavel
    ON responsavel.id = os.responsavel_id
ORDER BY os.criada_em DESC;

-- 3. Consultar ordens abertas ou em andamento
SELECT
    id,
    ativo_id,
    responsavel_id,
    prioridade,
    status,
    descricao,
    criada_em
FROM ordens_servico
WHERE status IN ('ABERTA', 'EM_ANDAMENTO')
ORDER BY
    CASE prioridade
        WHEN 'CRITICA' THEN 1
        WHEN 'ALTA' THEN 2
        WHEN 'MEDIA' THEN 3
        WHEN 'BAIXA' THEN 4
    END,
    criada_em;

-- 4. Consultar intervencoes e os tecnicos responsaveis
SELECT
    i.id AS intervencao_id,
    i.ordem_servico_id,
    u.nome AS tecnico,
    i.descricao,
    i.duracao_minutos,
    i.resultado,
    i.criada_em
FROM intervencoes AS i
INNER JOIN usuarios AS u
    ON u.id = i.tecnico_id
ORDER BY i.criada_em DESC;

-- 5. Resumir a quantidade de ordens por status
SELECT
    status,
    COUNT(*) AS quantidade
FROM ordens_servico
GROUP BY status
ORDER BY status;

-- 6. Consultar o historico de auditoria
SELECT
    id,
    usuario_id,
    acao,
    tabela_afetada,
    registro_id,
    detalhes,
    criado_em
FROM auditoria
ORDER BY criado_em DESC;

-- 7. EXEMPLO DE OPERACAO DE ATUALIZACAO
-- Descomente e execute somente quando desejar
-- atribuir a ordem a um tecnico.
--
-- UPDATE ordens_servico
-- SET responsavel_id = 2,
--     status = 'EM_ANDAMENTO'
-- WHERE id = 1
--   AND status = 'ABERTA';

-- 8. EXEMPLO DE TRANSACAO
-- Exemplo demonstrativo; nao executar automaticamente.
--
-- START TRANSACTION;
--
-- UPDATE ordens_servico
-- SET status = 'CONCLUIDA',
--     concluida_em = CURRENT_TIMESTAMP
-- WHERE id = 1
--   AND status = 'EM_ANDAMENTO';
--
-- COMMIT;
--
-- Se precisar cancelar uma transacao antes do COMMIT,
-- utilize ROLLBACK.
