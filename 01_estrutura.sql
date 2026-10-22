
-- =====================================================
-- PROJETO: CONTROLE DE MANUTENCAO INDUSTRIAL
-- ARQUIVO: 01_estrutura.sql
-- SGBD: MariaDB 10.4
-- =====================================================

CREATE DATABASE IF NOT EXISTS controle_manutencao
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE controle_manutencao;

-- Tabela de usuarios do sistema
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    perfil ENUM(
        'ADMINISTRADOR',
        'TECNICO',
        'CONSULTA'
    ) NOT NULL,
    ativo TINYINT(1) NOT NULL DEFAULT 1,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de ativos industriais
CREATE TABLE IF NOT EXISTS ativos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(30) NOT NULL UNIQUE,
    nome VARCHAR(120) NOT NULL,
    descricao TEXT,
    localizacao VARCHAR(120) NOT NULL,
    status ENUM(
        'ATIVO',
        'INATIVO',
        'MANUTENCAO'
    ) NOT NULL DEFAULT 'ATIVO',
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de ordens de servico
CREATE TABLE IF NOT EXISTS ordens_servico (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ativo_id INT NOT NULL,
    solicitante_id INT NOT NULL,
    responsavel_id INT,
    tipo ENUM(
        'PREVENTIVA',
        'CORRETIVA',
        'PREDITIVA'
    ) NOT NULL,
    prioridade ENUM(
        'BAIXA',
        'MEDIA',
        'ALTA',
        'CRITICA'
    ) NOT NULL DEFAULT 'MEDIA',
    status ENUM(
        'ABERTA',
        'EM_ANDAMENTO',
        'CONCLUIDA',
        'CANCELADA'
    ) NOT NULL DEFAULT 'ABERTA',
    descricao TEXT NOT NULL,
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    atualizada_em TIMESTAMP NOT NULL
        DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    concluida_em DATETIME NULL,

    CONSTRAINT fk_os_ativo
        FOREIGN KEY (ativo_id)
        REFERENCES ativos(id),

    CONSTRAINT fk_os_solicitante
        FOREIGN KEY (solicitante_id)
        REFERENCES usuarios(id),

    CONSTRAINT fk_os_responsavel
        FOREIGN KEY (responsavel_id)
        REFERENCES usuarios(id),

    INDEX idx_os_status (status),
    INDEX idx_os_prioridade (prioridade),
    INDEX idx_os_ativo (ativo_id)
);

-- Tabela de intervencoes realizadas
CREATE TABLE IF NOT EXISTS intervencoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ordem_servico_id INT NOT NULL,
    tecnico_id INT NOT NULL,
    descricao TEXT NOT NULL,
    duracao_minutos INT NOT NULL,
    resultado TEXT,
    criada_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_duracao_positiva
        CHECK (duracao_minutos > 0),

    CONSTRAINT fk_intervencao_os
        FOREIGN KEY (ordem_servico_id)
        REFERENCES ordens_servico(id),

    CONSTRAINT fk_intervencao_tecnico
        FOREIGN KEY (tecnico_id)
        REFERENCES usuarios(id),

    INDEX idx_intervencao_os (ordem_servico_id),
    INDEX idx_intervencao_tecnico (tecnico_id)
);

-- Tabela de auditoria
CREATE TABLE IF NOT EXISTS auditoria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NULL,
    acao VARCHAR(30) NOT NULL,
    tabela_afetada VARCHAR(64) NOT NULL,
    registro_id INT NULL,
    detalhes LONGTEXT,
    criado_em TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_auditoria_usuario
        FOREIGN KEY (usuario_id)
        REFERENCES usuarios(id)
        ON DELETE SET NULL,

    INDEX idx_auditoria_usuario (usuario_id),
    INDEX idx_auditoria_data (criado_em)
);
