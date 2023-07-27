-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-02-28 17:18:18 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE anaquel (
    id_seccion        NUMBER NOT NULL,
    id_anaquel        NUMBER NOT NULL,
    descripcion       VARCHAR2(20 BYTE) NOT NULL,
    ubicacion_seccion VARCHAR2(20 BYTE) NOT NULL,
    id_local          NUMBER NOT NULL
);

ALTER TABLE anaquel ADD CONSTRAINT anaquel_pk PRIMARY KEY ( id_anaquel,
                                                            id_seccion );

CREATE TABLE categoria (
    id_categoria NUMBER NOT NULL,
    nombre       VARCHAR2(20 BYTE) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE compartimento (
    id_anaquel        NUMBER NOT NULL,
    id_compartimento  NUMBER NOT NULL,
    descripcion       VARCHAR2(20 BYTE) NOT NULL,
    id_producto       NUMBER NOT NULL,
    cantidad_producto NUMBER NOT NULL,
    id_seccion        NUMBER NOT NULL
);

ALTER TABLE compartimento ADD CONSTRAINT compartimento_pk PRIMARY KEY ( id_compartimento,
                                                                        id_anaquel );

CREATE TABLE local (
    id_local    NUMBER NOT NULL,
    nombre      VARCHAR2(20 BYTE) NOT NULL,
    direccion   VARCHAR2(20 BYTE) NOT NULL,
    stock_total NUMBER NOT NULL
);

ALTER TABLE local ADD CONSTRAINT local_pk PRIMARY KEY ( id_local );

CREATE TABLE producto (
    id_producto    NUMBER NOT NULL,
    descripcion    VARCHAR2(20 BYTE) NOT NULL,
    tamanho_metros NUMBER NOT NULL,
    peso_kg        NUMBER NOT NULL,
    unidad         VARCHAR2(20 BYTE) NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE sec_almac (
    id_local     NUMBER NOT NULL,
    id_seccion   NUMBER NOT NULL,
    nombre       VARCHAR2(20 BYTE) NOT NULL,
    id_categoria NUMBER NOT NULL
);

ALTER TABLE sec_almac ADD CONSTRAINT sec_almac_pk PRIMARY KEY ( id_seccion,
                                                                id_local );

ALTER TABLE anaquel
    ADD CONSTRAINT anaquel_sec_almac_fk FOREIGN KEY ( id_seccion,
                                                      id_local )
        REFERENCES sec_almac ( id_seccion,
                               id_local );

ALTER TABLE compartimento
    ADD CONSTRAINT compart_anaquel_fk FOREIGN KEY ( id_anaquel,
                                                    id_seccion )
        REFERENCES anaquel ( id_anaquel,
                             id_seccion );

ALTER TABLE compartimento
    ADD CONSTRAINT compart_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE sec_almac
    ADD CONSTRAINT sec_almac_categ_fk FOREIGN KEY ( id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE sec_almac
    ADD CONSTRAINT sec_almac_local_fk FOREIGN KEY ( id_local )
        REFERENCES local ( id_local );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             11
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
