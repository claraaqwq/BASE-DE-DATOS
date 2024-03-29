CREATE TABLE E1_INSPECTOR
(
  INSID CHAR(3) NOT NULL,
  INSNOMBRE VARCHAR2(60) NOT NULL,
  PRIMARY KEY (INSID)
);

CREATE TABLE E1_PERSONAL
(
  PID NUMBER(4) NOT NULL,
  PNOMBRE VARCHAR2(60) NOT NULL,
  PRIMARY KEY (PID)
);

CREATE TABLE E1_EDIFICIO
(
  EDIFICIOID CHAR(2) NOT NULL,
  PISOSNRO NUMBER(2) NOT NULL,
  ADMID CHAR(3) NOT NULL,
  PRIMARY KEY (EDIFICIOID)
);
/
CREATE TABLE E1_ADMINISTRADOR
(
  ADMID CHAR(3) NOT NULL,
  ADMSALARIO NUMBER(8,2) NOT NULL,
  ADMNOMBRE VARCHAR2(60) NOT NULL,
  ADMAPELLIDOS VARCHAR2(60) NOT NULL,
  ADMBONO NUMBER(2,1) NOT NULL,
  ADMFECHANAC DATE NOT NULL,
  RESEDIFICIOID CHAR(2) NULL,
  PRIMARY KEY (ADMID)
);

ALTER TABLE E1_EDIFICIO
    ADD CONSTRAINT EDIFICIO_ADMIN_fk FOREIGN KEY (ADMID)
    REFERENCES E1_ADMINISTRADOR(ADMID);

ALTER TABLE E1_ADMINISTRADOR
    ADD CONSTRAINT EDIFICIO_ADMIN_RES_fk FOREIGN KEY (RESEDIFICIOID)
    REFERENCES E1_EDIFICIO(EDIFICIOID);
/
CREATE TABLE E1_APARTAMENTO
(
  APARTNO CHAR(2) NOT NULL,
  DORMITORIONRO NUMBER(2) NOT NULL,
  EDIFICIOID CHAR(2) NOT NULL,
  CCID CHAR(4),
  PRIMARY KEY (APARTNO, EDIFICIOID)
);

CREATE TABLE E1_CLIENTECORP
(
  CCID CHAR(4) NOT NULL,
  CCNOMBRE VARCHAR2(60) NOT NULL,
  CCCIUDAD VARCHAR2(60) NOT NULL,
  CCINDUSTRIA VARCHAR2(60) NOT NULL,
  REFERCCID CHAR(4),
  PRIMARY KEY (CCID),
  UNIQUE (CCNOMBRE)
);

ALTER TABLE E1_APARTAMENTO
    ADD CONSTRAINT EDIFICIO_fk 
    FOREIGN KEY (EDIFICIOID) REFERENCES E1_EDIFICIO(EDIFICIOID);
    
ALTER TABLE E1_APARTAMENTO
    ADD CONSTRAINT CCID_fk 
    FOREIGN KEY (CCID) REFERENCES E1_CLIENTECORP(CCID);
   
ALTER TABLE E1_CLIENTECORP
    ADD CONSTRAINT REFERCCID_fk 
    FOREIGN KEY (REFERCCID) REFERENCES E1_CLIENTECORP(CCID);

     
CREATE TABLE E1_INSPECCIONA
(
  IDINSPECTOR CHAR(3) NOT NULL,
  IDEDIFICIO CHAR(2) NOT NULL,
  ULTIMAINSP DATE NOT NULL,
  SGTEINSP DATE NOT NULL,
  PRIMARY KEY (IDINSPECTOR, IDEDIFICIO),
  FOREIGN KEY (IDINSPECTOR) REFERENCES E1_INSPECTOR(INSID),
  FOREIGN KEY (IDEDIFICIO) REFERENCES E1_EDIFICIO(EDIFICIOID)
);

CREATE TABLE E1_LIMPIEZA
(
  APARTNO CHAR(2) NOT NULL,
  EDIFICIOID CHAR(2) NOT NULL,
  PID NUMBER(4) NOT NULL,
  PRIMARY KEY (APARTNO, EDIFICIOID, PID),
  FOREIGN KEY (APARTNO, EDIFICIOID) REFERENCES E1_APARTAMENTO(APARTNO, EDIFICIOID),
  FOREIGN KEY (PID) REFERENCES E1_PERSONAL(PID)
);

CREATE TABLE E1_ADMINTELEFONO
(
  TELEFONO VARCHAR2(12) NOT NULL,
  ADMID CHAR(3) NOT NULL,
  PRIMARY KEY (TELEFONO, ADMID),
  FOREIGN KEY (ADMID) REFERENCES E1_ADMINISTRADOR(ADMID)
);

