-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-07-01 16:52:12 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE anaqueles (
    id_anaquel        NUMBER NOT NULL,
    ubicacion_seccion VARCHAR2(100 BYTE) NOT NULL,
    id_seccion        NUMBER NOT NULL,
    id_local          NUMBER NOT NULL
);

ALTER TABLE anaqueles ADD CONSTRAINT anaqueles_pk PRIMARY KEY ( id_anaquel,
                                                                id_seccion );

CREATE TABLE categoria (
    id_categoria NUMBER NOT NULL,
    nombre       VARCHAR2(100 BYTE) NOT NULL
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE compartimientos (
    id_anaquel        NUMBER NOT NULL,
    id_compartimiento NUMBER NOT NULL,
    descripcion       VARCHAR2(100 BYTE) NOT NULL,
    cantidad_producto NUMBER NOT NULL,
    id_producto       NUMBER NOT NULL,
    id_anaquel_1      NUMBER NOT NULL,
    id_seccion        NUMBER NOT NULL
);

ALTER TABLE compartimientos ADD CONSTRAINT compartimientos_pk PRIMARY KEY ( id_anaquel,
                                                                            id_compartimiento );

CREATE TABLE locales (
    id_local    NUMBER NOT NULL,
    nombre      VARCHAR2(100 BYTE) NOT NULL,
    direccion   VARCHAR2(100 BYTE) NOT NULL,
    stock_total NUMBER NOT NULL
);

ALTER TABLE locales ADD CONSTRAINT locales_pk PRIMARY KEY ( id_local );

CREATE TABLE producto (
    id_producto   NUMBER NOT NULL,
    descripcion   VARCHAR2(100 BYTE) NOT NULL,
    tamaño        NUMBER NOT NULL,
    unidad_medida VARCHAR2(100 BYTE) NOT NULL,
    peso          NUMBER NOT NULL
);

ALTER TABLE producto ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE secciones_almacenamiento (
    categoria_id_categoria NUMBER NOT NULL,
    id_seccion             NUMBER NOT NULL,
    nombre                 VARCHAR2(100 BYTE) NOT NULL,
    id_local               NUMBER NOT NULL
);

ALTER TABLE secciones_almacenamiento ADD CONSTRAINT secciones_almacenamiento_pk PRIMARY KEY ( id_seccion,
                                                                                              id_local );

ALTER TABLE compartimientos
    ADD CONSTRAINT id_anaquel FOREIGN KEY ( id_anaquel_1,
                                            id_seccion )
        REFERENCES anaqueles ( id_anaquel,
                               id_seccion );

ALTER TABLE secciones_almacenamiento
    ADD CONSTRAINT id_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE secciones_almacenamiento
    ADD CONSTRAINT id_local_fk FOREIGN KEY ( id_local )
        REFERENCES locales ( id_local );

ALTER TABLE compartimientos
    ADD CONSTRAINT id_producto FOREIGN KEY ( id_producto )
        REFERENCES producto ( id_producto );

ALTER TABLE anaqueles
    ADD CONSTRAINT id_seccion_fk FOREIGN KEY ( id_seccion,
                                               id_local )
        REFERENCES secciones_almacenamiento ( id_seccion,
                                              id_local );



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
