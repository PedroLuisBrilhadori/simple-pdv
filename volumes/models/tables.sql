CREATE TABLE pdv.tb_usuarios (
    id UUID DEFAULT uuid_generate_v4(), 
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    nome VARCHAR(255) NOT NULL,
    ativo NUMERIC (1, 0) DEFAULT 1 NOT NULL,
    admin NUMERIC (1, 0) DEFAULT 0 NOT NULL,

    PRIMARY KEY (id)
); 

CREATE TABLE pdv.tb_produtos (
    codigo BIGINT GENERATED ALWAYS AS IDENTITY,
    nome VARCHAR(255) NOT NULL, 
    
    -- preço
    valor NUMERIC(15, 2) NOT NULL,
    desconto NUMERIC(3, 2) DEFAULT 0 NOT NULL, 
    taxa NUMERIC(3, 2) DEFAULT 0 NOT NULL,
    -- KG, UN, PL
    valor_tipo VARCHAR(2) DEFAULT 'KG' NOT NULL,

    ativo NUMERIC (1, 0) DEFAULT 1 NOT NULL,

    PRIMARY KEY (codigo)
);

CREATE TABLE pdv.tb_precos_produto (
    id UUID DEFAULT uuid_generate_v4(), 
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    -- preço
    valor NUMERIC(15, 2) NOT NULL,
    desconto NUMERIC(3, 2) DEFAULT 0 NOT NULL, 
    taxa NUMERIC(3, 2) DEFAULT 0 NOT NULL,
    -- KG, UN, PL
    valor_tipo VARCHAR(2) DEFAULT 'KG' NOT NULL,

    produto_codigo BIGINT NOT NULL,
    modificado_por UUID NOT NULL, 

    ativo NUMERIC (1, 0) DEFAULT 1 NOT NULL,

    PRIMARY KEY (id),
    FOREIGN KEY (produto_codigo) REFERENCES pdv.tb_produtos (codigo), 
    FOREIGN KEY (modificado_por) REFERENCES pdv.tb_usuarios (id)
);

CREATE TABLE pdv.tb_estoque (
    codigo BIGINT,
    quantidade NUMERIC(15, 3) DEFAULT 0 NOT NULL, 

    produto_codigo BIGINT,
    ativo NUMERIC (1, 0) DEFAULT 1 NOT NULL,

    PRIMARY KEY (codigo),
    FOREIGN KEY (produto_codigo) REFERENCES pdv.tb_produtos (codigo)
);


CREATE TABLE pdv.tb_movimentacao_estoque (
    id UUID DEFAULT uuid_generate_v4(), 
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    quantidade_inicial NUMERIC(15, 3) DEFAULT 0 NOT NULL,
    quantidade NUMERIC(15, 3) DEFAULT 0 NOT NULL, 
    quantidade_final NUMERIC(15, 3) DEFAULT 0 NOT NULL, 

    estoque_codigo BIGINT NOT NULL, 
    produto_codigo BIGINT NOT NULL,
    modificado_por UUID NOT NULL,  

    PRIMARY KEY (id),
    FOREIGN KEY (estoque_codigo) REFERENCES pdv.tb_estoque (codigo), 
    FOREIGN KEY (produto_codigo) REFERENCES pdv.tb_produtos (codigo),
    FOREIGN KEY (modificado_por) REFERENCES pdv.tb_usuarios (id)
);


CREATE TABLE pdv.tb_clientes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(), 
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    nome VARCHAR(255) NOT NULL,
    contato VARCHAR(40)
);

CREATE TABLE pdv.tb_formas_pagamento (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    nome VARCHAR(20), 

    PRIMARY KEY (id)
);

CREATE TABLE pdv.tb_metodos_venda (
    id INTEGER GENERATED ALWAYS AS IDENTITY, 
    nome VARCHAR(20), 

    PRIMARY KEY (id)
);

-- travar modificações na tabela
CREATE TABLE pdv.tb_vendas (
    id UUID DEFAULT uuid_generate_v4(), 
    criado_em TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,

    valor_final NUMERIC(15, 2) NOT NULL, 
    valor NUMERIC(15, 2) NOT NULL, 
    desconto NUMERIC(3, 2) DEFAULT 0 NOT NULL, 
    taxa NUMERIC(3, 2) DEFAULT 0 NOT NULL,

    metodo_venda_id INTEGER DEFAULT 1 NOT NULL,
    forma_pagamento_id INTEGER NOT NULL,
    criado_por UUID NOT NULL,
    cliente_id UUID, 

    PRIMARY KEY (id),
    FOREIGN KEY (criado_por) REFERENCES pdv.tb_usuarios (id), 
    FOREIGN KEY (cliente_id) REFERENCES pdv.tb_clientes (id), 
    FOREIGN KEY (forma_pagamento_id) REFERENCES pdv.tb_formas_pagamento (id), 
    FOREIGN KEY (metodo_venda_id) REFERENCES pdv.tb_metodos_venda (id)
);

-- travar modificações na tabela
CREATE TABLE pdv.tb_venda_produtos (
    id UUID DEFAULT uuid_generate_v4(),

    quantidade NUMERIC(15, 3) DEFAULT 0 NOT NULL, 

    valor_final NUMERIC(15, 2) NOT NULL, 
    valor NUMERIC(15, 2) NOT NULL, 
    desconto NUMERIC(3, 2) DEFAULT 0 NOT NULL, 
    taxa NUMERIC(3, 2) DEFAULT 0 NOT NULL,

    venda_id UUID NOT NULL,
    produto_codigo BIGINT NOT NULL,

    FOREIGN KEY (venda_id) REFERENCES pdv.tb_vendas, 
    FOREIGN KEY (produto_codigo) REFERENCES pdv.tb_produtos
);