-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-05-14 14:30:04 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cliente (
    cocliente    NUMBER(8) NOT NULL,
    razonsocial  VARCHAR2(60) NOT NULL,
    zona_id_zona NUMBER NOT NULL
)
LOGGING;

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( cocliente );

CREATE TABLE docventa (
    cliente_cocliente   NUMBER(8) NOT NULL,
    nrodocumento        NUMBER(10) NOT NULL,
    fecha               DATE NOT NULL,
    monto               NUMBER NOT NULL,
    vendedor_idvendedor NUMBER(8) NOT NULL
)
LOGGING;

ALTER TABLE docventa ADD CONSTRAINT docventa_pk PRIMARY KEY ( nrodocumento );

CREATE TABLE docventaxproducto (
    docventa_nrodocumento NUMBER(10) NOT NULL,
    producto_coproducto   NUMBER(8) NOT NULL,
    cantidad              NUMBER(8, 2) NOT NULL,
    subtotal              NUMBER(8, 2) NOT NULL,
    precio                NUMBER NOT NULL
)
LOGGING;

ALTER TABLE docventaxproducto ADD CONSTRAINT docventaxproducto_pk PRIMARY KEY ( docventa_nrodocumento,
                                                                                producto_coproducto );

CREATE TABLE producto (
    coproducto NUMBER(8) NOT NULL,
    nombre     VARCHAR2(60) NOT NULL,
    precio     NUMBER(8, 2) NOT NULL
)
LOGGING;

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( coproducto );

CREATE TABLE vendedor (
    idvendedor      NUMBER(8) NOT NULL,
    nombres         VARCHAR2(60) NOT NULL,
    appaterno       VARCHAR2(60) NOT NULL,
    nrodocidentidad VARCHAR2(10) NOT NULL,
    zona_id_zona    NUMBER NOT NULL
)
LOGGING;

ALTER TABLE vendedor ADD CONSTRAINT vendedor_pk PRIMARY KEY ( idvendedor );

CREATE TABLE zona (
    id_zona   NUMBER NOT NULL,
    direccion VARCHAR2(100) NOT NULL
)
LOGGING;

ALTER TABLE zona ADD CONSTRAINT zona_pk PRIMARY KEY ( id_zona );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_zona_fk FOREIGN KEY ( zona_id_zona )
        REFERENCES zona ( id_zona )
    NOT DEFERRABLE;

ALTER TABLE docventa
    ADD CONSTRAINT docventa_cliente_fk FOREIGN KEY ( cliente_cocliente )
        REFERENCES cliente ( cocliente )
    NOT DEFERRABLE;

ALTER TABLE docventa
    ADD CONSTRAINT docventa_vendedor_fk FOREIGN KEY ( vendedor_idvendedor )
        REFERENCES vendedor ( idvendedor )
    NOT DEFERRABLE;

ALTER TABLE docventaxproducto
    ADD CONSTRAINT docventaxproducto_docventa_fk FOREIGN KEY ( docventa_nrodocumento )
        REFERENCES docventa ( nrodocumento )
    NOT DEFERRABLE;

ALTER TABLE docventaxproducto
    ADD CONSTRAINT docventaxproducto_producto_fk FOREIGN KEY ( producto_coproducto )
        REFERENCES producto ( coproducto )
    NOT DEFERRABLE;

ALTER TABLE vendedor
    ADD CONSTRAINT vendedor_zona_fk FOREIGN KEY ( zona_id_zona )
        REFERENCES zona ( id_zona )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             12
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
