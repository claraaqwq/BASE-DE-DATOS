-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-01-31 17:09:10 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLESPACE inf246_v207 
--  WARNING: Tablespace has no data files defined 
 LOGGING ONLINE
    EXTENT MANAGEMENT LOCAL AUTOALLOCATE
FLASHBACK ON;

CREATE USER a20206455 IDENTIFIED BY ACCOUNT UNLOCK ;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE categoria (
    idcategoria NUMBER(10) NOT NULL,
    nombre      VARCHAR2(60 BYTE) NOT NULL
)
LOGGING;

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( idcategoria );

CREATE TABLE categoriaxtorneo (
    idtorneo    NUMBER(10) NOT NULL,
    idcategoria NUMBER(10) NOT NULL,
    premio      NUMBER(8, 2) NOT NULL
)
LOGGING;

ALTER TABLE categoriaxtorneo ADD CONSTRAINT categoriaxtorneo_pk PRIMARY KEY ( idcategoria,
                                                                              idtorneo );

CREATE TABLE a20206455.x230_jugador (
    idjugador NUMBER(10) NOT NULL,
    nombres   VARCHAR2(60 BYTE) NOT NULL,
    apellidos VARCHAR2(60 BYTE) NOT NULL,
    sexo      CHAR(1 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v207 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

CREATE UNIQUE INDEX a20206455.jugador_pk ON
    a20206455.x230_jugador (
        idjugador
    ASC )
        TABLESPACE inf246_v207 PCTFREE 10
            STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE a20206455.x230_jugador
    ADD CONSTRAINT jugador_pk PRIMARY KEY ( idjugador )
        USING INDEX a20206455.jugador_pk;

CREATE TABLE a20206455.x230_partido (
    idpartido NUMBER(10) NOT NULL,
    idtorneo  NUMBER(10) NOT NULL,
    fecha     DATE,
    ronda     NUMBER(1) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v207 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

CREATE UNIQUE INDEX a20206455.partido_pk ON
    a20206455.x230_partido (
        idpartido
    ASC )
        TABLESPACE inf246_v207 PCTFREE 10
            STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE a20206455.x230_partido
    ADD CONSTRAINT partido_pk PRIMARY KEY ( idpartido )
        USING INDEX a20206455.partido_pk;

CREATE TABLE a20206455.x230_partido_jugador (
    idpartido NUMBER(10) NOT NULL,
    idjugador NUMBER(10) NOT NULL,
    resultado CHAR(1 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v207 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

CREATE UNIQUE INDEX a20206455.partido_jug_pk ON
    a20206455.x230_partido_jugador (
        idpartido
    ASC,
        idjugador
    ASC )
        TABLESPACE inf246_v207 PCTFREE 10
            STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE a20206455.x230_partido_jugador
    ADD CONSTRAINT partido_jugador_pk PRIMARY KEY ( idpartido,
                                                    idjugador )
        USING INDEX a20206455.partido_jug_pk;

CREATE TABLE a20206455.x230_torneo (
    idtorneo NUMBER(10) NOT NULL,
    nombre   VARCHAR2(60 BYTE) NOT NULL,
    pais     VARCHAR2(60 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE inf246_v207 LOGGING
    STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT );

CREATE UNIQUE INDEX a20206455.torneo_pk ON
    a20206455.x230_torneo (
        idtorneo
    ASC )
        TABLESPACE inf246_v207 PCTFREE 10
            STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT )
        LOGGING;

ALTER TABLE a20206455.x230_torneo
    ADD CONSTRAINT torneo_pk PRIMARY KEY ( idtorneo )
        USING INDEX a20206455.torneo_pk;

ALTER TABLE categoriaxtorneo
    ADD CONSTRAINT categoriaxtorneo_c_fk FOREIGN KEY ( idcategoria )
        REFERENCES categoria ( idcategoria )
    NOT DEFERRABLE;

ALTER TABLE categoriaxtorneo
    ADD CONSTRAINT categoriaxtorneo_t_fk FOREIGN KEY ( idtorneo )
        REFERENCES a20206455.x230_torneo ( idtorneo )
    NOT DEFERRABLE;

ALTER TABLE a20206455.x230_partido
    ADD CONSTRAINT partido_fk FOREIGN KEY ( idtorneo )
        REFERENCES a20206455.x230_torneo ( idtorneo )
    NOT DEFERRABLE;

ALTER TABLE a20206455.x230_partido_jugador
    ADD CONSTRAINT partido_jugador_j_fk FOREIGN KEY ( idjugador )
        REFERENCES a20206455.x230_jugador ( idjugador )
    NOT DEFERRABLE;

ALTER TABLE a20206455.x230_partido_jugador
    ADD CONSTRAINT partido_jugador_p_fk FOREIGN KEY ( idpartido )
        REFERENCES a20206455.x230_partido ( idpartido )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             4
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
