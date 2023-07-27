CREATE TABLE E222CLIENTE
(
	ID_CLIENTE           NUMBER NOT NULL ,
	NOMBRES              VARCHAR2(60) NULL ,
	APELLIDOS            VARCHAR2(60) NULL ,
	FECHANACIMIENTO      DATE NULL ,
	DIRECCION            VARCHAR2(240) NULL 
);

CREATE UNIQUE INDEX XPKE222CLIENTE ON E222CLIENTE
(ID_CLIENTE   ASC);

ALTER TABLE E222CLIENTE
	ADD CONSTRAINT  XPKE222CLIENTE PRIMARY KEY (ID_CLIENTE);

CREATE TABLE E222CONCEPTO
(
	ID_CONCEPTO          NUMBER NOT NULL ,
	DESCRIPCION          VARCHAR2(60) NULL 
);

CREATE UNIQUE INDEX XPKE222CONCEPTO ON E222CONCEPTO
(ID_CONCEPTO   ASC);

ALTER TABLE E222CONCEPTO
	ADD CONSTRAINT  XPKE222CONCEPTO PRIMARY KEY (ID_CONCEPTO);

CREATE TABLE E222TAM_CHIP
(
	ID_CHIP              NUMBER NOT NULL ,
	ID_CLIENTE           NUMBER NOT NULL 
);

CREATE UNIQUE INDEX XPKE222TAM_CHIP ON E222TAM_CHIP
(ID_CHIP   ASC);

ALTER TABLE E222TAM_CHIP
	ADD CONSTRAINT  XPKE222TAM_CHIP PRIMARY KEY (ID_CHIP);

CREATE TABLE E222CONTRATO
(
	ID_CONTRATO          NUMBER NOT NULL ,
	FECHAINICIO          DATE NULL ,
	FECHAFIN             DATE NULL ,
	ID_CHIP              NUMBER NOT NULL ,
	ID_PLAN              NUMBER NOT NULL ,
	ID_TIPOPLAN          NUMBER NOT NULL 
);

CREATE UNIQUE INDEX XPKE222CONTRATO ON E222CONTRATO
(ID_CONTRATO   ASC);

ALTER TABLE E222CONTRATO
	ADD CONSTRAINT  XPKE222CONTRATO PRIMARY KEY (ID_CONTRATO);

CREATE TABLE E222ESTADO
(
	ID_ESTADO            NUMBER NOT NULL ,
	DESCRIPCION          VARCHAR2(60) NULL 
);

CREATE UNIQUE INDEX XPKE222ESTADO ON E222ESTADO
(ID_ESTADO   ASC);

ALTER TABLE E222ESTADO
	ADD CONSTRAINT  XPKE222ESTADO PRIMARY KEY (ID_ESTADO);

CREATE TABLE E222FACTURA
(
	ID_FACTURA           NUMBER NOT NULL ,
	FECHAEMISION         DATE NULL ,
	FECHAVENCIMIENTO     DATE NULL ,
	FECHACANCELACION     DATE NULL ,
	TOTAL                NUMBER NULL ,
	ID_ESTADO            NUMBER NOT NULL 
);

CREATE UNIQUE INDEX XPKE222FACTURA ON E222FACTURA
(ID_FACTURA   ASC);

ALTER TABLE E222FACTURA
	ADD CONSTRAINT  XPKE222FACTURA PRIMARY KEY (ID_FACTURA);

CREATE TABLE E222DETALLEPROCESO
(
	ID_FACTURA           NUMBER NOT NULL ,
	ID_DETALLE           NUMBER NOT NULL ,
	IMPORTE              NUMBER NULL ,
	ID_CONCEPTO          NUMBER NOT NULL 
);

CREATE UNIQUE INDEX XPKE222DETALLEPROCESO ON E222DETALLEPROCESO
(ID_FACTURA   ASC,ID_DETALLE   ASC);

ALTER TABLE E222DETALLEPROCESO
	ADD CONSTRAINT  XPKE222DETALLEPROCESO PRIMARY KEY (ID_FACTURA,ID_DETALLE);

CREATE TABLE E222PROCESOXCONTRATO
(
	ID_CONTRATO          NUMBER NOT NULL ,
	ID_FACTURA           NUMBER NULL ,
	ANHO                 NUMBER NOT NULL ,
	MES                  NUMBER NOT NULL 
);

CREATE UNIQUE INDEX XPKE222PROCESOXCONTRATO ON E222PROCESOXCONTRATO
(ID_CONTRATO   ASC,ANHO   ASC,MES   ASC);

ALTER TABLE E222PROCESOXCONTRATO
	ADD CONSTRAINT  XPKE222PROCESOXCONTRATO PRIMARY KEY (ID_CONTRATO,ANHO,MES);

CREATE TABLE E222PLAN
(
	ID_PLAN              NUMBER NOT NULL ,
	ID_TIPOPLAN          NUMBER NOT NULL ,
	DESCRIPCION          VARCHAR2(120) NULL 
);

CREATE UNIQUE INDEX XPKE222PLAN ON E222PLAN
(ID_PLAN   ASC,ID_TIPOPLAN   ASC);

ALTER TABLE E222PLAN
	ADD CONSTRAINT  XPKE222PLAN PRIMARY KEY (ID_PLAN,ID_TIPOPLAN);


ALTER TABLE E222TAM_CHIP
	ADD (CONSTRAINT R_1E222 FOREIGN KEY (ID_CLIENTE) REFERENCES E222CLIENTE (ID_CLIENTE));

ALTER TABLE E222CONTRATO
	ADD (CONSTRAINT R_5E222 FOREIGN KEY (ID_CHIP) REFERENCES E222TAM_CHIP (ID_CHIP) ON DELETE SET NULL);

ALTER TABLE E222CONTRATO
	ADD (CONSTRAINT R_8E222 FOREIGN KEY (ID_PLAN, ID_TIPOPLAN) REFERENCES E222PLAN (ID_PLAN, ID_TIPOPLAN));

ALTER TABLE E222FACTURA
	ADD (CONSTRAINT R_7E222 FOREIGN KEY (ID_ESTADO) REFERENCES E222ESTADO (ID_ESTADO));

ALTER TABLE E222DETALLEPROCESO
	ADD (CONSTRAINT R_4E222 FOREIGN KEY (ID_FACTURA) REFERENCES E222FACTURA (ID_FACTURA));

ALTER TABLE E222DETALLEPROCESO
	ADD (CONSTRAINT R_6E222 FOREIGN KEY (ID_CONCEPTO) REFERENCES E222CONCEPTO (ID_CONCEPTO));

ALTER TABLE E222PROCESOXCONTRATO
	ADD (CONSTRAINT R_2E222 FOREIGN KEY (ID_CONTRATO) REFERENCES E222CONTRATO (ID_CONTRATO));

ALTER TABLE E222PROCESOXCONTRATO
	ADD (CONSTRAINT R_3E222 FOREIGN KEY (ID_FACTURA) REFERENCES E222FACTURA (ID_FACTURA) ON DELETE SET NULL);


