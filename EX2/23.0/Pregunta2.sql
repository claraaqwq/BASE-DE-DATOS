-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-07-01 14:10:35 COT
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE canal (
    idcanal NUMBER(2) NOT NULL,
    ncanal  VARCHAR2(60)
)
LOGGING;

ALTER TABLE canal ADD CONSTRAINT canal_pk PRIMARY KEY ( idcanal );

CREATE TABLE comunicacionxexpediente (
    idexpediente      NUMBER NOT NULL,
    idcomunicacion    NUMBER NOT NULL,
    idcanal           NUMBER(2),
    idremitente       NUMBER,
    idunidadremitente NUMBER(2),
    fcomunicacion     DATE NOT NULL,
    asunto            VARCHAR2(255) NOT NULL,
    tipodoc           CHAR(1) NOT NULL,
    archivo           BLOB NOT NULL,
    idunidaddestino   NUMBER(2),
    iddestinatario    NUMBER
)
LOGGING;

ALTER TABLE comunicacionxexpediente ADD CONSTRAINT comxexp_pk PRIMARY KEY ( idexpediente,
                                                                            idcomunicacion );

CREATE TABLE estado (
    idestado NUMBER(1) NOT NULL,
    nestado  VARCHAR2(60) NOT NULL
)
LOGGING;

ALTER TABLE estado ADD CONSTRAINT estado_pk PRIMARY KEY ( idestado );

CREATE TABLE expediente (
    idexpediente         NUMBER NOT NULL,
    idcontacto           NUMBER,
    idestado             NUMBER(1) NOT NULL,
    idunidadservicio     NUMBER(2),
    detalle              VARCHAR2(255) NOT NULL,
    flimite              DATE,
    fregistro            DATE NOT NULL,
    fculminacion         DATE,
    idunidadusuaria      NUMBER(2),
    idregistrador        NUMBER,
    idculminador         NUMBER,
    i_valido             CHAR(1) NOT NULL,
    total_comunicaciones NUMBER NOT NULL,
    total_servicios      NUMBER NOT NULL
)
LOGGING;

ALTER TABLE expediente ADD CONSTRAINT expediente_pk PRIMARY KEY ( idexpediente );

CREATE TABLE persona (
    idpersona NUMBER NOT NULL,
    npersona  VARCHAR2(60) NOT NULL,
    apersona  VARCHAR2(60) NOT NULL,
    epersona  CHAR(1) NOT NULL,
    idunidad  NUMBER(2) NOT NULL
)
LOGGING;

ALTER TABLE persona ADD CONSTRAINT persona_pk PRIMARY KEY ( idpersona );

CREATE TABLE prioridad (
    idprioridad NUMBER(1) NOT NULL,
    nprioridad  VARCHAR2(60) NOT NULL
)
LOGGING;

ALTER TABLE prioridad ADD CONSTRAINT prioridad_pk PRIMARY KEY ( idprioridad );

CREATE TABLE servicioxexpediente (
    idexpediente     NUMBER NOT NULL,
    idservicio       NUMBER NOT NULL,
    idestado         NUMBER(1) NOT NULL,
    idprioridad      NUMBER(1),
    idresponsable    NUMBER,
    idtarea          NUMBER(2),
    idsubtarea       NUMBER(2),
    idunidadservicio NUMBER(2),
    idtiposervicio   NUMBER(2),
    especificacion   VARCHAR2(500) NOT NULL,
    finicio          DATE NOT NULL,
    flimite          DATE NOT NULL,
    fregistro        DATE NOT NULL,
    fculminacion     DATE,
    observacion      VARCHAR2(255),
    mensaje          VARCHAR2(255),
    vobo             CHAR(1) NOT NULL,
    idregistrador    NUMBER,
    idculminador     NUMBER,
    idgexpediente    NUMBER,
    idgservicio      NUMBER NOT NULL
)
LOGGING;

ALTER TABLE servicioxexpediente ADD CONSTRAINT servxexp_pk PRIMARY KEY ( idexpediente,
                                                                         idservicio );

CREATE TABLE subtarea (
    idsubtarea NUMBER(2) NOT NULL,
    nsubtarea  VARCHAR2(60) NOT NULL
)
LOGGING;

ALTER TABLE subtarea ADD CONSTRAINT subtarea_pk PRIMARY KEY ( idsubtarea );

CREATE TABLE tarea (
    idtarea NUMBER(2) NOT NULL,
    ntarea  VARCHAR2(60) NOT NULL
)
LOGGING;

