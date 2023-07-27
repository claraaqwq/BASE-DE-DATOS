-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-05-14 21:19:48 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE accion (
    idcuenta         NUMBER NOT NULL,
    idvideo          NUMBER NOT NULL,
    flaglike         NUMBER,
    flagdislike      NUMBER,
    flagcompartido   NUMBER,
    flagcomentario   NUMBER,
    min_reproduccion NUMBER,
    fecha_like       DATE
)
LOGGING;

ALTER TABLE accion ADD CONSTRAINT accion_pk PRIMARY KEY ( idvideo,
                                                          idcuenta );

CREATE TABLE cuenta (
    idcuenta     NUMBER NOT NULL,
    usuario      VARCHAR2(120),
    contrasena   VARCHAR2(25),
    correo       VARCHAR2(200),
    idtipocuenta NUMBER NOT NULL
)
LOGGING;

ALTER TABLE cuenta ADD CONSTRAINT cuenta_pk PRIMARY KEY ( idcuenta );

CREATE TABLE privacidad (
    idprivacidad NUMBER NOT NULL,
    descripcion  VARCHAR2(40),
    estado       CHAR(1)
)
LOGGING;

ALTER TABLE privacidad ADD CONSTRAINT categoria_pk PRIMARY KEY ( idprivacidad );

CREATE TABLE publicidad (
    idpublicidad          NUMBER NOT NULL,
    idempresa             CHAR(8),
    precioporsegundo      NUMBER,
    duracionporsegundo    NUMBER,
    idpublicidad_asociada NUMBER
)
LOGGING;

ALTER TABLE publicidad ADD CONSTRAINT publicidad_pk PRIMARY KEY ( idpublicidad );

CREATE TABLE publicidad_x_video (
    idvideo      NUMBER NOT NULL,
    idpublicidad NUMBER NOT NULL,
    activo       NUMBER
)
LOGGING;

ALTER TABLE publicidad_x_video ADD CONSTRAINT publicidad_x_video_pk PRIMARY KEY ( idvideo,
                                                                                  idpublicidad );

CREATE TABLE tipocuenta (
    idtipocuenta NUMBER NOT NULL,
    descripcion  VARCHAR2(80),
    costo        NUMBER(4, 2)
)
LOGGING;

ALTER TABLE tipocuenta ADD CONSTRAINT tipocuenta_pk PRIMARY KEY ( idtipocuenta );

CREATE TABLE video (
    idvideo              NUMBER NOT NULL,
    titulo               VARCHAR2(200),
    minutos_duracion     NUMBER,
    idcuenta_propietaria NUMBER NOT NULL,
    idprivacidad         NUMBER NOT NULL
)
LOGGING;

ALTER TABLE video ADD CONSTRAINT video_pk PRIMARY KEY ( idvideo );

ALTER TABLE accion
    ADD CONSTRAINT accion_cuenta_fk FOREIGN KEY ( idcuenta )
        REFERENCES cuenta ( idcuenta )
    NOT DEFERRABLE;

ALTER TABLE accion
    ADD CONSTRAINT accion_video_fk FOREIGN KEY ( idvideo )
        REFERENCES video ( idvideo )
    NOT DEFERRABLE;

ALTER TABLE cuenta
    ADD CONSTRAINT cuenta_tipocuenta_fk FOREIGN KEY ( idtipocuenta )
        REFERENCES tipocuenta ( idtipocuenta )
    NOT DEFERRABLE;

ALTER TABLE publicidad
    ADD CONSTRAINT id_publicidad_asociada FOREIGN KEY ( idpublicidad_asociada )
        REFERENCES publicidad ( idpublicidad )
    NOT DEFERRABLE;

ALTER TABLE publicidad_x_video
    ADD CONSTRAINT publ_x_vid_publicidad_fk FOREIGN KEY ( idpublicidad )
        REFERENCES publicidad ( idpublicidad )
    NOT DEFERRABLE;

ALTER TABLE publicidad_x_video
    ADD CONSTRAINT publi_x_vid_video_fk FOREIGN KEY ( idvideo )
        REFERENCES video ( idvideo )
    NOT DEFERRABLE;

ALTER TABLE video
    ADD CONSTRAINT video_cuenta_fk FOREIGN KEY ( idcuenta_propietaria )
        REFERENCES cuenta ( idcuenta )
    NOT DEFERRABLE;

ALTER TABLE video
    ADD CONSTRAINT video_privacidad_fk FOREIGN KEY ( idprivacidad )
        REFERENCES privacidad ( idprivacidad )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             7
-- CREATE INDEX                             0
-- ALTER TABLE                             15
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
