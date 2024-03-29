CREATE TABLE EMPLEADOS (
	DNI VARCHAR2(8),
	NOMBRE VARCHAR2(40) NOT NULL,
	APELLIDO1 VARCHAR2(15) NOT NULL,
	APELLIDO2 VARCHAR2(15),	
	DIRECC1 VARCHAR2(25),
	CIUDAD VARCHAR2(20),
	MUNICIPIO VARCHAR2(20),
	COD_POSTAL VARCHAR2(5),
	SEXO CHAR(1),
	FECHA_NAC DATE,
	DIRECC2 VARCHAR2(20),
	CONSTRAINT PK_EMPLEADOS PRIMARY KEY (DNI)
);

CREATE TABLE DEPARTAMENTOS (
	DPTO_COD NUMBER(5),
	NOMBRE_DPTO VARCHAR2(30) NOT NULL,
	JEFE VARCHAR2(8),
	PRESUPUESTO NUMBER(6) NOT NULL,
	PRES_ACTUAL NUMBER(6),
	CONSTRAINT PK_DEPARTAMENTOS PRIMARY KEY (DPTO_COD)
);
ALTER TABLE DEPARTAMENTOS ADD FOREIGN KEY (JEFE) REFERENCES EMPLEADOS (DNI);

CREATE TABLE UNIVERSIDADES (
	UNIV_COD NUMBER(5),
	NOMBRE_UNIV VARCHAR2(25) NOT NULL,
	CIUDAD VARCHAR2(20),
	MUNICIPIO VARCHAR2(20),
	COD_POSTAL VARCHAR2(5),
	CONSTRAINT PK_UNIVERSIDADES PRIMARY KEY (UNIV_COD)
);

CREATE TABLE TRABAJOS (
	TRABAJO_COD NUMBER(5),
	NOMBRE_TRAB VARCHAR2(20) NOT NULL UNIQUE,
	SALARIO_MIN NUMBER(5) NOT NULL,
	SALARIO_MAX NUMBER(5) NOT NULL,
	CONSTRAINT PK_TRABAJOS PRIMARY KEY (TRABAJO_COD)
); 

/* tabla estudios */
CREATE TABLE ESTUDIOS (
	EMPLEADO_DNI VARCHAR2(8),
	UNIVERSIDAD NUMBER(5),
	ANHO NUMBER(4),
	GRADO VARCHAR2(5),
	ESPECIALIDAD VARCHAR2(20),
	CONSTRAINT PK_ESTUDIOS PRIMARY KEY (EMPLEADO_DNI, ANHO, GRADO),
	CONSTRAINT FK_ESTUDIOS_EMPLEADOS FOREIGN KEY (EMPLEADO_DNI) REFERENCES EMPLEADOS (DNI),CONSTRAINT FK_ESTUDIOS_UNIVERSIDADES FOREIGN KEY (UNIVERSIDAD) REFERENCES UNIVERSIDADES	(UNIV_COD)
);

/* tabla historial_laboral */
CREATE TABLE HISTORIAL_LABORAL (
	EMPLEADO_DNI VARCHAR2(8),
	TRAB_COD NUMBER(5),
	FECHA_INICIO DATE,
	FECHA_FIN DATE,
	DPTO_COD NUMBER(5),
	SUPERVISOR_DNI VARCHAR2(8),
	CONSTRAINT PK_HISTORIAL_LABORAL PRIMARY KEY (EMPLEADO_DNI, FECHA_INICIO),
	CONSTRAINT FK_HLABORAL_EMPLEADOS FOREIGN KEY (EMPLEADO_DNI) REFERENCES EMPLEADOS (DNI),
	CONSTRAINT FK_HLABORAL_TRABAJOS FOREIGN KEY (TRAB_COD) REFERENCES TRABAJOS (TRABAJO_COD),
	CONSTRAINT FK_HLABORAL_DEPARTAMENTOS FOREIGN KEY (DPTO_COD) REFERENCES DEPARTAMENTOS
	(DPTO_COD),
	CONSTRAINT FK_HLABORAL_SUPERVISOR FOREIGN KEY (SUPERVISOR_DNI) REFERENCES EMPLEADOS (DNI),
	CONSTRAINT CK_HLABORAL_FECHAS CHECK (FECHA_FIN IS NULL OR FECHA_INICIO < FECHA_FIN)
);

/* tabla historial_salarial */
CREATE TABLE HISTORIAL_SALARIAL (
	EMPLEADO_DNI VARCHAR2(8),
	SALARIO NUMBER(10,2), 
	FECHA_COMIENZO DATE,
	FECHA_FIN DATE,
	CONSTRAINT PK_HISTORIAL_SALARIAL PRIMARY KEY (EMPLEADO_DNI, FECHA_COMIENZO),
	CONSTRAINT FK_HISTORIAL_SALARIAL FOREIGN KEY (EMPLEADO_DNI) REFERENCES EMPLEADOS (DNI),
	CONSTRAINT CK_FECHAS CHECK (FECHA_FIN IS NULL OR FECHA_COMIENZO < FECHA_FIN)
);
ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';