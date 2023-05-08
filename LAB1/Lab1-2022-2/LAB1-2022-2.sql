/*Parte 1*/
/*
Como renombrar una columna:
after table tabla
rename column nombreactual
to nuevonombre;
*/
--A
after table sp_insumo
rename column unidad_divisora
to id_unidad;

--consulta para mostrar información (nombre columnas y datos)
select * from sp_insumo;
--B
create table sp_dimension(
    id_dimension char(1 byte) primary key,
    denominacion varchar2 (40 byte)
);
--C
create table sp_unidad_divisoria (
    id_unidad varchar2(5 byte) primary key,
    nombre varchar2 (50 byte),
    id_dimension char (1 byte)
);

after tabla sp_unidad_divisoria
add constraint fk_unidiv_dimen
foreign key (id_dimension)
referencer sp_dimension (id_dimension);
--D
after table sp_insumo --donde kiero crear FK
add constraint fk_insumo_uniddiv
foreign key (id_unidad)
references sp_unidad_divisoria(id_unidad);

--Pregunta 2
--A
after table sp_producto
rename column tipo
to id_tipo;
--para saber si lo cambie bien
select * from sp_producto;
--B
create table sp_tipo_producto(
    id_tipo number primary key,
    nombre varchar2(100 byte)
);
--C
after table sp_producto
add constraint fk_prod_tipo
foreign key (id_tipo)
references sp_tipo_producto(id_tipo);

--Pregunta 3
after table sp_compra_insumo
rename to sp_detalle_compra;
select * from sp_detalle_compra;

after table sp_compra_producto
rename to sp_detalle_producto;
select * from sp_detalle_producto;

--Pregunta 4
after table sp_insumo
modify estado char (1 byte);

after table sp_detalle_compra
modify cantidad numero (6,2);

