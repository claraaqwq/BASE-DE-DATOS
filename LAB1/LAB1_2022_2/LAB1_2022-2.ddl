-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-04-23 23:52:42 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLESPACE inf246_v205 
--  WARNING: Tablespace has no data files defined 
 LOGGING ONLINE
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE
FLASHBACK ON;

CREATE USER a20210944 IDENTIFIED BY ACCOUNT UNLOCK ;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE a20210944.sp_detalle_compra (
    id_compra NUMBER NOT NULL,
    id_orden  NUMBER NOT NULL,
    id_insumo NUMBER NOT NULL,
    cantidad  NUMBER(6, 2) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX a20210944.sp_compra_insumo_pk ON
    a20210944.sp_detalle_compra (
        id_compra
    ASC )
        TABLESPACE inf246_v205 PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE a20210944.sp_detalle_compra
    ADD CONSTRAINT sp_compra_insumo_pk PRIMARY KEY ( id_compra )
        USING INDEX a20210944.sp_compra_insumo_pk;

CREATE TABLE a20210944.sp_detalle_producto (
    id_compra   NUMBER NOT NULL,
    id_orden    NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    unidades    NUMBER NOT NULL,
    merma       NUMBER DEFAULT ( 0 ) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX a20210944.sp_compra_producto_pk ON
    a20210944.sp_detalle_producto (
        id_compra
    ASC )
        TABLESPACE inf246_v205 PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE a20210944.sp_detalle_producto
    ADD CONSTRAINT sp_compra_producto_pk PRIMARY KEY ( id_compra )
        USING INDEX a20210944.sp_compra_producto_pk;

CREATE TABLE a20210944.sp_dimension (
    id_dimension CHAR(1 BYTE) NOT NULL,
    denominacion VARCHAR2(40 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE a20210944.sp_dimension
    ADD CONSTRAINT sp_dimension_pk PRIMARY KEY ( id_dimension )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE a20210944.sp_insumo (
    id_insumo     NUMBER NOT NULL,
    nombre        VARCHAR2(50 BYTE) NOT NULL,
    tipo_material VARCHAR2(30 BYTE) NOT NULL,
    id_unidad     VARCHAR2(5 BYTE) NOT NULL,
    precio        NUMBER(7, 2) NOT NULL,
    stock         NUMBER NOT NULL,
    estado        CHAR(1 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX a20210944.sp_insumo_pk ON
    a20210944.sp_insumo (
        id_insumo
    ASC )
        TABLESPACE inf246_v205 PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE a20210944.sp_insumo
    ADD CONSTRAINT sp_insumo_pk PRIMARY KEY ( id_insumo )
        USING INDEX a20210944.sp_insumo_pk;

CREATE TABLE a20210944.sp_matriz_insumo (
    id_matriz    NUMBER NOT NULL,
    id_producto  NUMBER NOT NULL,
    id_insumo    NUMBER NOT NULL,
    cantidad     NUMBER(6, 2) NOT NULL,
    ultima_modif TIMESTAMP NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX a20210944.sp_matriz_insumo_pk ON
    a20210944.sp_matriz_insumo (
        id_matriz
    ASC )
        TABLESPACE inf246_v205 PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE a20210944.sp_matriz_insumo
    ADD CONSTRAINT sp_matriz_insumo_pk PRIMARY KEY ( id_matriz )
        USING INDEX a20210944.sp_matriz_insumo_pk;

CREATE TABLE a20210944.sp_orden_compra (
    id_orden           NUMBER NOT NULL,
    monto_total        NUMBER(6, 2) NOT NULL,
    monto_igv          VARCHAR2(20 BYTE) NOT NULL,
    fecha_registro     TIMESTAMP NOT NULL,
    fecha_autorizacion TIMESTAMP,
    fecha_entrega      TIMESTAMP,
    estado             CHAR(1 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX a20210944.sp_orden_compra_pk ON
    a20210944.sp_orden_compra (
        id_orden
    ASC )
        TABLESPACE inf246_v205 PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE a20210944.sp_orden_compra
    ADD CONSTRAINT sp_orden_compra_pk PRIMARY KEY ( id_orden )
        USING INDEX a20210944.sp_orden_compra_pk;

CREATE TABLE a20210944.sp_orden_produccion (
    id_orden           NUMBER NOT NULL,
    motivo             CHAR(1 BYTE) NOT NULL,
    fecha_registro     TIMESTAMP NOT NULL,
    fecha_autorizacion TIMESTAMP,
    fecha_fin          TIMESTAMP,
    estado             CHAR(1 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX a20210944.sp_orden_produccion_pk ON
    a20210944.sp_orden_produccion (
        id_orden
    ASC )
        TABLESPACE inf246_v205 PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE a20210944.sp_orden_produccion
    ADD CONSTRAINT sp_orden_produccion_pk PRIMARY KEY ( id_orden )
        USING INDEX a20210944.sp_orden_produccion_pk;

CREATE TABLE a20210944.sp_producto (
    id_producto NUMBER NOT NULL,
    nombre      VARCHAR2(50 BYTE) NOT NULL,
    id_tipo     NUMBER NOT NULL,
    precio      NUMBER(6, 2) NOT NULL,
    estado      CHAR(1 BYTE) NOT NULL,
    stock       NUMBER(*, 0) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX a20210944.sp_producto_pk ON
    a20210944.sp_producto (
        id_producto
    ASC )
        TABLESPACE inf246_v205 PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

ALTER TABLE a20210944.sp_producto
    ADD CONSTRAINT sp_producto_pk PRIMARY KEY ( id_producto )
        USING INDEX a20210944.sp_producto_pk;

CREATE TABLE a20210944.sp_tipo_producto (
    id_tipo NUMBER NOT NULL,
    nombre  VARCHAR2(100 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE a20210944.sp_tipo_producto
    ADD CONSTRAINT sp_tipo_producto_pk PRIMARY KEY ( id_tipo )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE a20210944.sp_unidad_divisoria (
    id_unidad    VARCHAR2(5 BYTE) NOT NULL,
    nombre       VARCHAR2(50 BYTE),
    id_dimension CHAR(1 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v205 LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE a20210944.sp_unidad_divisoria
    ADD CONSTRAINT sp_unidad_divisoria_pk PRIMARY KEY ( id_unidad )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE inf246_v205
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE a20210944.sp_detalle_compra
    ADD CONSTRAINT com_ins_fk FOREIGN KEY ( id_insumo )
        REFERENCES a20210944.sp_insumo ( id_insumo )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_detalle_compra
    ADD CONSTRAINT com_ord_fk FOREIGN KEY ( id_orden )
        REFERENCES a20210944.sp_orden_compra ( id_orden )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_insumo
    ADD CONSTRAINT fk_insumo_id_unidad FOREIGN KEY ( id_unidad )
        REFERENCES a20210944.sp_unidad_divisoria ( id_unidad )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_producto
    ADD CONSTRAINT fk_producto_tipo FOREIGN KEY ( id_tipo )
        REFERENCES a20210944.sp_tipo_producto ( id_tipo )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_unidad_divisoria
    ADD CONSTRAINT fk_unidiv_dimension FOREIGN KEY ( id_dimension )
        REFERENCES a20210944.sp_dimension ( id_dimension )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_matriz_insumo
    ADD CONSTRAINT mat_ins_fk FOREIGN KEY ( id_insumo )
        REFERENCES a20210944.sp_insumo ( id_insumo )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_matriz_insumo
    ADD CONSTRAINT mat_pro_fk FOREIGN KEY ( id_producto )
        REFERENCES a20210944.sp_producto ( id_producto )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_detalle_producto
    ADD CONSTRAINT pro_ord_fk FOREIGN KEY ( id_orden )
        REFERENCES a20210944.sp_orden_produccion ( id_orden )
    NOT DEFERRABLE;

ALTER TABLE a20210944.sp_detalle_producto
    ADD CONSTRAINT pro_pro_fk FOREIGN KEY ( id_producto )
        REFERENCES a20210944.sp_producto ( id_producto )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            10
-- CREATE INDEX                             7
-- ALTER TABLE                             19
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
-- CREATE TABLESPACE                        1
-- CREATE USER                              1
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
-- WARNINGS                                 1
