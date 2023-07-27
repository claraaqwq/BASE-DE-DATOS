-- Generado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   en:        2023-05-06 23:34:58 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE hb_almacen (
    id_almacen        NUMBER NOT NULL,
    nombre            VARCHAR2(50 BYTE) NOT NULL,
    direccion_almacen VARCHAR2(100 BYTE) NOT NULL,
    id_ingrediente    NUMBER NOT NULL
);

COMMENT ON COLUMN hb_almacen.id_almacen IS
    'IDENTIFICADOR DEL ALMACEN';

COMMENT ON COLUMN hb_almacen.nombre IS
    'NOMBRE DEL ALMACEN';

COMMENT ON COLUMN hb_almacen.direccion_almacen IS
    'DIRECCION DEL ALMACEN';

ALTER TABLE hb_almacen ADD CONSTRAINT hb_almacen_pk PRIMARY KEY ( id_almacen );

CREATE TABLE hb_boleta (
    id_boleta      NUMBER NOT NULL,
    id_comprobante NUMBER NOT NULL
);

COMMENT ON COLUMN hb_boleta.id_boleta IS
    'IDENTIFICADOR DE LA BOLETA';

ALTER TABLE hb_boleta ADD CONSTRAINT hb_boleta_pk PRIMARY KEY ( id_boleta );

CREATE TABLE hb_cajero (
    id_cajero NUMBER NOT NULL,
    nombre    VARCHAR2(50 BYTE) NOT NULL
);

COMMENT ON COLUMN hb_cajero.id_cajero IS
    'IDENTIFICADOR DEL CAJERO';

COMMENT ON COLUMN hb_cajero.nombre IS
    'NOMBRE DEL CAJERO';

ALTER TABLE hb_cajero ADD CONSTRAINT hb_cajero_pk PRIMARY KEY ( id_cajero );

CREATE TABLE hb_cliente (
    id_cliente NUMBER NOT NULL,
    nombre     VARCHAR2(50 BYTE) NOT NULL,
    direccion  VARCHAR2(100 BYTE)
);

COMMENT ON COLUMN hb_cliente.id_cliente IS
    'IDENTIFICADOR DEL CLIENTE';

COMMENT ON COLUMN hb_cliente.nombre IS
    'NOMBRE DEL CLIENTE';

COMMENT ON COLUMN hb_cliente.direccion IS
    'DIRECCION DEL CLIENTE SI REALIZA UN PEDIDO PARA LLEVAR';

ALTER TABLE hb_cliente ADD CONSTRAINT hb_cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE hb_combo (
    id_combo  NUMBER NOT NULL,
    nombre    VARCHAR2(50 BYTE) NOT NULL,
    descuento NUMBER
);

COMMENT ON COLUMN hb_combo.id_combo IS
    'IDENTIFICADOR DEL COMBO(PROMOCION)';

COMMENT ON COLUMN hb_combo.nombre IS
    'NOMBRE DEL COMBO';

COMMENT ON COLUMN hb_combo.descuento IS
    'DESCUENTO EN EL PRODUCTO';

ALTER TABLE hb_combo ADD CONSTRAINT hb_combo_pk PRIMARY KEY ( id_combo );

CREATE TABLE hb_comprobante (
    id_comprobante      NUMBER NOT NULL,
    fecha_compra        DATE NOT NULL,
    monto               NUMBER NOT NULL,
    cantidad            NUMBER,
    hb_pedido_id_pedido NUMBER NOT NULL
);

COMMENT ON COLUMN hb_comprobante.id_comprobante IS
    'IDENTIFICADOR DEL COMPROBANTE';

COMMENT ON COLUMN hb_comprobante.fecha_compra IS
    'FECHA EN LA QUE SE REALIZO LA COMPRA';

COMMENT ON COLUMN hb_comprobante.monto IS
    'MONTO TOTAL DE LOS PRODUCTOS QUE CONSUMIO';

COMMENT ON COLUMN hb_comprobante.cantidad IS
    'CANTIDAD DE PRODUCTOS COMPRADOS';

ALTER TABLE hb_comprobante ADD CONSTRAINT hb_comprobante_pk PRIMARY KEY ( id_comprobante );

CREATE TABLE hb_comprobante_metodo_pagov1 (
    id_comprobante NUMBER NOT NULL,
    id_medio_pago  NUMBER NOT NULL
);

