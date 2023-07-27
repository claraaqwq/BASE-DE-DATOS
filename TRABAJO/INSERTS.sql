--INSERTS
SELECT * FROM HB_PERSONA;
/
INSERT INTO HB_PERSONA VALUES(1001,'Juan Carlos','Pérez González','C');
INSERT INTO HB_PERSONA VALUES(1002,'María Fernanda','García López','M');
INSERT INTO HB_PERSONA VALUES(1003,'Luis Alejandro','Rodríguez Martínez','M');
INSERT INTO HB_PERSONA VALUES(1004,'Ana Laura','López Sánchez','C');
INSERT INTO HB_PERSONA VALUES(1005,'Pedro Antonio','Martínez Ramírez','M');
INSERT INTO HB_PERSONA VALUES(1006,'Sofía Alejandra','Sánchez Torres','C');
INSERT INTO HB_PERSONA VALUES(1007,'Miguel Ángel','Fernández González','C');
INSERT INTO HB_PERSONA VALUES(1008,'Laura Isabel','Torres Rodríguez','M');
INSERT INTO HB_PERSONA VALUES(1009,'David Eduardo','Ramírez López','C');
INSERT INTO HB_PERSONA VALUES(1010,'Gabriela Carmen','Morales García','M');
INSERT INTO HB_PERSONA VALUES(1011,'Luis Alberto','Hernández Juárez','C');
INSERT INTO HB_PERSONA VALUES(1012, 'Ana María', 'Rodríguez Sánchez', 'C');
INSERT INTO HB_PERSONA VALUES(1013, 'Piero Giovanni', 'Suarez Chavez', 'C');
/
SELECT * FROM HB_CAJERO;
/
INSERT INTO HB_CAJERO VALUES(1001,'Juan Carlos','12:00:00','18:00:08'  );
INSERT INTO HB_CAJERO VALUES(1004, 'Ana Laura', '15:30:00', '18:30:00');
INSERT INTO HB_CAJERO VALUES(1006, 'Sofía Alejandra', '13:00:00', '18:00:00');
INSERT INTO HB_CAJERO VALUES(1007, 'Miguel Ángel', '12:45:00', '16:45:00');
INSERT INTO HB_CAJERO VALUES(1009, 'David Eduardo', '16:30:00', '22:30:00');
INSERT INTO HB_CAJERO VALUES(1011, 'Luis Alberto', '12:30:00', '21:30:00');
INSERT INTO HB_CAJERO VALUES(1012, 'Ana María', '18:30:00', '23:30:00');
INSERT INTO HB_CAJERO VALUES(1013, 'Piero Giovanni', '14:40:00', '19:00:00');
/
SELECT * FROM HB_PEDIDO;
/
INSERT INTO HB_PEDIDO VALUES (00034566,'20/04/2023','13:32:00',1007,NULL,NULL,'Mafer','P',14.00,'E',0.00);
INSERT INTO HB_PEDIDO VALUES (00045445,'21/06/2023','17:43:00',1001,NULL,NULL,'Joshua','P',14.00,'E',0.00);
INSERT INTO HB_PEDIDO VALUES (00025895,'15/04/2023','14:00:15',1004,NULL,NULL,'Mateo','P',20.00,'E',0.00);
INSERT INTO HB_PEDIDO VALUES (00084001,'10/07/2023','19:00:15',1009,951258456,'Avenida Sucre 123','Tomas','D',40.00,'P',0.00);
INSERT INTO HB_PEDIDO VALUES (00057801,'31/01/2023','15:00:15',1006,999458722,'Avenida La Marina 456','Melannie','D',50.00,'E',10.00);
INSERT INTO HB_PEDIDO VALUES (00075881,'16/06/2023','20:14:15',1011,958745635,'Calle Las Palmeras 789','Mario','D',55.10,'P',15.00);
INSERT INTO HB_PEDIDO VALUES (00032587,'20/04/2023','23:28:15',1012,900585365,'Avenida Principal 987','Julia','D',15.00,'E',0.00);
INSERT INTO HB_PEDIDO VALUES (00045819,'17/02/2023','18:00:15',1013,987365210,'Calle Central 654','Pedro','D',45.00,'P',12.50);
/
SELECT * FROM HB_ENTREGA;
/
INSERT INTO HB_ENTREGA VALUES (4001,00084001,1002,'20:30:00');
INSERT INTO HB_ENTREGA VALUES (4002,00057801,1003,'15:45:00');
INSERT INTO HB_ENTREGA VALUES (4003,00075881,1005,'21:00:00');
INSERT INTO HB_ENTREGA VALUES (4004,00032587,1008,'23:45:00');
INSERT INTO HB_ENTREGA VALUES (4005,00045819,1010,'18:50:00');
/
SELECT * FROM HB_PEDIDO;
/
SELECT * FROM HB_INGREDIENTE;
/
insert into hb_ingrediente values(1001,'carne',10,'porcion');
insert into hb_ingrediente values(1002,'huevo',10,'porcion');
insert into hb_ingrediente values(1003,'pan',10,'porcion');
insert into hb_ingrediente values(1004,'lechuga',10,'porcion');
insert into hb_ingrediente values(1005,'tomate',10,'porcion');
insert into hb_ingrediente values(1006,'queso',10,'porcion');
insert into hb_ingrediente values(1007,'pollo',10,'porcion');
insert into hb_ingrediente values(1008,'pan rosete',10,'porcion');
insert into hb_ingrediente values(1009,'pechuga',10,'porcion');
insert into hb_ingrediente values(1010,'jamon',10,'porcion');
insert into hb_ingrediente values(1011,'papas al hilo',10,'porcion');
insert into hb_ingrediente values(1012,'chorizo',10,'porcion');
insert into hb_ingrediente values(1013,'salchicha',10,'porcion');
insert into hb_ingrediente values(1014,'milanesa',10,'porcion');
insert into hb_ingrediente values(1015,'maiz morado',10,'porcion');
insert into hb_ingrediente values(1016,'tosino',10,'porcion');
insert into hb_ingrediente values(1017,'Coca Cola 500ml',10,'porcion');
insert into hb_ingrediente values(1018,'Inca Cola 500ml',10,'porcion');
insert into hb_ingrediente values(1019,'Coca Cola 300ml',10,'porcion');
insert into hb_ingrediente values(1020,'Inca Cola 300ml',10,'porcion');
insert into hb_ingrediente values(1021,'Agua Cielo',10,'porcion');
/
SELECT * FROM HB_PRODUCTO;
/
INSERT INTO HB_PRODUCTO VALUES (5001,'Hamburguesa de carne',9.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5002,'Hamburguesa de carne con queso',10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5003,'Hamburguesa de carne con huevo',10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5004,'Hamburguesa de carne royal',11.5,'N');

