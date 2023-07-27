-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2023-06-27 00:33:49 COT
--   sitio:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE hb_cajero (
    id_cajero    NUMBER NOT NULL,
    nombre       VARCHAR2(50 BYTE) NOT NULL,
    hora_ingreso CHAR(8) NOT NULL,
    hora_salida  CHAR(8) NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_cajero.id_cajero IS
    'IDENTIFICADOR DEL CAJERO';

COMMENT ON COLUMN hb_cajero.nombre IS
    'NOMBRE DEL CAJERO';

COMMENT ON COLUMN hb_cajero.hora_ingreso IS
    'Hora de ingreso del cajero';

COMMENT ON COLUMN hb_cajero.hora_salida IS
    'Hora de salida del cajero';

ALTER TABLE hb_cajero ADD CONSTRAINT hb_cajero_pk PRIMARY KEY ( id_cajero );

CREATE TABLE hb_cliente_d (
    telefono  NUMBER NOT NULL,
    nombre    VARCHAR2(50 BYTE) NOT NULL,
    direccion VARCHAR2(100 BYTE)
)
LOGGING;

COMMENT ON COLUMN hb_cliente_d.telefono IS
    'Telefono del cliente';

COMMENT ON COLUMN hb_cliente_d.nombre IS
    'NOMBRE DEL CLIENTE';

COMMENT ON COLUMN hb_cliente_d.direccion IS
    'DIRECCION DEL CLIENTE SI REALIZA UN PEDIDO PARA LLEVAR';

ALTER TABLE hb_cliente_d ADD CONSTRAINT hb_cliente_d_pk PRIMARY KEY ( telefono );

CREATE TABLE hb_comprobante (
    id_comprobante      NUMBER NOT NULL,
    hora_pago           CHAR(8) NOT NULL,
    hb_pedido_id_pedido NUMBER NOT NULL,
    tipo_comprob        CHAR(1 BYTE) NOT NULL,
    ruc                 NUMBER NOT NULL,
    op_gravadas         NUMBER NOT NULL,
    igv                 NUMBER NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_comprobante.id_comprobante IS
    'Identificador del comprobante';

COMMENT ON COLUMN hb_comprobante.hora_pago IS
    'Hora en la que se realizo el pago';

COMMENT ON COLUMN hb_comprobante.tipo_comprob IS
    '''B'': Boleta
''F'': Factura';

COMMENT ON COLUMN hb_comprobante.ruc IS
    'Ruc a usar en la factura';

ALTER TABLE hb_comprobante ADD CONSTRAINT hb_comprobante_pk PRIMARY KEY ( id_comprobante );

CREATE TABLE hb_comprobante_metodo_pagov1 (
    id_comprobante NUMBER NOT NULL,
    id_medio_pago  NUMBER NOT NULL,
    banco          VARCHAR2(60 BYTE),
    tipo_tarjeta   CHAR(1 BYTE),
    monto_pagado   NUMBER NOT NULL,
    vuelto         NUMBER,
    telefono       NUMBER
)
LOGGING;

COMMENT ON COLUMN hb_comprobante_metodo_pagov1.banco IS
    'Banco de donde se realizo el pago';

COMMENT ON COLUMN hb_comprobante_metodo_pagov1.tipo_tarjeta IS
    '''V'': Visa
''M'': Mastercard
''A'': American Express';

COMMENT ON COLUMN hb_comprobante_metodo_pagov1.monto_pagado IS
    'Monto pagado';

COMMENT ON COLUMN hb_comprobante_metodo_pagov1.vuelto IS
    'Vuelto a devolver en caso el pago se haya realizado mediante efectivo';

COMMENT ON COLUMN hb_comprobante_metodo_pagov1.telefono IS
    'Telefono de donde se realizo el pago';

ALTER TABLE hb_comprobante_metodo_pagov1 ADD CONSTRAINT hb_comprobante_metodo_pago_pk PRIMARY KEY ( id_comprobante,
                                                                                                    id_medio_pago );

CREATE TABLE hb_detalle_pedido (
    id_pedido       NUMBER NOT NULL,
    id_producto     NUMBER NOT NULL,
    cant_producto   NUMBER NOT NULL,
    precio_producto NUMBER NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_detalle_pedido.id_pedido IS
    'Identificador del pedido';

COMMENT ON COLUMN hb_detalle_pedido.id_producto IS
    'Identificador del producto';

COMMENT ON COLUMN hb_detalle_pedido.cant_producto IS
    'Cantidad del producto';

COMMENT ON COLUMN hb_detalle_pedido.precio_producto IS
    'Precio total del pedido';

ALTER TABLE hb_detalle_pedido ADD CONSTRAINT hb_detalle_pedido_pk PRIMARY KEY ( id_pedido,
                                                                                id_producto );

CREATE TABLE hb_entrega (
    id_entrega          NUMBER NOT NULL,
    hora_entrega        CHAR(8) NOT NULL,
    direccion           VARCHAR2(100 BYTE),
    hb_pedido_id_pedido NUMBER NOT NULL,
    id_motorizado       NUMBER NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_entrega.id_entrega IS
    'IDENTIFICADOR DE ENTREGA';

COMMENT ON COLUMN hb_entrega.hora_entrega IS
    'HORA DE LA ENTREGA DEL PRODUCT';

COMMENT ON COLUMN hb_entrega.direccion IS
    'DIRECCION PARA LA ENTREGA';

COMMENT ON COLUMN hb_entrega.id_motorizado IS
    'Identificador del motorizado';

ALTER TABLE hb_entrega ADD CONSTRAINT hb_entrega_pk PRIMARY KEY ( id_entrega );

CREATE TABLE hb_hamburguesa_ingrediente (
    id_producto    NUMBER NOT NULL,
    id_ingrediente NUMBER NOT NULL,
    cantidad       NUMBER NOT NULL
)
LOGGING;

ALTER TABLE hb_hamburguesa_ingrediente ADD CONSTRAINT hb_hamburguesa_ingrediente_pk PRIMARY KEY ( id_producto,
                                                                                                  id_ingrediente );

CREATE TABLE hb_ingrediente (
    id_ingrediente     NUMBER NOT NULL,
    nombre             VARCHAR2(50 BYTE) NOT NULL,
    precio_ingrediente NUMBER NOT NULL,
    unidad_medida      VARCHAR2(10 BYTE) NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_ingrediente.id_ingrediente IS
    'IDENTIFICADOR DEL INGREDIENTE';

COMMENT ON COLUMN hb_ingrediente.nombre IS
    'NOMBRE DEL INGREDIENTE';

COMMENT ON COLUMN hb_ingrediente.precio_ingrediente IS
    'PRECIO POR INGREDIENTE';

COMMENT ON COLUMN hb_ingrediente.unidad_medida IS
    'Unidad de medida';

ALTER TABLE hb_ingrediente ADD CONSTRAINT hb_ingrediente_pk PRIMARY KEY ( id_ingrediente );

CREATE TABLE hb_lote (
    id_lote           NUMBER NOT NULL,
    nombre            VARCHAR2(50 BYTE) NOT NULL,
    numero_lote       NUMBER NOT NULL,
    id_ingrediente    NUMBER NOT NULL,
    cantidad          NUMBER NOT NULL,
    fecha_vencimiento DATE NOT NULL,
    fecha_ingreso     DATE NOT NULL,
    stock_maximo      NUMBER NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_lote.id_lote IS
    'IDENTIFICADOR DEL ALMACEN';

COMMENT ON COLUMN hb_lote.nombre IS
    'NOMBRE DEL ALMACEN';

COMMENT ON COLUMN hb_lote.numero_lote IS
    'DIRECCION DEL ALMACEN';

COMMENT ON COLUMN hb_lote.cantidad IS
    'Stock del producto';

COMMENT ON COLUMN hb_lote.fecha_vencimiento IS
    'Stock minimo necesario de ingredientes';

COMMENT ON COLUMN hb_lote.fecha_ingreso IS
    'Fecha de ingreso del producto';

ALTER TABLE hb_lote ADD CONSTRAINT hb_lote_pk PRIMARY KEY ( id_lote );

CREATE TABLE hb_metodo_pago (
    id_medio_pago NUMBER NOT NULL,
    nombre        VARCHAR2(50 BYTE) NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_metodo_pago.id_medio_pago IS
    'IDENTIFICADOR DEL MEDIO DE PAGO';

COMMENT ON COLUMN hb_metodo_pago.nombre IS
    'NOMBRE DEL MEDIO DE PAGO
';

ALTER TABLE hb_metodo_pago ADD CONSTRAINT hb_metodo_pago_pk PRIMARY KEY ( id_medio_pago );

CREATE TABLE hb_pedido (
    id_pedido   NUMBER NOT NULL,
    fecha       DATE NOT NULL,
    hora_pedido CHAR(8) NOT NULL,
    id_cajero   NUMBER NOT NULL,
    id_cliente  NUMBER NOT NULL,
    alias       VARCHAR2(60 BYTE) NOT NULL,
    tipo_pedido CHAR(1 BYTE) NOT NULL,
    monto       NUMBER NOT NULL,
    estado      CHAR(1 BYTE) NOT NULL,
    descuento   NUMBER
)
LOGGING;

COMMENT ON COLUMN hb_pedido.id_pedido IS
    'Identificador del nombre del pedido';

COMMENT ON COLUMN hb_pedido.fecha IS
    'Fecha en la que se realizo el pedido';

COMMENT ON COLUMN hb_pedido.hora_pedido IS
    'Hora en la que se realizo el pedido';

COMMENT ON COLUMN hb_pedido.id_cajero IS
    'Identificador del cajero';

COMMENT ON COLUMN hb_pedido.id_cliente IS
    'Identificador del cliente';

COMMENT ON COLUMN hb_pedido.alias IS
    'Nombre del cliente';

COMMENT ON COLUMN hb_pedido.tipo_pedido IS
    '''P'': Presencial
''D'': Delivery';

COMMENT ON COLUMN hb_pedido.estado IS
    'E: entregado
P: pendiente
C: cancelado';

ALTER TABLE hb_pedido ADD CONSTRAINT hb_pedido_pk PRIMARY KEY ( id_pedido );

CREATE TABLE hb_persona (
    id_persona   NUMBER NOT NULL,
    nombre       VARCHAR2(60 BYTE) NOT NULL,
    apellidos    VARCHAR2(60 BYTE) NOT NULL,
    tipo_persona CHAR(1 BYTE) NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_persona.id_persona IS
    'Identificador de la persona';

COMMENT ON COLUMN hb_persona.nombre IS
    'Nombre de la persona';

ALTER TABLE hb_persona ADD CONSTRAINT hb_persona_pk PRIMARY KEY ( id_persona );

CREATE TABLE hb_producto (
    id_producto NUMBER NOT NULL,
    nombre      VARCHAR2(50 BYTE) NOT NULL,
    precio      NUMBER NOT NULL,
    tipo        VARCHAR2(1 BYTE) NOT NULL
)
LOGGING;

COMMENT ON COLUMN hb_producto.id_producto IS
    'IDENTIFICADOR DEL PRODUCTO';

COMMENT ON COLUMN hb_producto.nombre IS
    'NOMBRE DEL PRODUCTO';

COMMENT ON COLUMN hb_producto.precio IS
    'PRECIO DEL PRODUCTO';

ALTER TABLE hb_producto ADD CONSTRAINT hb_producto_pk PRIMARY KEY ( id_producto );

CREATE TABLE hb_producto_combo (
    id_combo    NUMBER NOT NULL,
    id_producto NUMBER NOT NULL,
    cantidad    NUMBER NOT NULL
)
LOGGING;

ALTER TABLE hb_producto_combo ADD CONSTRAINT hb_producto_combo_pk PRIMARY KEY ( id_combo,
                                                                                id_producto );

ALTER TABLE hb_lote
    ADD CONSTRAINT hb_almacen_hb_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES hb_ingrediente ( id_ingrediente )
    NOT DEFERRABLE;

ALTER TABLE hb_cajero
    ADD CONSTRAINT hb_cajero_hb_persona_fk FOREIGN KEY ( id_cajero )
        REFERENCES hb_persona ( id_persona )
    NOT DEFERRABLE;

ALTER TABLE hb_comprobante
    ADD CONSTRAINT hb_comprobante_hb_pedido_fk FOREIGN KEY ( hb_pedido_id_pedido )
        REFERENCES hb_pedido ( id_pedido )
    NOT DEFERRABLE;

ALTER TABLE hb_comprobante_metodo_pagov1
    ADD CONSTRAINT hb_comprobante_metodo_pago_fk FOREIGN KEY ( id_medio_pago )
        REFERENCES hb_metodo_pago ( id_medio_pago )
    NOT DEFERRABLE;

ALTER TABLE hb_comprobante_metodo_pagov1
    ADD CONSTRAINT hb_comprobante_pago_fk FOREIGN KEY ( id_comprobante )
        REFERENCES hb_comprobante ( id_comprobante )
    NOT DEFERRABLE;

ALTER TABLE hb_detalle_pedido
    ADD CONSTRAINT hb_detalle_pedido_fk FOREIGN KEY ( id_pedido )
        REFERENCES hb_pedido ( id_pedido )
    NOT DEFERRABLE;

ALTER TABLE hb_detalle_pedido
    ADD CONSTRAINT hb_detalle_pedido_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES hb_producto ( id_producto )
    NOT DEFERRABLE;

ALTER TABLE hb_entrega
    ADD CONSTRAINT hb_entrega_hb_pedido_fk FOREIGN KEY ( hb_pedido_id_pedido )
        REFERENCES hb_pedido ( id_pedido )
    NOT DEFERRABLE;

ALTER TABLE hb_entrega
    ADD CONSTRAINT hb_entrega_hb_persona_fk FOREIGN KEY ( id_motorizado )
        REFERENCES hb_persona ( id_persona )
    NOT DEFERRABLE;

ALTER TABLE hb_hamburguesa_ingrediente
    ADD CONSTRAINT hb_hamburguesa_ingrediente_fk FOREIGN KEY ( id_ingrediente )
        REFERENCES hb_ingrediente ( id_ingrediente )
    NOT DEFERRABLE;

ALTER TABLE hb_hamburguesa_ingrediente
    ADD CONSTRAINT hb_hamburguesa_producto_fk FOREIGN KEY ( id_producto )
        REFERENCES hb_producto ( id_producto )
    NOT DEFERRABLE;

ALTER TABLE hb_pedido
    ADD CONSTRAINT hb_pedido_cajero_fk FOREIGN KEY ( id_cajero )
        REFERENCES hb_cajero ( id_cajero )
    NOT DEFERRABLE;

ALTER TABLE hb_pedido
    ADD CONSTRAINT hb_pedido_cliente_fk FOREIGN KEY ( id_cliente )
        REFERENCES hb_cliente_d ( telefono )
    NOT DEFERRABLE;

ALTER TABLE hb_producto_combo
    ADD CONSTRAINT hb_productoxcombo1_fk FOREIGN KEY ( id_producto )
        REFERENCES hb_producto ( id_producto )
    NOT DEFERRABLE;

ALTER TABLE hb_producto_combo
    ADD CONSTRAINT hb_productoxcombo2_fk FOREIGN KEY ( id_combo )
        REFERENCES hb_producto ( id_producto )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                             0
-- ALTER TABLE                             29
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
