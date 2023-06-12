﻿-- INF246 - BASES DE DATOS
-- 4ta. Práctica (Tipo B)
-- PARTE DIRIGIDA

DROP TABLE AREA CASCADE CONSTRAINTS ;
DROP TABLE ASISTENCIA CASCADE CONSTRAINTS ;
DROP TABLE CARGO CASCADE CONSTRAINTS ;
DROP TABLE PERSONA CASCADE CONSTRAINTS ;
DROP TABLE PERSONAL CASCADE CONSTRAINTS ;
DROP TABLE TIPO_DOCUMENTO CASCADE CONSTRAINTS ;

CREATE TABLE AREA
  (
    ID_AREA INTEGER NOT NULL ,
    NOMBRE  VARCHAR2 (50) NOT NULL ,
    ESTADO  SMALLINT NOT NULL
  ) ;
ALTER TABLE AREA ADD CONSTRAINT AREA_PK PRIMARY KEY ( ID_AREA ) ;


CREATE TABLE ASISTENCIA
  (
    ID_ASISTENCIA         INTEGER NOT NULL ,
    ID_PERSONA            INTEGER NOT NULL ,
    FECHA_HORA_MOVIMIENTO DATE NOT NULL ,
    TIPO_MOVIMIENTO       CHAR (1) NOT NULL
  ) ;
ALTER TABLE ASISTENCIA ADD CONSTRAINT ASISTENCIA_PK PRIMARY KEY ( ID_ASISTENCIA ) ;


CREATE TABLE CARGO
  (
    ID_CARGO      INTEGER NOT NULL ,
    NOMBRE        VARCHAR2 (50) NOT NULL ,
    SUELDO_BASICO NUMBER NOT NULL ,
    ESTADO        SMALLINT NOT NULL
  ) ;
ALTER TABLE CARGO ADD CONSTRAINT CARGO_PK PRIMARY KEY ( ID_CARGO ) ;


CREATE TABLE PERSONA
  (
    ID_PERSONA         INTEGER NOT NULL ,
    ID_TIPO_DOCUMENTO  INTEGER NOT NULL ,
    NUMERO_DOCUMENTO   VARCHAR2 (9) NOT NULL ,
    APELLIDO_PATERNO   VARCHAR2 (50) NOT NULL ,
    APELLIDO_MATERNO   VARCHAR2 (50) NOT NULL ,
    NOMBRES            VARCHAR2 (50) NOT NULL ,
    SEXO               CHAR (1) NOT NULL ,
    FECHA_NACIMIENTO   DATE ,
    DIRECCION          VARCHAR2 (100) ,
    CORREO_ELECTRONICO VARCHAR2 (100)
  ) ;
ALTER TABLE PERSONA ADD CONSTRAINT PERSONA_PK PRIMARY KEY ( ID_PERSONA ) ;


CREATE TABLE PERSONAL
  (
    ID_PERSONAL         INTEGER NOT NULL ,
    ID_PERSONA          INTEGER NOT NULL ,
    ID_AREA             INTEGER NOT NULL ,
    ID_CARGO            INTEGER NOT NULL ,
    FECHA_INICIO        DATE NOT NULL ,
    FECHA_FIN           DATE ,
    SUELDO_BASICO       NUMBER NOT NULL ,
    SUELDO_BONIFICACION NUMBER
  ) ;
ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_PK PRIMARY KEY ( ID_PERSONAL ) ;


CREATE TABLE TIPO_DOCUMENTO
  (
    ID_TIPO_DOCUMENTO INTEGER NOT NULL ,
    NOMBRE            VARCHAR2 (50) NOT NULL ,
    ESTADO            SMALLINT NOT NULL
  ) ;
ALTER TABLE TIPO_DOCUMENTO ADD CONSTRAINT TIPO_DOCUMENTO_PK PRIMARY KEY ( ID_TIPO_DOCUMENTO ) ;


ALTER TABLE ASISTENCIA ADD CONSTRAINT ASISTENCIA_PERSONA_FK FOREIGN KEY ( ID_PERSONA ) REFERENCES PERSONA ( ID_PERSONA ) ;

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_AREA_FK FOREIGN KEY ( ID_AREA ) REFERENCES AREA ( ID_AREA ) ;

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_CARGO_FK FOREIGN KEY ( ID_CARGO ) REFERENCES CARGO ( ID_CARGO ) ;