INSERT INTO HB_PRODUCTO VALUES (5005,'Pollo deshilachado' ,10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5006,'Pollo deshilachado royal con queso',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5007,'Pollo deshilachado royal con huevo',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5008,'Pollo deshilachado royal',12.5,'N');

INSERT INTO HB_PRODUCTO VALUES (5009,'Chorizo',9.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5010,'Chorizo con queso',10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5011,'Chorizo con huevo',10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5012,'Chorizo royal',11.5,'N');

INSERT INTO HB_PRODUCTO VALUES (5013,'Salchicha Frankfurter',10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5014,'Salchicha Frankfurter con queso',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5015,'Salchicha Frankfurter con huevo',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5016,'Salchicha Frankfurter royal',12.5,'N');

INSERT INTO HB_PRODUCTO VALUES (5017,'Milanesa' ,10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5018,'Milanesa con queso',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5019,'Milanesa con huevo',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5020,'Milanesa royal',12.5,'N');

INSERT INTO HB_PRODUCTO VALUES (5021,'Hamburguesa de pollo',10.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5022,'Hamburguesa pollo con queso',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5023,'Hamburguesa pollo con huevo',11.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5024,'Hamburguesa pollo royal',12.5,'N');

INSERT INTO HB_PRODUCTO VALUES (5025,'Punche Parrillera',14,'N');
INSERT INTO HB_PRODUCTO VALUES (5026,'La Bica',15,'N');
INSERT INTO HB_PRODUCTO VALUES (5027,'La Maravilla',15,'N');
INSERT INTO HB_PRODUCTO VALUES (5028,'La Craest',15,'N');
INSERT INTO HB_PRODUCTO VALUES (5029,'La bigote',16,'N');

