
-- =====================================================
-- PROJETO: CONTROLE DE MANUTENCAO INDUSTRIAL
-- ARQUIVO: 02_dados_teste.sql
-- Dados demonstrativos para homologacao
-- =====================================================

USE controle_manutencao;

-- Usuarios de teste
-- As senhas abaixo sao hashes ficticios.
-- Nao utilizar para autenticacao real.

INSERT INTO usuarios
    (nome, email, senha_hash, perfil, ativo)
VALUES
    (
        'Administrador do Sistema',
        'admin@industria.local',
        '$2b$12$HASH_DE_TESTE_NAO_UTILIZAR_EM_PRODUCAO',
        'ADMINISTRADOR',
        1
    ),
    (
        'Carlos Silva',
        'carlos@industria.local',
        '$2b$12$HASH_DE_TESTE_NAO_UTILIZAR_EM_PRODUCAO',
        'TECNICO',
        1
    ),
    (
        'Maria Santos',
        'maria@industria.local',
        '$2b$12$HASH_DE_TESTE_NAO_UTILIZAR_EM_PRODUCAO',
        'CONSULTA',
        1
    );

-- Ativos de teste
INSERT INTO ativos
    (codigo, nome, descricao, localizacao, status)
VALUES
    (
        'ATV-001',
        'Motor industrial',
        'Motor eletrico da linha de producao',
        'Setor de Manutencao',
        'ATIVO'
    ),
    (
        'ATV-002',
        'Esteira transportadora',
        'Esteira utilizada no transporte de materiais',
        'Setor de Logistica',
        'ATIVO'
    );

-- Ordem de servico de exemplo
INSERT INTO ordens_servico
    (
        ativo_id,
        solicitante_id,
        responsavel_id,
        tipo,
        prioridade,
        status,
        descricao,
        concluida_em
    )
VALUES
    (
        1,
        3,
        2,
        'PREVENTIVA',
        'ALTA',
        'CONCLUIDA',
        'Inspecionar o motor e verificar possiveis desgastes.',
        CURRENT_TIMESTAMP
    );

-- Intervencao de exemplo
INSERT INTO intervencoes
    (
        ordem_servico_id,
        tecnico_id,
        descricao,
        duracao_minutos,
        resultado
    )
VALUES
    (
        1,
        2,
        'Inspecao visual e verificacao de ruidos.',
        30,
        'Inspecao realizada; acompanhamento recomendado.'
    );

-- Registro demonstrativo de auditoria
INSERT INTO auditoria
    (
        usuario_id,
        acao,
        tabela_afetada,
        registro_id,
        detalhes
    )
VALUES
    (
        1,
        'INSERT',
        'ativos',
        1,
        '{"motivo": "Cadastro inicial para homologacao"}'
    );
