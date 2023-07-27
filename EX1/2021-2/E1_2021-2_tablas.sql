/*drop table accion cascade constraint;
drop table publicidad_x_video cascade constraint; 
drop table publicidad cascade constraint; 
drop table video cascade constraint;
drop table privacidad cascade constraint;
drop table cuenta cascade constraint;
drop table tipocuenta cascade constraint;*/

CREATE TABLE cuenta (
    idcuenta                 NUMBER NOT NULL,
    usuario                 VARCHAR2(120),
    contrasena                 VARCHAR2(25),
    correo                   VARCHAR2(200),
    idtipocuenta  NUMBER NOT NULL
);

ALTER TABLE cuenta ADD CONSTRAINT cuenta_pk PRIMARY KEY ( idcuenta );

CREATE TABLE privacidad (
    idprivacidad  NUMBER NOT NULL,
    descripcion   VARCHAR2(40),
    estado        CHAR(1)
);

ALTER TABLE privacidad ADD CONSTRAINT categoria_pk PRIMARY KEY ( idprivacidad );

CREATE TABLE publicidad (
    idpublicidad          NUMBER NOT NULL,
    idempresa             CHAR(8),
    precioporsegundo      NUMBER,
    duracionporsegundo    NUMBER,
    idpublicidad_asociada NUMBER
);

ALTER TABLE publicidad ADD CONSTRAINT publicidad_pk PRIMARY KEY ( idpublicidad );

CREATE TABLE publicidad_x_video (
    idvideo       NUMBER NOT NULL,
    idpublicidad  NUMBER NOT NULL,
    activo        NUMBER
);

ALTER TABLE publicidad_x_video ADD CONSTRAINT publicidad_x_video_pk PRIMARY KEY ( idvideo,
                                                                                  idpublicidad );

CREATE TABLE tipocuenta (
    idtipocuenta  NUMBER NOT NULL,
    descripcion   VARCHAR2(80),
    costo         NUMBER(4, 2)
);

ALTER TABLE tipocuenta ADD CONSTRAINT tipocuenta_pk PRIMARY KEY ( idtipocuenta );

CREATE TABLE video (
    idvideo               NUMBER NOT NULL,
    titulo                VARCHAR2(200),
    minutos_duracion      NUMBER,
    idcuenta_propietaria  NUMBER NOT NULL,
    idprivacidad          NUMBER NOT NULL
);

ALTER TABLE video ADD CONSTRAINT video_pk PRIMARY KEY ( idvideo );

CREATE TABLE accion (
    idcuenta         NUMBER NOT NULL,
    idvideo          NUMBER NOT NULL,
    flaglike         NUMBER,
    flagdislike      NUMBER,
    flagcompartido   NUMBER,
    flagcomentario   NUMBER,
    min_reproduccion  NUMBER,
    fecha_like       DATE
);

ALTER TABLE accion ADD CONSTRAINT accion_pk PRIMARY KEY ( idvideo,
                                                                          idcuenta );

ALTER TABLE cuenta
    ADD CONSTRAINT cuenta_tipocuenta_fk FOREIGN KEY ( idtipocuenta )
        REFERENCES tipocuenta ( idtipocuenta );

ALTER TABLE publicidad_x_video
    ADD CONSTRAINT publ_x_vid_publicidad_fk FOREIGN KEY ( idpublicidad )
        REFERENCES publicidad ( idpublicidad );

ALTER TABLE publicidad_x_video
    ADD CONSTRAINT publi_x_vid_video_fk FOREIGN KEY ( idvideo )
        REFERENCES video ( idvideo );

ALTER TABLE video
    ADD CONSTRAINT video_cuenta_fk FOREIGN KEY ( idcuenta_propietaria )
        REFERENCES cuenta ( idcuenta );

ALTER TABLE video
    ADD CONSTRAINT video_privacidad_fk FOREIGN KEY ( idprivacidad )
        REFERENCES privacidad ( idprivacidad );

ALTER TABLE accion
    ADD CONSTRAINT accion_cuenta_fk FOREIGN KEY ( idcuenta )
        REFERENCES cuenta ( idcuenta );

ALTER TABLE accion
    ADD CONSTRAINT accion_video_fk FOREIGN KEY ( idvideo )
        REFERENCES video ( idvideo );