INSERT INTO HB_PRODUCTO VALUES (5030,'Chicha',3,'N');
INSERT INTO HB_PRODUCTO VALUES (5031,'Coca Cola 500ml',3,'N');
INSERT INTO HB_PRODUCTO VALUES (5032,'Inca Cola 500ml',3,'N');
INSERT INTO HB_PRODUCTO VALUES (5033,'Coca Cola 300ml',2,'N');
INSERT INTO HB_PRODUCTO VALUES (5034,'Inca Cola 300ml',2,'N');
INSERT INTO HB_PRODUCTO VALUES (5035,'Agua Cielo',2,'N');
INSERT INTO HB_PRODUCTO VALUES (5036,'Huevo',1,'N');
INSERT INTO HB_PRODUCTO VALUES (5037,'Queso',2,'N');
INSERT INTO HB_PRODUCTO VALUES (5038,'1 Tocino',2.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5039,'Carne',4.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5040,'Chorizo',4.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5041,'Pollo Deshilachado',5.5,'N');
INSERT INTO HB_PRODUCTO VALUES (5042,'Salchicha Frankfurter',5.5,'N');
--
INSERT INTO HB_PRODUCTO VALUES (5043,'Combo Para 2',27,'C');
INSERT INTO HB_PRODUCTO VALUES (5044,'Combo Para 3',34,'C');
INSERT INTO HB_PRODUCTO VALUES (5045,'Combo Cachimbo',12,'C');
/
SELECT * FROM HB_DETALLE_PEDIDO;--*****
/
insert into HB_DETALLE_PEDIDO VALUES(34566,5001,2,19);
insert into HB_DETALLE_PEDIDO VALUES(34566,5002,2,21);
insert into HB_DETALLE_PEDIDO VALUES(45445,5003,2,21);
insert into HB_DETALLE_PEDIDO VALUES(45445,5002,2,21);
insert into HB_DETALLE_PEDIDO VALUES(25895,5010,2,21);
insert into HB_DETALLE_PEDIDO VALUES(25895,5011,2,21);
insert into HB_DETALLE_PEDIDO VALUES(84001,5025,1,14);
insert into HB_DETALLE_PEDIDO VALUES(57801,5029,1,16);
insert into HB_DETALLE_PEDIDO VALUES(75881,5035,1,2);
insert into HB_DETALLE_PEDIDO VALUES(32587,5011,2,21);
insert into HB_DETALLE_PEDIDO VALUES(32587,5010,2,21);
insert into HB_DETALLE_PEDIDO VALUES(45819,5043,2,54);
/
SELECT * FROM HB_PRODUCTO_COMBO;
/
INSERT INTO HB_PRODUCTO_COMBO VALUES (5043,5001,1);
INSERT INTO HB_PRODUCTO_COMBO VALUES (5043,5008,1);
INSERT INTO HB_PRODUCTO_COMBO VALUES (5043,5033,2);
INSERT INTO HB_PRODUCTO_COMBO VALUES (5044,5004,2);
INSERT INTO HB_PRODUCTO_COMBO VALUES (5044,5020,1);
INSERT INTO HB_PRODUCTO_COMBO VALUES (5045,5004,1);
INSERT INTO HB_PRODUCTO_COMBO VALUES (5045,5033,1);
/
SELECT * FROM hb_hamburguesa_ingrediente;
/
--ID_PRODUCTO + ID_INGREDIENTE + CANTIDAD
insert into hb_hamburguesa_ingrediente values(5001,1001,1);
insert into hb_hamburguesa_ingrediente values(5001,1002,1);
insert into hb_hamburguesa_ingrediente values(5001,1003,1);
insert into hb_hamburguesa_ingrediente values(5001,1004,1);
insert into hb_hamburguesa_ingrediente values(5001,1005,1);
--
insert into hb_hamburguesa_ingrediente values(5002,1001,1);
insert into hb_hamburguesa_ingrediente values(5002,1002,1);
insert into hb_hamburguesa_ingrediente values(5002,1003,1);
insert into hb_hamburguesa_ingrediente values(5002,1004,1);
insert into hb_hamburguesa_ingrediente values(5002,1005,1);
insert into hb_hamburguesa_ingrediente values(5002,1006,1);
--
insert into hb_hamburguesa_ingrediente values(5003,1001,1);
insert into hb_hamburguesa_ingrediente values(5003,1002,1);
insert into hb_hamburguesa_ingrediente values(5003,1003,1);
insert into hb_hamburguesa_ingrediente values(5003,1004,1);
insert into hb_hamburguesa_ingrediente values(5003,1005,1);
--
insert into hb_hamburguesa_ingrediente values(5004,1003,1);
insert into hb_hamburguesa_ingrediente values(5004,1004,1);
insert into hb_hamburguesa_ingrediente values(5004,1001,1);
--
insert into hb_hamburguesa_ingrediente values(5005,1007,1);
insert into hb_hamburguesa_ingrediente values(5005,1004,1);
insert into hb_hamburguesa_ingrediente values(5005,1008,1);
--
insert into hb_hamburguesa_ingrediente values(5006,1009,1);
insert into hb_hamburguesa_ingrediente values(5006,1008,1);
insert into hb_hamburguesa_ingrediente values(5006,1010,1);
insert into hb_hamburguesa_ingrediente values(5006,1006,1);
insert into hb_hamburguesa_ingrediente values(5006,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5007,1009,1);
insert into hb_hamburguesa_ingrediente values(5007,1008,1);
insert into hb_hamburguesa_ingrediente values(5007,1002,1);
 insert into hb_hamburguesa_ingrediente values(5007,1010,1);
 insert into hb_hamburguesa_ingrediente values(5007,1011,1);
