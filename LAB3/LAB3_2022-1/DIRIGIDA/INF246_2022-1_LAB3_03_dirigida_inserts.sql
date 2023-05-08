/* TRABAJOS */
INSERT INTO TRABAJOS VALUES ('001', 'ADMINISTRATIVO', 1800, 2300);
INSERT INTO TRABAJOS VALUES ('002', 'CONTABLE', 1900, 2500);
INSERT INTO TRABAJOS VALUES ('003', 'INGENIERO TECNICO', 2100, 2700);
INSERT INTO TRABAJOS VALUES ('004', 'ALMACEN', 2800, 3500);

/* UNIVERSIDADES */
INSERT INTO UNIVERSIDADES VALUES('0001', 'Nacional del Callao', 'Callao', 'Bellavista', '41420');
INSERT INTO UNIVERSIDADES VALUES('0002', 'Catolica del Peru', 'Lima', 'San Miguel', '55555');
INSERT INTO UNIVERSIDADES VALUES('0003', 'Nacional San Aguistin', 'Arequipa', 'Santa Catalina', '11000');
INSERT INTO UNIVERSIDADES VALUES('0004', 'Nacional Mayor San Marcos', 'Lima', 'Cercado de Lima', '41430');

/* EMPLEADOS */
Insert into EMPLEADOS (DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECC1,CIUDAD,MUNICIPIO,COD_POSTAL,SEXO,FECHA_NAC,DIRECC2) values ('37480048','Jose','Mercal','Lopez','Almirante Grau 1290','Callao','Bellavista','11000','H',to_date('05/01/1974','DD/MM/YYYY'),'Urb. El Pacifico');
Insert into EMPLEADOS (DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECC1,CIUDAD,MUNICIPIO,COD_POSTAL,SEXO,FECHA_NAC,DIRECC2) values ('42269875','Maria','Rosal','Cruz',null,null,'Ubrique','11600','M',null,null);
Insert into EMPLEADOS (DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECC1,CIUDAD,MUNICIPIO,COD_POSTAL,SEXO,FECHA_NAC,DIRECC2) values ('10684781','Pilar','Perez','Rollen','Av. Canada 1203','Lima','La Victoria','11600','M',to_date('02/08/1973','DD/MM/YYYY'),'Urb. Balconcillo');
Insert into EMPLEADOS (DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECC1,CIUDAD,MUNICIPIO,COD_POSTAL,SEXO,FECHA_NAC,DIRECC2) values ('38744043', 'Luis Felipe', 'Casas', 'Frias', 'Los Alamos 345', 'Lima', 'Chorrillos', '12800', 'H', to_date('02/08/1973','DD/MM/YYYY'),'Urb. Matellini');
Insert into EMPLEADOS (DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECC1,CIUDAD,MUNICIPIO,COD_POSTAL,SEXO,FECHA_NAC,DIRECC2) values ('07845147', 'Beatriz Rosario', 'Segura', 'Chipoco', 'Tnte. Ugaz 340', 'Callao', 'Bellavista', '11000', 'M',to_date('25/11/1961','DD/MM/YYYY'),'Urb. El Pacifico');
Insert into EMPLEADOS (DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECC1,CIUDAD,MUNICIPIO,COD_POSTAL,SEXO,FECHA_NAC,DIRECC2) values ('06847120', 'Mercedes', 'Palomino', 'Cuya', 'Jr. Mellet 257', 'Lima', 'Chorrillos', '12800', 'H', to_date('12/03/1979','DD/MM/YYYY'),'Urb. Matellini');
Insert into EMPLEADOS (DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECC1,CIUDAD,MUNICIPIO,COD_POSTAL,SEXO,FECHA_NAC,DIRECC2) values ('16789674', 'Harry', 'Soto', 'Aguilar', 'Av. Mexico 119', 'Lima', 'La Victoria', '11600', 'H', to_date('02/08/1973','DD/MM/YYYY'),'Urb. Balconcillo'); 

/* DEPARTAMENTOS */
INSERT INTO DEPARTAMENTOS VALUES( 1, 'MARKETING', '10684781', 80000, 50000);
INSERT INTO DEPARTAMENTOS VALUES( 2, 'CONTABILIDAD', '07845147', 30000, 10520);
INSERT INTO DEPARTAMENTOS VALUES( 3, 'INGENIERIA', '38744043', 50000, 38790);
INSERT INTO DEPARTAMENTOS VALUES( 4, 'LOGISTICA', '37480048', 10000, 5790);


