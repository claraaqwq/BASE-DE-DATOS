-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-05-14 17:18:25 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g




CREATE TABLE a20210944.x99_almacen (
    id_almacen  NUMBER NOT NULL,
    descripcion VARCHAR2(60 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_almacen
    ADD CONSTRAINT x99_almacen_pk PRIMARY KEY ( id_almacen )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_articulo (
    id_articulo   NUMBER NOT NULL,
    descripcion   VARCHAR2(60 BYTE),
    codigo        VARCHAR2(10 BYTE) NOT NULL,
    costo         NUMBER(10, 2) NOT NULL,
    id_unidad_med NUMBER NOT NULL,
    id_subgrupo   NUMBER,
    id_grupo      NUMBER,
    id_proveedor  NUMBER
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_articulo
    ADD CONSTRAINT x99_articulo_pk PRIMARY KEY ( id_articulo )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_articuloxalmacen (
    id_articulo NUMBER NOT NULL,
    id_almacen  NUMBER NOT NULL,
    stock       NUMBER
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_articuloxalmacen
    ADD CONSTRAINT x99_articuloxalmacen_pk PRIMARY KEY ( id_articulo,
                                                         id_almacen )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_detalle_guia (
    id_guia     NUMBER NOT NULL,
    id_articulo NUMBER NOT NULL,
    id_almacen  NUMBER NOT NULL,
    cantidad    NUMBER NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_detalle_guia
    ADD CONSTRAINT x99_detalle_guia_pk PRIMARY KEY ( id_guia,
                                                     id_articulo )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_detalle_transaccion (
    id_transaccion NUMBER NOT NULL,
    id_guia        NUMBER NOT NULL,
    id_articulo    NUMBER NOT NULL,
    id_almacen     NUMBER NOT NULL,
    cantidad       NUMBER NOT NULL,
    item           NUMBER NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_detalle_transaccion
    ADD CONSTRAINT x99_detalle_transaccion_pk PRIMARY KEY ( id_transaccion,
                                                            item )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_grupo (
    id_grupo    NUMBER NOT NULL,
    descripcion VARCHAR2(60 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_grupo
    ADD CONSTRAINT x99_grupo_pk PRIMARY KEY ( id_grupo )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_guia_remision (
    id_guia         NUMBER NOT NULL,
    tipo            CHAR(1 BYTE) NOT NULL,
    fecha_documento DATE NOT NULL,
    fecha_registro  DATE NOT NULL,
    observacion     VARCHAR2(255 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_guia_remision
    ADD CONSTRAINT x99_guia_remision_pk PRIMARY KEY ( id_guia )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_proveedor (
    id_proveedor NUMBER NOT NULL,
    razon_social VARCHAR2(80 BYTE) NOT NULL,
    ruc          VARCHAR2(11 BYTE) NOT NULL,
    direccion    VARCHAR2(200 BYTE),
    telefono     VARCHAR2(20 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_proveedor
    ADD CONSTRAINT x99_proveedor_pk PRIMARY KEY ( id_proveedor )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_subgrupo (
    id_subgrupo NUMBER NOT NULL,
    id_grupo    NUMBER NOT NULL,
    descripcion VARCHAR2(60 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_subgrupo
    ADD CONSTRAINT x99_subgrupo_pk PRIMARY KEY ( id_subgrupo,
                                                 id_grupo )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_transaccion (
    id_transaccion NUMBER NOT NULL,
    id_guia        NUMBER NOT NULL,
    fecha_trans    DATE NOT NULL,
    tipo           CHAR(1 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_transaccion
    ADD CONSTRAINT x99_transaccion_pk PRIMARY KEY ( id_transaccion )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
CREATE TABLE a20210944.x99_unidad_medida (
    id_unidad_med     NUMBER NOT NULL,
    descripcion       VARCHAR2(60 BYTE),
    descripcion_corta VARCHAR2(8 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

ALTER TABLE a20210944.x99_unidad_medida
    ADD CONSTRAINT x99_unidad_medida_pk PRIMARY KEY ( id_unidad_med )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );
ALTER TABLE a20210944.x99_articulo
    ADD FOREIGN KEY ( id_proveedor )
        REFERENCES a20210944.x99_proveedor ( id_proveedor )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_articulo
    ADD FOREIGN KEY ( id_subgrupo,
                      id_grupo )
        REFERENCES a20210944.x99_subgrupo ( id_subgrupo,
                                            id_grupo )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_articulo
    ADD FOREIGN KEY ( id_unidad_med )
        REFERENCES a20210944.x99_unidad_medida ( id_unidad_med )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_articuloxalmacen
    ADD FOREIGN KEY ( id_almacen )
        REFERENCES a20210944.x99_almacen ( id_almacen )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_articuloxalmacen
    ADD FOREIGN KEY ( id_articulo )
        REFERENCES a20210944.x99_articulo ( id_articulo )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_detalle_guia
    ADD FOREIGN KEY ( id_articulo,
                      id_almacen )
        REFERENCES a20210944.x99_articuloxalmacen ( id_articulo,
                                                    id_almacen )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_detalle_guia
    ADD FOREIGN KEY ( id_guia )
        REFERENCES a20210944.x99_guia_remision ( id_guia )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_detalle_transaccion
    ADD FOREIGN KEY ( id_guia,
                      id_articulo )
        REFERENCES a20210944.x99_detalle_guia ( id_guia,
                                                id_articulo )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_detalle_transaccion
    ADD FOREIGN KEY ( id_transaccion )
        REFERENCES a20210944.x99_transaccion ( id_transaccion )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_subgrupo
    ADD FOREIGN KEY ( id_grupo )
        REFERENCES a20210944.x99_grupo ( id_grupo )
    NOT DEFERRABLE;
ALTER TABLE a20210944.x99_transaccion
    ADD FOREIGN KEY ( id_guia )
        REFERENCES a20210944.x99_guia_remision ( id_guia )
    NOT DEFERRABLE;

-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- CREATE VIEW                              0
-- ALTER TABLE                             22
-- ALTER INDEX                              0
-- ALTER VIEW                               0
-- DROP TABLE                               0
-- DROP INDEX                               0
-- DROP VIEW                                0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- DROP PACKAGE                             0
-- DROP PACKAGE BODY                        0
-- DROP PROCEDURE                           0
-- DROP FUNCTION                            0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- DROP TRIGGER                             0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- DROP TYPE                                0
-- CREATE SEQUENCE                          0
-- ALTER SEQUENCE                           0
-- DROP SEQUENCE                            0
-- CREATE MATERIALIZED VIEW                 0
-- DROP MATERIALIZED VIEW                   0
-- CREATE SYNONYM                           0
-- DROP SYNONYM                             0
-- CREATE DIMENSION                         0
-- DROP DIMENSION                           0
-- CREATE CONTEXT                           0
-- DROP CONTEXT                             0
-- CREATE DIRECTORY                         0
-- DROP DIRECTORY                           0

-- 
-- ERRORS                                   0
-- WARNINGS                                 0