--
 insert into hb_hamburguesa_ingrediente values(5008,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5010,1012,1);
insert into hb_hamburguesa_ingrediente values(5010,1006,1);
insert into hb_hamburguesa_ingrediente values(5010,1003,1);
--
insert into hb_hamburguesa_ingrediente values(5011,1002,1);
insert into hb_hamburguesa_ingrediente values(5011,1003,1);
insert into hb_hamburguesa_ingrediente values(5011,1012,1);
--
insert into hb_hamburguesa_ingrediente values(5012,1012,1);
insert into hb_hamburguesa_ingrediente values(5012,1006,1);
insert into hb_hamburguesa_ingrediente values(5012,1002,1);
insert into hb_hamburguesa_ingrediente values(5012,1003,1);
--
insert into hb_hamburguesa_ingrediente values(5013,1013,1);
insert into hb_hamburguesa_ingrediente values(5013,1003,1);
insert into hb_hamburguesa_ingrediente values(5013,1014,1);
--
insert into hb_hamburguesa_ingrediente values(5014,1013,1);
insert into hb_hamburguesa_ingrediente values(5014,1006,1);
insert into hb_hamburguesa_ingrediente values(5014,1003,1);
insert into hb_hamburguesa_ingrediente values(5014,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5015,1013,1);
insert into hb_hamburguesa_ingrediente values(5015,1002,1);
insert into hb_hamburguesa_ingrediente values(5015,1003,1);
--
insert into hb_hamburguesa_ingrediente values(5016,1013,1);
insert into hb_hamburguesa_ingrediente values(5016,1011,1);
insert into hb_hamburguesa_ingrediente values(5016,1002,1);
insert into hb_hamburguesa_ingrediente values(5016,1006,1);
insert into hb_hamburguesa_ingrediente values(5016,1003,1);
--
insert into hb_hamburguesa_ingrediente values(5017,1014,1);
insert into hb_hamburguesa_ingrediente values(5017,1004,1);
insert into hb_hamburguesa_ingrediente values(5017,1003,1);
--
insert into hb_hamburguesa_ingrediente values(5018,1014,1);
insert into hb_hamburguesa_ingrediente values(5018,1006,1);
insert into hb_hamburguesa_ingrediente values(5018,1004,1);
insert into hb_hamburguesa_ingrediente values(5018,1003,1);
insert into hb_hamburguesa_ingrediente values(5018,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5019,1014,1);
insert into hb_hamburguesa_ingrediente values(5019,1002,1);
insert into hb_hamburguesa_ingrediente values(5019,1004,1);
insert into hb_hamburguesa_ingrediente values(5019,1003,1);
insert into hb_hamburguesa_ingrediente values(5019,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5020,1002,1);
insert into hb_hamburguesa_ingrediente values(5020,1014,1);
insert into hb_hamburguesa_ingrediente values(5020,1004,1);
insert into hb_hamburguesa_ingrediente values(5020,1003,1);
insert into hb_hamburguesa_ingrediente values(5020,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5021,1003,1);
insert into hb_hamburguesa_ingrediente values(5021,1007,1);
insert into hb_hamburguesa_ingrediente values(5021,1004,1);
insert into hb_hamburguesa_ingrediente values(5021,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5022,1013,1);
insert into hb_hamburguesa_ingrediente values(5022,1007,1);
insert into hb_hamburguesa_ingrediente values(5022,1004,1);
insert into hb_hamburguesa_ingrediente values(5022,1006,1);
insert into hb_hamburguesa_ingrediente values(5022,1011,1);
--
insert into hb_hamburguesa_ingrediente values(5023,1003,1);
insert into hb_hamburguesa_ingrediente values(5023,1007,1);
insert into hb_hamburguesa_ingrediente values(5023,1002,1);
insert into hb_hamburguesa_ingrediente values(5023,1004,1);
insert into hb_hamburguesa_ingrediente values(5023,1011,1);