/* ESTUDIOS */
INSERT INTO ESTUDIOS VALUES( '37480048', '0001', '1992', 'MED', 'ADMINISTRACION');
INSERT INTO ESTUDIOS VALUES( '42269875', '0003', '1998', 'SUP', 'LIC CONTABILIDAD');
INSERT INTO ESTUDIOS VALUES( '10684781', '0003', '1997', 'SUP', 'FINANZAS');
INSERT INTO ESTUDIOS VALUES( '42269875', '0004', '2003', 'MED', 'CONTABILIDAD PUBLICA');
INSERT INTO ESTUDIOS VALUES( '38744043', '0004', '1993', 'MED', 'PROGRAMACION');
INSERT INTO ESTUDIOS VALUES( '07845147', '0001', '1996', 'SUP', 'CONTABILIDAD SOCIAL');
INSERT INTO ESTUDIOS VALUES( '06847120', '0004', '1994', 'SUP', 'LIC INFORMATICA');
INSERT INTO ESTUDIOS VALUES( '16789674', '0004', '1995', 'MED', 'LIC CONTABILIDAD');
INSERT INTO ESTUDIOS VALUES( '37480048', '0002', '1998', 'SUP', 'RECURSOS HUMANOS');
INSERT INTO ESTUDIOS VALUES( '10684781', '0001', '2002', 'SUP', 'COMERCIO LOCAL');
INSERT INTO ESTUDIOS VALUES( '38744043', '0002', '2004', 'SUP', 'ING INFORMATICA');

/* HISTORIAL SALARIAL */
INSERT INTO HISTORIAL_SALARIAL VALUES( '37480048', 1650, to_date('05/01/2003', 'dd/mm/yyyy'), '');
INSERT INTO HISTORIAL_SALARIAL VALUES( '42269875', 1100, to_date('03/11/2004', 'dd/mm/yyyy'), to_date('30/10/2005', 'dd/mm/yyyy'));
INSERT INTO HISTORIAL_SALARIAL VALUES( '42269875', 1900, to_date('01/11/2005', 'dd/mm/yyyy'), '');
INSERT INTO HISTORIAL_SALARIAL VALUES( '10684781', 1200, to_date('15/01/2001', 'dd/mm/yyyy'), to_date('28/12/2008', 'dd/mm/yyyy'));
INSERT INTO HISTORIAL_SALARIAL VALUES( '38744043', 1200, to_date('23/10/2002', 'dd/mm/yyyy'), to_date('30/05/2007', 'dd/mm/yyyy'));
INSERT INTO HISTORIAL_SALARIAL VALUES( '07845147', 1550, to_date('18/03/2003', 'dd/mm/yyyy'), '');
INSERT INTO HISTORIAL_SALARIAL VALUES( '06847120', 1700, to_date('29/06/2001', 'dd/mm/yyyy'), '');
INSERT INTO HISTORIAL_SALARIAL VALUES( '16789674', 1250, to_date('13/09/2002', 'dd/mm/yyyy'), '');
INSERT INTO HISTORIAL_SALARIAL VALUES( '10684781', 1900, to_date('05/01/2009', 'dd/mm/yyyy'), '');
INSERT INTO HISTORIAL_SALARIAL VALUES( '38744043', 1850, to_date('02/06/2007', 'dd/mm/yyyy'), '');

/* HISTORIAL LABORAL */
INSERT INTO HISTORIAL_LABORAL VALUES( '37480048', '004', to_date('05/01/2003', 'dd/mm/yyyy'), '', '001', '');
INSERT INTO HISTORIAL_LABORAL VALUES( '42269875', '001', to_date('03/11/2004', 'dd/mm/yyyy'), to_date('30/10/2005', 'dd/mm/yyyy'), '002','07845147');
INSERT INTO HISTORIAL_LABORAL VALUES( '10684781', '001', to_date('03/11/1999', 'dd/mm/yyyy'), to_date('30/12/2003', 'dd/mm/yyyy'), '004', '');
INSERT INTO HISTORIAL_LABORAL VALUES( '38744043', '004', to_date('15/01/2001', 'dd/mm/yyyy'), to_date('15/09/2002', 'dd/mm/yyyy'),'001','37480048');
INSERT INTO HISTORIAL_LABORAL VALUES( '07845147', '002', to_date('02/07/2002', 'dd/mm/yyyy'), '', '003', '');
INSERT INTO HISTORIAL_LABORAL VALUES( '06847120', '004', to_date('04/05/2004', 'dd/mm/yyyy'), '', '003', '10684781');
INSERT INTO HISTORIAL_LABORAL VALUES( '16789674', '003', to_date('03/08/2007', 'dd/mm/yyyy'), '', '004', '37480048');
INSERT INTO HISTORIAL_LABORAL VALUES( '42269875', '002', to_date('03/11/2005', 'dd/mm/yyyy'), '', '001', '10684781');
INSERT INTO HISTORIAL_LABORAL VALUES( '10684781', '001', to_date('03/01/2004', 'dd/mm/yyyy'), '', '001', '');
INSERT INTO HISTORIAL_LABORAL VALUES( '38744043', '003', to_date('16/09/2002', 'dd/mm/yyyy'), '', '003', '');