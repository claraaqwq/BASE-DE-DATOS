CREATE TABLE X99_ALMACEN (
 ID_ALMACEN NUMBER NOT NULL,
 DESCRIPCION VARCHAR2(60) NULL
);
ALTER TABLE X99_ALMACEN
ADD (PRIMARY KEY (ID_ALMACEN) ) ;
CREATE TABLE X99_ARTICULO (
 ID_ARTICULO NUMBER NOT NULL,
 DESCRIPCION VARCHAR2(60) NULL,
 CODIGO VARCHAR2(10) NOT NULL,
 COSTO NUMBER(10,2) NOT NULL,
 ID_UNIDAD_MED NUMBER NOT NULL,
 ID_SUBGRUPO NUMBER NULL,
 ID_GRUPO NUMBER NULL,
 ID_PROVEEDOR NUMBER NULL
);
ALTER TABLE X99_ARTICULO
ADD (PRIMARY KEY (ID_ARTICULO) ) ;
CREATE TABLE X99_ARTICULOXALMACEN (
 ID_ARTICULO NUMBER NOT NULL,
 ID_ALMACEN NUMBER NOT NULL,
 STOCK NUMBER NULL
);
ALTER TABLE X99_ARTICULOXALMACEN
ADD (PRIMARY KEY (ID_ARTICULO, ID_ALMACEN) ) ;
CREATE TABLE X99_DETALLE_GUIA (
 ID_GUIA NUMBER NOT NULL,
 ID_ARTICULO NUMBER NOT NULL,
 ID_ALMACEN NUMBER NOT NULL,
 CANTIDAD NUMBER NOT NULL
);
ALTER TABLE X99_DETALLE_GUIA
ADD (PRIMARY KEY (ID_GUIA, ID_ARTICULO) ) ;
CREATE TABLE X99_DETALLE_TRANSACCION (
ID_TRANSACCION NUMBER NOT NULL,
ID_GUIA NUMBER NOT NULL,
ID_ARTICULO NUMBER NOT NULL,
ID_ALMACEN NUMBER NOT NULL,
CANTIDAD NUMBER NOT NULL,
ITEM NUMBER NOT NULL
);
ALTER TABLE X99_DETALLE_TRANSACCION
ADD (PRIMARY KEY (ID_TRANSACCION, ITEM));

CREATE TABLE X99_GRUPO (
 ID_GRUPO NUMBER NOT NULL,
 DESCRIPCION VARCHAR2(60) NULL
);
ALTER TABLE X99_GRUPO ADD (PRIMARY KEY (ID_GRUPO)) ;
CREATE TABLE X99_GUIA_REMISION (
 ID_GUIA NUMBER NOT NULL,
 TIPO CHAR(1) NOT NULL,
 FECHA_DOCUMENTO DATE NOT NULL,
 FECHA_REGISTRO DATE NOT NULL,
 OBSERVACION VARCHAR2(255) NULL
);
ALTER TABLE X99_GUIA_REMISION
ADD (PRIMARY KEY (ID_GUIA) ) ;
CREATE TABLE X99_PROVEEDOR (
 ID_PROVEEDOR NUMBER NOT NULL,
 RAZON_SOCIAL VARCHAR2(80) NOT NULL,
 RUC VARCHAR2(11) NOT NULL,
 DIRECCION VARCHAR2(200) NULL,
 TELEFONO VARCHAR2(20) NULL
);
ALTER TABLE X99_PROVEEDOR
ADD (PRIMARY KEY (ID_PROVEEDOR) ) ;
CREATE TABLE X99_SUBGRUPO (
 ID_SUBGRUPO NUMBER NOT NULL,
 ID_GRUPO NUMBER NOT NULL,
 DESCRIPCION VARCHAR2(60) NULL
);
ALTER TABLE X99_SUBGRUPO
ADD (PRIMARY KEY (ID_SUBGRUPO, ID_GRUPO) ) ;
CREATE TABLE X99_TRANSACCION (
 ID_TRANSACCION NUMBER NOT NULL,
 ID_GUIA NUMBER NOT NULL,
 FECHA_TRANS DATE NOT NULL,
 TIPO CHAR(1) NOT NULL
);
ALTER TABLE X99_TRANSACCION
ADD (PRIMARY KEY (ID_TRANSACCION)) ;
CREATE TABLE X99_UNIDAD_MEDIDA (
 ID_UNIDAD_MED NUMBER NOT NULL,
 DESCRIPCION VARCHAR2(60) NULL,
 DESCRIPCION_CORTA VARCHAR2(8) NULL
);
ALTER TABLE X99_UNIDAD_MEDIDA
ADD (PRIMARY KEY (ID_UNIDAD_MED) ) ;

ALTER TABLE X99_ARTICULO
ADD (FOREIGN KEY (ID_PROVEEDOR) REFERENCES X99_PROVEEDOR) ;
ALTER TABLE X99_ARTICULO
ADD (FOREIGN KEY (ID_SUBGRUPO, ID_GRUPO) REFERENCES X99_SUBGRUPO) ;
ALTER TABLE X99_ARTICULO
ADD (FOREIGN KEY (ID_UNIDAD_MED) REFERENCES X99_UNIDAD_MEDIDA);
ALTER TABLE X99_ARTICULOXALMACEN
ADD (FOREIGN KEY (ID_ALMACEN) REFERENCES X99_ALMACEN);
ALTER TABLE X99_ARTICULOXALMACEN
ADD (FOREIGN KEY (ID_ARTICULO) REFERENCES X99_ARTICULO);
ALTER TABLE X99_DETALLE_GUIA
ADD (FOREIGN KEY (ID_ARTICULO, ID_ALMACEN) REFERENCES X99_ARTICULOXALMACEN);
ALTER TABLE X99_DETALLE_GUIA
ADD (FOREIGN KEY (ID_GUIA) REFERENCES X99_GUIA_REMISION);
ALTER TABLE X99_DETALLE_TRANSACCION
ADD (FOREIGN KEY (ID_GUIA, ID_ARTICULO) REFERENCES X99_DETALLE_GUIA);
ALTER TABLE X99_DETALLE_TRANSACCION
ADD (FOREIGN KEY (ID_TRANSACCION) REFERENCES X99_TRANSACCION);
ALTER TABLE X99_SUBGRUPO ADD (FOREIGN KEY (ID_GRUPO) REFERENCES X99_GRUPO);
ALTER TABLE X99_TRANSACCION ADD (FOREIGN KEY (ID_GUIA) REFERENCES
X99_GUIA_REMISION);