--
insert into hb_hamburguesa_ingrediente values(5024,1003,1);
insert into hb_hamburguesa_ingrediente values(5024,1007,1);
insert into hb_hamburguesa_ingrediente values(5024,1006,1);
insert into hb_hamburguesa_ingrediente values(5024,1002,1);
insert into hb_hamburguesa_ingrediente values(5024,1004,1);
insert into hb_hamburguesa_ingrediente values(5024,1011,1);
--5025
--
insert into hb_hamburguesa_ingrediente values(5025,1001,1);
insert into hb_hamburguesa_ingrediente values(5025,1003,1);
insert into hb_hamburguesa_ingrediente values(5025,1011,1);
insert into hb_hamburguesa_ingrediente values(5025,1012,1);
--
insert into hb_hamburguesa_ingrediente values(5026,1001,1);
insert into hb_hamburguesa_ingrediente values(5026,1013,1);
insert into hb_hamburguesa_ingrediente values(5026,1011,1);
insert into hb_hamburguesa_ingrediente values(5026,1003,1);
--
insert into hb_hamburguesa_ingrediente values(5027,1001,1);
insert into hb_hamburguesa_ingrediente values(5027,1016,1);
insert into hb_hamburguesa_ingrediente values(5027,1006,1);
insert into hb_hamburguesa_ingrediente values(5027,1003,1);
insert into hb_hamburguesa_ingrediente values(5027,1011,1);
----
insert into hb_hamburguesa_ingrediente values(5028,1003,1);
insert into hb_hamburguesa_ingrediente values(5028,1011,1);
insert into hb_hamburguesa_ingrediente values(5028,1001,1);
insert into hb_hamburguesa_ingrediente values(5028,1007,1);
insert into hb_hamburguesa_ingrediente values(5028,1006,1);
--
insert into hb_hamburguesa_ingrediente values(5029,1001,2);
insert into hb_hamburguesa_ingrediente values(5029,1011,1);
insert into hb_hamburguesa_ingrediente values(5029,1003,1);
insert into hb_hamburguesa_ingrediente values(5029,1002,1);
--
insert into hb_hamburguesa_ingrediente values(5030,1015,1);
insert into hb_hamburguesa_ingrediente values(5031,1017,1);
insert into hb_hamburguesa_ingrediente values(5032,1018,1);
insert into hb_hamburguesa_ingrediente values(5033,1019,1);
insert into hb_hamburguesa_ingrediente values(5034,1020,1);
insert into hb_hamburguesa_ingrediente values(5035,1021,1);
/
SELECT * FROM HB_LOTE;
/
INSERT INTO HB_LOTE VALUES(1,'CARNE',1,1001,100,'10/02/2023','10/01/2023',300);
INSERT INTO HB_LOTE VALUES(2,'CARNE',2,1001,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(3,'PAN',1,1002,100,'10/02/2023','10/01/2023',300);
INSERT INTO HB_LOTE VALUES(4,'PAN',2,1002,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(5,'PAN',1,1003,100,'10/02/2023','10/01/2023',300);
INSERT INTO HB_LOTE VALUES(6,'LECHUGA',1,1004,100,'10/02/2023','10/01/2023',300);
INSERT INTO HB_LOTE VALUES(7,'TOMATE',1,1005,100,'10/02/2023','10/01/2023',300);
INSERT INTO HB_LOTE VALUES(8,'TOMATE',1,1005,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(9,'QUESO',1,1006,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(10,'QUESO',2,1006,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(11,'POLLO',1,1007,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(12,'POLLO',2,1007,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(13,'PAN ROSETE',1,1008,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(14,'PAN ROSETE',2,1008,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(15,'PECHUGA',1,1009,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(16,'PECHUGA',2,1009,100,'10/05/2023','10/04/2023',300);
INSERT INTO HB_LOTE VALUES(17,'JAMON',1,1009,100,'10/02/2023','10/01/2023',300);
INSERT INTO HB_LOTE VALUES(18,'JAMON',2,1009,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(19,'PAPAS AL HILO',1,1011,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(20,'PAPAS AL HILO',2,1011,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(21,'CHORIZO',1,1012,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(22,'SALCHICHA',1,1013,100,'10/03/2023','10/02/2023',300);
INSERT INTO HB_LOTE VALUES(23,'SALCHICHA',2,1013,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(24,'MILANESA',1,1014,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(25,'MAIZ MORADO',1,1015,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(26,'MAIZ MORADO',2,1015,100,'10/05/2023','10/04/2023',300);
INSERT INTO HB_LOTE VALUES(27,'TOCINO',1,1015,100,'10/04/2023','10/03/2023',300);
INSERT INTO HB_LOTE VALUES(28,'TOCINO',2,1015,100,'10/04/2023','10/03/2023',300);
/
SELECT * FROM HB_METODO_PAGO;
/
INSERT INTO hb_metodo_pago VALUES (001,'EFECTIVO');
INSERT INTO hb_metodo_pago VALUES (002,'TARJETA DE DEBITO');
INSERT INTO hb_metodo_pago VALUES (003,'TARJETA DE CREDITO');
INSERT INTO hb_metodo_pago VALUES (004,'MONEDERO VIRTUAL');
INSERT INTO hb_metodo_pago VALUES (005,'TRANSFERENCIA BANCARIA');
/
commit;