ALTER TABLE PERSONAL ADD CONSTRAINT PERSONAL_PERSONA_FK FOREIGN KEY ( ID_PERSONA ) REFERENCES PERSONA ( ID_PERSONA ) ;

ALTER TABLE PERSONA ADD CONSTRAINT PERSONA_TIPO_DOCUMENTO_FK FOREIGN KEY ( ID_TIPO_DOCUMENTO ) REFERENCES TIPO_DOCUMENTO ( ID_TIPO_DOCUMENTO ) ;

DELETE FROM ASISTENCIA;
DELETE FROM PERSONAL;
DELETE FROM PERSONA;
DELETE FROM CARGO;
DELETE FROM AREA;
DELETE FROM TIPO_DOCUMENTO;

INSERT INTO TIPO_DOCUMENTO(ID_TIPO_DOCUMENTO, NOMBRE, ESTADO) VALUES(1, 'DNI', 1);
INSERT INTO TIPO_DOCUMENTO(ID_TIPO_DOCUMENTO, NOMBRE, ESTADO) VALUES(2, 'Pasaporte', 1);
INSERT INTO TIPO_DOCUMENTO(ID_TIPO_DOCUMENTO, NOMBRE, ESTADO) VALUES(3, 'Carné de Extranjería', 1);

INSERT INTO AREA(ID_AREA, NOMBRE, ESTADO) VALUES(1, 'Gerencia General', 1);
INSERT INTO AREA(ID_AREA, NOMBRE, ESTADO) VALUES(2, 'Operaciones', 1);
INSERT INTO AREA(ID_AREA, NOMBRE, ESTADO) VALUES(3, 'Administración', 1);
INSERT INTO AREA(ID_AREA, NOMBRE, ESTADO) VALUES(4, 'Imagen Institucional', 1);
INSERT INTO AREA(ID_AREA, NOMBRE, ESTADO) VALUES(5, 'Soporte', 1);

INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(1, 'Gerente General', 25000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(2, 'Gerente de Operaciones', 15000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(3, 'Administrador', 16000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(4, 'Jefe de Imagen', 12000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(5, 'Analista Comercial', 9000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(6, 'Jefe de Soporte', 10000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(7, 'Jefe de Proyectos', 7000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(8, 'Analista Programador', 5500, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(9, 'Programador', 4000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(10, 'Programador Junior', 2000, 1);
INSERT INTO CARGO(ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES(11, 'Analista de Marketing', 2500, 1);

INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(1, 1, '88930782', 'RODRIGUEZ', 'ORTEGA', 'DANIEL MANUEL', 'M', TO_DATE('26/12/1958', 'DD/MM/YYYY'), 'DIRECCION 1', 'drodriguez@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(2, 1, '03879129', 'CHAVEZ', 'TAVERA', 'BRUNO MARTIN', 'M', TO_DATE('16/09/1967', 'DD/MM/YYYY'), 'DIRECCION 2', 'brunochaveztavera@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(3, 1, '57206829', 'SANCHEZ', 'CARLOS', 'JULIO ROBERTO', 'M', TO_DATE('09/05/1966', 'DD/MM/YYYY'), 'DIRECCION 3', 'julrobsanch@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(4, 3, '001040878', 'CARDOSO', 'MARTINEZ', 'FRANCISCO MIGUEL', 'M', TO_DATE('31/05/1980', 'DD/MM/YYYY'), 'DIRECCION 4', 'fmiguel@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(5, 3, '000970242', 'RODRIGUEZ', 'RUIZ', 'EDDIE FRANCISCO', 'M', TO_DATE('28/03/1975', 'DD/MM/YYYY'), 'DIRECCION 5', 'eddie@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(6, 1, '78909294', 'PISCONTE', 'DE LA CRUZ', 'SANDRA VIVIANA', 'F', TO_DATE('01/11/1988', 'DD/MM/YYYY'), 'DIRECCION 6', 'sandrapisconte88@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(7, 1, '28769290', 'APARICIO', 'MANCO', 'CARLA PATRICIA', 'F', TO_DATE('26/10/1981', 'DD/MM/YYYY'), 'DIRECCION 7', 'carlapatricia1981@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(8, 1, '47891069', 'DEZA', 'RIVERA', 'ERICK TIMOTEO', 'M', TO_DATE('12/04/1979', 'DD/MM/YYYY'), 'DIRECCION 8', 'edeza@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(9, 2, '5216413', 'ROMERO', 'RAMIREZ', 'DIEGO ANTONIO', 'M', TO_DATE('14/01/1989', 'DD/MM/YYYY'), 'DIRECCION 9', 'diegoantonioromero@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(10, 2, '4342192', 'TELLO', 'MELENDEZ', 'JOSE ALBERTO', 'M', TO_DATE('06/12/1992', 'DD/MM/YYYY'), 'DIRECCION 10', 'josetello.melendez@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(11, 1, '68950025', 'VERA', 'CORDOVA', 'JORGE FELIX', 'M', TO_DATE('26/10/1980', 'DD/MM/YYYY'), 'DIRECCION 11', 'joveco@rent.com.pe');
INSERT INTO PERSONA(ID_PERSONA, ID_TIPO_DOCUMENTO, NUMERO_DOCUMENTO, APELLIDO_PATERNO, APELLIDO_MATERNO, NOMBRES, SEXO, FECHA_NACIMIENTO, DIRECCION, CORREO_ELECTRONICO)
VALUES(12, 1, '70578552', 'RODRIGUEZ', 'VERA', 'FRANCISCA', 'F', TO_DATE('01/08/1996', 'DD/MM/YYYY'), 'DIRECCION 12', 'francisca.rvera@rent.com.pe');

INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(1, 1, 1, 1, TO_DATE('02/02/2016', 'DD/MM/YYYY'), TO_DATE('02/02/2021', 'DD/MM/YYYY'), 25500);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(2, 2, 2, 2, TO_DATE('02/02/2016', 'DD/MM/YYYY'), NULL, 14700);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(3, 3, 3, 3, TO_DATE('02/02/2016', 'DD/MM/YYYY'), TO_DATE('02/02/2022', 'DD/MM/YYYY'), 16000);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(4, 4, 5, 6, TO_DATE('02/02/2016', 'DD/MM/YYYY'), NULL, 10250);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(5, 5, 2, 8, TO_DATE('02/02/2016', 'DD/MM/YYYY'), TO_DATE('31/03/2016', 'DD/MM/YYYY'), 5500);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(6, 5, 2, 7, TO_DATE('01/04/2016', 'DD/MM/YYYY'), NULL, 8000);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(7, 6, 2, 10, TO_DATE('15/02/2016', 'DD/MM/YYYY'), TO_DATE('31/03/2016', 'DD/MM/YYYY'), 3900);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(8, 6, 2, 9, TO_DATE('01/04/2016', 'DD/MM/YYYY'), TO_DATE('30/04/2016', 'DD/MM/YYYY'), 3500);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(9, 6, 2, 8, TO_DATE('01/05/2016', 'DD/MM/YYYY'), TO_DATE('30/04/2022', 'DD/MM/YYYY'), 6000);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(10, 11, 4, 11, TO_DATE('01/01/2020', 'DD/MM/YYYY'), TO_DATE('30/06/2022', 'DD/MM/YYYY'), 3500);
INSERT INTO PERSONAL(ID_PERSONAL, ID_PERSONA, ID_AREA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO)
VALUES(11, 12, 4, 4, TO_DATE('01/01/2020', 'DD/MM/YYYY'), NULL, 13000);

INSERT INTO ASISTENCIA(ID_ASISTENCIA, ID_PERSONA, FECHA_HORA_MOVIMIENTO, TIPO_MOVIMIENTO)
VALUES(1, 1, TO_DATE('05/05/2016 08:40:14', 'DD/MM/YYYY HH:MI:SS'), 'I');
INSERT INTO ASISTENCIA(ID_ASISTENCIA, ID_PERSONA, FECHA_HORA_MOVIMIENTO, TIPO_MOVIMIENTO)
VALUES(2, 2, TO_DATE('05/05/2016 09:01:14', 'DD/MM/YYYY HH:MI:SS'), 'I');
INSERT INTO ASISTENCIA(ID_ASISTENCIA, ID_PERSONA, FECHA_HORA_MOVIMIENTO, TIPO_MOVIMIENTO)
VALUES(3, 3, TO_DATE('05/05/2016 09:02:57', 'DD/MM/YYYY HH:MI:SS'), 'I');
INSERT INTO ASISTENCIA(ID_ASISTENCIA, ID_PERSONA, FECHA_HORA_MOVIMIENTO, TIPO_MOVIMIENTO)
VALUES(4, 4, TO_DATE('05/05/2016 09:02:59', 'DD/MM/YYYY HH:MI:SS'), 'I');