ALTER TABLE hb_comprobante_metodo_pagov1 ADD CONSTRAINT hb_comprobante_metodo_pago_pk PRIMARY KEY ( id_comprobante,
                                                                                                    id_medio_pago );

CREATE TABLE hb_entrega (
    id_entrega          NUMBER NOT NULL,
    fecha_entrega       DATE NOT NULL,
    hora_entrega        NUMBER NOT NULL,
    direccion           VARCHAR2(100 BYTE),
    hb_pedido_id_pedido NUMBER NOT NULL
);

COMMENT ON COLUMN hb_entrega.id_entrega IS
    'IDENTIFICADOR DE ENTREGA';

COMMENT ON COLUMN hb_entrega.fecha_entrega IS
    'FECHA DE LA ENTREGA';

COMMENT ON COLUMN hb_entrega.hora_entrega IS
    'HORA DE LA ENTREGA DEL PRODUCT';

COMMENT ON COLUMN hb_entrega.direccion IS
    'DIRECCION PARA LA ENTREGA';

ALTER TABLE hb_entrega ADD CONSTRAINT hb_entrega_pk PRIMARY KEY ( id_entrega );

CREATE TABLE hb_factura (
    id_factura     NUMBER NOT NULL,
    id_comprobante NUMBER NOT NULL
);

COMMENT ON COLUMN hb_factura.id_factura IS
    'IDENTIFICADOR DE LA FACTURA';

ALTER TABLE hb_factura ADD CONSTRAINT hb_factura_pk PRIMARY KEY ( id_factura );

CREATE TABLE hb_hamburguesa_ingrediente (
    id_producto    NUMBER NOT NULL,
    id_ingrediente NUMBER NOT NULL
);

ALTER TABLE hb_hamburguesa_ingrediente ADD CONSTRAINT hb_hamburguesa_ingrediente_pk PRIMARY KEY ( id_producto,
                                                                                                  id_ingrediente );

CREATE TABLE hb_hamburguesa_promocion (
    id_producto       NUMBER NOT NULL,
    id_combo          NUMBER NOT NULL,
    hb_combo_id_combo NUMBER NOT NULL
);

ALTER TABLE hb_hamburguesa_promocion ADD CONSTRAINT hb_hamburguesa_promocion_pk PRIMARY KEY ( id_producto,
                                                                                              id_combo );

CREATE TABLE hb_ingrediente (
    id_ingrediente     NUMBER NOT NULL,
    nombre             VARCHAR2(50 BYTE) NOT NULL,
    precio_ingrediente NUMBER NOT NULL
);

COMMENT ON COLUMN hb_ingrediente.id_ingrediente IS
    'IDENTIFICADOR DEL INGREDIENTE';

COMMENT ON COLUMN hb_ingrediente.nombre IS
    'NOMBRE DEL INGREDIENTE';

COMMENT ON COLUMN hb_ingrediente.precio_ingrediente IS
    'PRECIO POR INGREDIENTE';

ALTER TABLE hb_ingrediente ADD CONSTRAINT hb_ingrediente_pk PRIMARY KEY ( id_ingrediente );

CREATE TABLE hb_metodo_pago (
    id_medio_pago NUMBER NOT NULL,
    nombre        VARCHAR2(50 BYTE) NOT NULL
);

COMMENT ON COLUMN hb_metodo_pago.id_medio_pago IS
    'IDENTIFICADOR DEL MEDIO DE PAGO';

COMMENT ON COLUMN hb_metodo_pago.nombre IS
    'NOMBRE DEL MEDIO DE PAGO
';

ALTER TABLE hb_metodo_pago ADD CONSTRAINT hb_metodo_pago_pk PRIMARY KEY ( id_medio_pago );

CREATE TABLE hb_orden_hamburguesa (
    id_pedido   NUMBER NOT NULL,
    id_producto NUMBER NOT NULL
);

ALTER TABLE hb_orden_hamburguesa ADD CONSTRAINT hb_orden_hamburguesa_pk PRIMARY KEY ( id_pedido,
                                                                                      id_producto );

CREATE TABLE hb_pedido (
    id_pedido      NUMBER NOT NULL,
    fecha_registro DATE NOT NULL,
    hora           NUMBER NOT NULL,
    id_cajero      NUMBER NOT NULL,
    id_cliente     NUMBER NOT NULL
);

