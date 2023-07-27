
CREATE TABLE ex1_almacen (
    codalmacen   NUMBER(5) NOT NULL,
    nomalmacen   VARCHAR2(40),
    estado       CHAR(1)
)
LOGGING;

ALTER TABLE ex1_almacen ADD CONSTRAINT ex1_almacen_pk PRIMARY KEY ( codalmacen );

CREATE TABLE ex1_detalle_receta (
    codproducto     NUMBER(10) NOT NULL,
    codcomponente   NUMBER(10) NOT NULL,
    version         NUMBER(5) NOT NULL,
    cantidad        NUMBER(16,2),
    unidad          CHAR(3)
)
LOGGING;

ALTER TABLE ex1_detalle_receta
    ADD CONSTRAINT ex1_detalle_receta_pk PRIMARY KEY ( codproducto,
                                                       codcomponente,
                                                       version );

CREATE TABLE ex1_kardex (
    codmovimiento   NUMBER(10) NOT NULL,
    codproducto     NUMBER(10) NOT NULL,
    codalmacen      NUMBER(5) NOT NULL,
    codproveedor    CHAR(11),
    fecha           DATE,
    tipoperacion    CHAR(3),
    cantidad        NUMBER(16,2)
)
LOGGING;

ALTER TABLE ex1_kardex
    ADD CONSTRAINT ex1_kardex_pk PRIMARY KEY ( codmovimiento,
                                               codproducto,
                                               codalmacen );

CREATE TABLE ex1_producto (
    codproducto   NUMBER(10) NOT NULL,
    nomproducto   VARCHAR2(50),
    unidad        CHAR(3),
    proporcion    NUMBER(10,3)
)
LOGGING;

ALTER TABLE ex1_producto ADD CONSTRAINT ex1_producto_pk PRIMARY KEY ( codproducto );

CREATE TABLE ex1_proveedor (
    codproveedor   CHAR(11) NOT NULL,
    nomproveedor   VARCHAR2(40),
    estado         CHAR(1)
)
LOGGING;

ALTER TABLE ex1_proveedor ADD CONSTRAINT ex1_proveedor_pk PRIMARY KEY ( codproveedor );

CREATE TABLE ex1_receta (
    codproducto   NUMBER(10) NOT NULL,
    version       NUMBER(5) NOT NULL,
    nomreceta     VARCHAR2(50),
    fecha         DATE,
    estado        CHAR(1)
)
LOGGING;

ALTER TABLE ex1_receta ADD CONSTRAINT ex1_receta_pk PRIMARY KEY ( codproducto,
                                                                  version );

CREATE TABLE ex1_stock (
    codproducto   NUMBER(10) NOT NULL,
    codalmacen    NUMBER(5) NOT NULL,
    cantidad      NUMBER(16,2)
)
LOGGING;

ALTER TABLE ex1_stock ADD CONSTRAINT ex1_stock_pk PRIMARY KEY ( codproducto,
                                                                codalmacen );

ALTER TABLE ex1_detalle_receta
    ADD CONSTRAINT ex1_detalle_receta_producto_fk FOREIGN KEY ( codcomponente )
        REFERENCES ex1_producto ( codproducto )
    NOT DEFERRABLE;

ALTER TABLE ex1_detalle_receta
    ADD CONSTRAINT ex1_detalle_receta_receta_fk FOREIGN KEY ( codproducto,
                                                              version )
        REFERENCES ex1_receta ( codproducto,
                                version )
    NOT DEFERRABLE;

ALTER TABLE ex1_kardex
    ADD CONSTRAINT ex1_kardex_ex1_proveedor_fk FOREIGN KEY ( codproveedor )
        REFERENCES ex1_proveedor ( codproveedor )
    NOT DEFERRABLE;

ALTER TABLE ex1_kardex
    ADD CONSTRAINT ex1_kardex_ex1_stock_fk FOREIGN KEY ( codproducto,
                                                         codalmacen )
        REFERENCES ex1_stock ( codproducto,
                               codalmacen )
    NOT DEFERRABLE;

ALTER TABLE ex1_receta
    ADD CONSTRAINT ex1_receta_ex1_producto_fk FOREIGN KEY ( codproducto )
        REFERENCES ex1_producto ( codproducto )
    NOT DEFERRABLE;

ALTER TABLE ex1_stock
    ADD CONSTRAINT ex1_stock_ex1_almacen_fk FOREIGN KEY ( codalmacen )
        REFERENCES ex1_almacen ( codalmacen )
    NOT DEFERRABLE;

ALTER TABLE ex1_stock
    ADD CONSTRAINT ex1_stock_ex1_producto_fk FOREIGN KEY ( codproducto )
        REFERENCES ex1_producto ( codproducto )
    NOT DEFERRABLE;

