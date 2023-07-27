INSERT INTO TIPO_DOCUMENTO (ID_TIPO_DOCUMENTO, NOMBRE, ESTADO) VALUES (1, 'DNI', 'A');
INSERT INTO TIPO_DOCUMENTO (ID_TIPO_DOCUMENTO, NOMBRE, ESTADO) VALUES (2, 'Pasaporte', 'A');
INSERT INTO TIPO_DOCUMENTO (ID_TIPO_DOCUMENTO, NOMBRE, ESTADO) VALUES (3, 'Carné Extranjería', 'A');

INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 1, 'Gerente General'       , 25000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 2, 'Gerente de Operaciones', 15000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 3, 'Administrador'         , 16000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 4, 'Jefe de Imagen'        , 12000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 5, 'Analista Comercial'    ,  9000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 6, 'Jefe de Soporte'       , 10000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 7, 'Jefe de Proyectos'     ,  7000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 8, 'Analista Programador'  ,  5500, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES ( 9, 'Programador'           ,  4000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES (10, 'Programador Junior'    ,  2000, 'A');
INSERT INTO CARGO (ID_CARGO, NOMBRE, SUELDO_BASICO, ESTADO) VALUES (11, 'Analista de Marketing' ,  2500, 'A');

INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 1, 1, '88930782' , 'RODRIGUEZ ORTEGA, DANIEL MANUEL'    , '984745436', 'drodriguez@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 2, 1, '03879129' , 'CHAVEZ TAVERA, BRUNO MARTIN'        , '965454168', 'bchavez@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 3, 1, '57206829' , 'SANCHEZ CARLOS, JULIO ROBERTO'      , '941653517', 'jsanchez@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 4, 3, '001040878', 'CARDOSO MARTINEZ, FRANCISCO MIGUEL' , '956554778', 'fcardoso@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 5, 3, '000970242', 'RODRIGUEZ RUIZ, EDDIE FRANCISCO'    , '965526132', 'erodriguez@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 6, 1, '78909294' , 'PISCONTE DE LA CRUZ, SANDRA VIVIANA', '973685667', 'spisconte@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 7, 1, '28769290' , 'APARICIO MANCO, CARLA PATRICIA'     , '997465713', 'caparicio@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 8, 1, '47891069' , 'DEZA RIVERA, ERICK TIMOTEO'         , '925761456', 'edeza@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES ( 9, 2, '5216413'  , 'ROMERO RAMIREZ, DIEGO ANTONIO'      , '958476476', 'dromero@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES (10, 2, '4342192'  , 'TELLO MELENDEZ, JOSE ALBERTO'       , '937163345', 'jtello@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES (11, 1, '68950025' , 'VERA CORDOVA, JORGE FELIX'          , '946657445', 'jvera@rent.com.pe');
INSERT INTO PERSONA (ID_PERSONA, ID_TIPO_DOCUMENTO, NRO_DOCUMENTO, NOMBRES, TELEFONO, CORREO_ELECTRONICO) VALUES (12, 1, '70578552' , 'RODRIGUEZ VERA, FRANCISCA'          , '967531435', 'frodriguez@rent.com.pe');

INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 1,  1,  1, TO_DATE('02/02/2016', 'DD/MM/YYYY'), TO_DATE('02/02/2021', 'DD/MM/YYYY'), 25000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 2,  2,  2, TO_DATE('02/02/2016', 'DD/MM/YYYY'), TO_DATE('02/02/2021', 'DD/MM/YYYY'), 15000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 3,  3,  3, TO_DATE('02/02/2016', 'DD/MM/YYYY'), TO_DATE('02/02/2021', 'DD/MM/YYYY'), 16000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 4,  4,  6, TO_DATE('02/02/2016', 'DD/MM/YYYY'), NULL                               , 10000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 5,  5,  8, TO_DATE('02/02/2016', 'DD/MM/YYYY'), NULL                               ,  5500, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 6,  6,  7, TO_DATE('01/04/2016', 'DD/MM/YYYY'), NULL                               ,  7000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 7,  7, 10, TO_DATE('01/04/2016', 'DD/MM/YYYY'), NULL                               ,  2000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 8,  8,  9, TO_DATE('01/04/2016', 'DD/MM/YYYY'), NULL                               ,  4000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES ( 9,  9,  8, TO_DATE('05/05/2016', 'DD/MM/YYYY'), NULL                               ,  5500, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES (10, 10, 11, TO_DATE('16/04/2017', 'DD/MM/YYYY'), TO_DATE('08/08/2018', 'DD/MM/YYYY'),  2500, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES (11, 11,  4, TO_DATE('01/01/2020', 'DD/MM/YYYY'), NULL                               , 12000, NULL);
INSERT INTO PERSONAL (ID_PERSONAL, ID_PERSONA, ID_CARGO, FECHA_INICIO, FECHA_FIN, SUELDO_BASICO, SUELDO_BONIFICACION) VALUES (12, 12, 11, TO_DATE('01/07/2020', 'DD/MM/YYYY'), TO_DATE('01/08/2020', 'DD/MM/YYYY'),  2500, NULL);