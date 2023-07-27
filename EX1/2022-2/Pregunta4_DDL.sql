
CREATE TABLE cliente (
    cocliente     NUMBER(8) NOT NULL,
    razonsocial   VARCHAR2(60) NOT NULL,
    idzona        NUMBER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cocliente );

CREATE TABLE docventa (
    cocliente      NUMBER(8) NOT NULL,
    nrodocumento   NUMBER(10) NOT NULL,
    fecha          DATE NOT NULL,
    monto          NUMBER NOT NULL,
    idvendedor     NUMBER(8) NOT NULL
);

ALTER TABLE docventa ADD CONSTRAINT docventa_pk PRIMARY KEY ( nrodocumento );

CREATE TABLE docventaxproducto (
    nrodocumento   NUMBER(8) NOT NULL,
    coproducto     NUMBER(8) NOT NULL,
    cantidad       NUMBER(8, 2) NOT NULL,
    subtotal       NUMBER(8, 2) NOT NULL
);

ALTER TABLE docventaxproducto ADD CONSTRAINT docventaxproducto_pk PRIMARY KEY ( nrodocumento,
                                                                                coproducto );

CREATE TABLE producto (
    coproducto   NUMBER(8) NOT NULL,
    nombre       VARCHAR2(60) NOT NULL,
    precio       NUMBER(8, 2) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( coproducto );

CREATE TABLE vendedor (
    idvendedor        NUMBER(8) NOT NULL,
    nombres           VARCHAR2(60) NOT NULL,
    appaterno         VARCHAR2(60) NOT NULL,
    nrodocidentidad   VARCHAR2(10) NOT NULL,
    idzona            NUMBER NOT NULL
);

CREATE UNIQUE INDEX vendedor__idx ON
    vendedor (
        idzona
    ASC );

ALTER TABLE vendedor ADD CONSTRAINT vendedor_pk PRIMARY KEY ( idvendedor );

ALTER TABLE docventa
    ADD CONSTRAINT docventa_cliente_fk FOREIGN KEY ( cocliente )
        REFERENCES cliente ( cocliente );

ALTER TABLE docventa
    ADD CONSTRAINT docventa_vendedor_fk FOREIGN KEY ( idvendedor )
        REFERENCES vendedor ( idvendedor );

ALTER TABLE docventaxproducto
    ADD CONSTRAINT docventaxproducto_docventa_fk FOREIGN KEY ( nrodocumento )
        REFERENCES docventa ( nrodocumento );

ALTER TABLE docventaxproducto
    ADD CONSTRAINT docventaxproducto_producto_fk FOREIGN KEY ( coproducto )
        REFERENCES producto ( coproducto );