COMMENT ON COLUMN hb_pedido.id_pedido IS
    'IDENTIFICADOR DEL NUMERO DEL PEDIDO';

COMMENT ON COLUMN hb_pedido.fecha_registro IS
    'FECHA EN LA QUE SE REALIZÓ EL PEDIDO';

COMMENT ON COLUMN hb_pedido.hora IS
    'HORA EN LA QUE SE REALIZO EL PEDIDO';

ALTER TABLE hb_pedido ADD CONSTRAINT hb_pedido_pk PRIMARY KEY ( id_pedido );

CREATE TABLE hb_producto (
    id_producto NUMBER NOT NULL,
    nombre      VARCHAR2(50 BYTE) NOT NULL,
    precio      NUMBER NOT NULL
);

COMMENT ON COLUMN hb_producto.id_producto IS
    'IDENTIFICADOR DEL PRODUCTO';

COMMENT ON COLUMN hb_producto.nombre IS
    'NOMBRE DEL PRODUCTO';

COMMENT ON COLUMN hb_producto.precio IS
    'PRECIO DEL PRODUCTO';

ALTER TABLE hb_producto ADD CONSTRAINT hb_producto_pk PRIMARY KEY ( id_producto );

ALTER TABLE hb_almacen
    ADD CONSTRAINT hb_almacen_hb_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES hb_ingrediente ( id_ingrediente );

ALTER TABLE hb_boleta
    ADD CONSTRAINT hb_boleta_hb_comprobante_fk FOREIGN KEY ( id_comprobante )
        REFERENCES hb_comprobante ( id_comprobante );

ALTER TABLE hb_comprobante
    ADD CONSTRAINT hb_comprobante_hb_pedido_fk FOREIGN KEY ( hb_pedido_id_pedido )
        REFERENCES hb_pedido ( id_pedido );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_comprobante_metodo_pagov1
    ADD CONSTRAINT hb_comprobante_metodo_pago_hb_comprobante_fk FOREIGN KEY ( id_comprobante )
        REFERENCES hb_comprobante ( id_comprobante );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_comprobante_metodo_pagov1
    ADD CONSTRAINT hb_comprobante_metodo_pago_hb_metodo_pago_fk FOREIGN KEY ( id_medio_pago )
        REFERENCES hb_metodo_pago ( id_medio_pago );

ALTER TABLE hb_entrega
    ADD CONSTRAINT hb_entrega_hb_pedido_fk FOREIGN KEY ( hb_pedido_id_pedido )
        REFERENCES hb_pedido ( id_pedido );

ALTER TABLE hb_factura
    ADD CONSTRAINT hb_factura_hb_comprobante_fk FOREIGN KEY ( id_comprobante )
        REFERENCES hb_comprobante ( id_comprobante );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_hamburguesa_ingrediente
    ADD CONSTRAINT hb_hamburguesa_ingrediente_hb_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES hb_ingrediente ( id_ingrediente );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_hamburguesa_ingrediente
    ADD CONSTRAINT hb_hamburguesa_ingrediente_hb_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES hb_producto ( id_producto );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_hamburguesa_promocion
    ADD CONSTRAINT hb_hamburguesa_promocion_hb_combo_fk FOREIGN KEY ( hb_combo_id_combo )
        REFERENCES hb_combo ( id_combo );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_hamburguesa_promocion
    ADD CONSTRAINT hb_hamburguesa_promocion_hb_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES hb_producto ( id_producto );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_orden_hamburguesa
    ADD CONSTRAINT hb_orden_hamburguesa_hb_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES hb_pedido ( id_pedido );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE hb_orden_hamburguesa
    ADD CONSTRAINT hb_orden_hamburguesa_hb_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES hb_producto ( id_producto );

ALTER TABLE hb_pedido
    ADD CONSTRAINT hb_pedido_hb_cajero_fk FOREIGN KEY ( id_cajero )
        REFERENCES hb_cajero ( id_cajero );

ALTER TABLE hb_pedido
    ADD CONSTRAINT hb_pedido_hb_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES hb_cliente ( id_cliente );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             31
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
-- ERRORS                                   8
-- WARNINGS                                 0