ALTER TABLE tarea ADD CONSTRAINT tarea_pk PRIMARY KEY ( idtarea );

CREATE TABLE tiposervicio (
    idtiposervicio NUMBER(2) NOT NULL,
    ntiposervicio  VARCHAR2(60) NOT NULL
)
LOGGING;

ALTER TABLE tiposervicio ADD CONSTRAINT tiposervicio_pk PRIMARY KEY ( idtiposervicio );

CREATE TABLE unidad (
    idunidad NUMBER(2) NOT NULL,
    nunidad  VARCHAR2(60)
)
LOGGING;

ALTER TABLE unidad ADD CONSTRAINT unidad_pk PRIMARY KEY ( idunidad );

ALTER TABLE comunicacionxexpediente
    ADD CONSTRAINT canal_fk FOREIGN KEY ( idcanal )
        REFERENCES canal ( idcanal )
    NOT DEFERRABLE;

ALTER TABLE expediente
    ADD CONSTRAINT estado_fk FOREIGN KEY ( idestado )
        REFERENCES estado ( idestado )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT estado_fkv2 FOREIGN KEY ( idestado )
        REFERENCES estado ( idestado )
    NOT DEFERRABLE;

ALTER TABLE expediente
    ADD CONSTRAINT exp_persona_contacto FOREIGN KEY ( idcontacto )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE expediente
    ADD CONSTRAINT exp_persona_culmin FOREIGN KEY ( idculminador )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE expediente
    ADD CONSTRAINT exp_persona_registr FOREIGN KEY ( idregistrador )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE comunicacionxexpediente
    ADD CONSTRAINT expediente_fk FOREIGN KEY ( idexpediente )
        REFERENCES expediente ( idexpediente )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT expediente_fkv2 FOREIGN KEY ( idexpediente )
        REFERENCES expediente ( idexpediente )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT persona_culmin_fk FOREIGN KEY ( idculminador )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE comunicacionxexpediente
    ADD CONSTRAINT persona_destinatario_fk FOREIGN KEY ( iddestinatario )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT persona_reg_fk FOREIGN KEY ( idregistrador )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE comunicacionxexpediente
    ADD CONSTRAINT persona_rem_fk FOREIGN KEY ( idremitente )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT persona_resp_fk FOREIGN KEY ( idresponsable )
        REFERENCES persona ( idpersona )
    NOT DEFERRABLE;

ALTER TABLE persona
    ADD CONSTRAINT persona_unidad_fk FOREIGN KEY ( idunidad )
        REFERENCES unidad ( idunidad )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT prioridad_fk FOREIGN KEY ( idprioridad )
        REFERENCES prioridad ( idprioridad )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT servxexp_fk FOREIGN KEY ( idgexpediente,
                                             idgservicio )
        REFERENCES servicioxexpediente ( idexpediente,
                                         idservicio )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT subtarea_fk FOREIGN KEY ( idsubtarea )
        REFERENCES subtarea ( idsubtarea )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT tarea_fk FOREIGN KEY ( idtarea )
        REFERENCES tarea ( idtarea )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT tiposervicio_fk FOREIGN KEY ( idtiposervicio )
        REFERENCES tiposervicio ( idtiposervicio )
    NOT DEFERRABLE;

ALTER TABLE expediente
    ADD CONSTRAINT unidad_servicio FOREIGN KEY ( idunidadservicio )
        REFERENCES unidad ( idunidad )
    NOT DEFERRABLE;

ALTER TABLE expediente
    ADD CONSTRAINT unidad_usuaria FOREIGN KEY ( idunidadusuaria )
        REFERENCES unidad ( idunidad )
    NOT DEFERRABLE;

ALTER TABLE comunicacionxexpediente
    ADD CONSTRAINT unidaddestino_fk FOREIGN KEY ( idunidaddestino )
        REFERENCES unidad ( idunidad )
    NOT DEFERRABLE;

ALTER TABLE comunicacionxexpediente
    ADD CONSTRAINT unidadremitente_fk FOREIGN KEY ( idunidadremitente )
        REFERENCES unidad ( idunidad )
    NOT DEFERRABLE;

ALTER TABLE servicioxexpediente
    ADD CONSTRAINT unidadservicio_fk FOREIGN KEY ( idunidadservicio )
        REFERENCES unidad ( idunidad )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             0
-- ALTER TABLE                             35
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
