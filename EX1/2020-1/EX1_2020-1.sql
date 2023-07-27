--Resolución del Examen Parcial 2020-1

-------------------------------------------------------------------------------------------
--Pregunta 1: Muestre los 2 movimientos de proveedores mas grandes registrados en el kardex
-- en los últimos 90 días       1.5
-------------------------------------------------------------------------------------------
SELECT * FROM EX1_PROVEEDOR; -- CODPROVEEDOR + NOMPROVEEDOR 
SELECT * FROM EX1_KARDEX; -- CODMOVIMIENTO + FECHA + CANTIDAD

SELECT *
FROM (SELECT P.CODPROVEEDOR, P.NOMPROVEEDOR, K.CODMOVIMIENTO, K.FECHA, K.CANTIDAD
      FROM EX1_PROVEEDOR P, EX1_KARDEX K
      WHERE p.codproveedor = k.codproveedor
      AND K.FECHA BETWEEN TO_DATE('14/05/2020','DD/MM/YYYY')-90 AND TO_DATE('14/05/2020','DD/MM/YYYY')
      ORDER BY 5 DESC)
WHERE ROWNUM <3;

--PARA SACAR LOS MAYORES EN CANTIDAD
SELECT P.CODPROVEEDOR, P.NOMPROVEEDOR, K.CODMOVIMIENTO, K.FECHA, K.CANTIDAD
FROM EX1_PROVEEDOR P, EX1_KARDEX K
WHERE p.codproveedor = k.codproveedor
ORDER BY 5 DESC;

------------------------------------------------------------------------
-- P.2 MUESTRE LAS OPERACIONES DEL KARDEX Y SU RESPECTIVO PROVEEDOR   1.0
------------------------------------------------------------------------
SELECT * FROM EX1_PROVEEDOR; -- CODPROVEEDOR + NOMPROVEEDOR 
SELECT * FROM EX1_KARDEX; -- CODMOVIMIENTO + CANTIDAD + TIPOPERACION
--LAS DE TIPO DE OPERACION DE INGRESO DEBEN SER POSITIVAS
SELECT P.CODPROVEEDOR, P.NOMPROVEEDOR, K.CODMOVIMIENTO, K.CANTIDAD AS CANTIDAD
FROM EX1_PROVEEDOR P, EX1_KARDEX K 
WHERE p.codproveedor = k.codproveedor
AND K.TIPOPERACION LIKE 'I%';
--LAS DE TIPO DE OPERACION DE SALIDA DEBEN SER NEGATIVAS
SELECT P.CODPROVEEDOR, P.NOMPROVEEDOR, K.CODMOVIMIENTO,-1*K.CANTIDAD AS CANTIDAD
FROM EX1_PROVEEDOR P, EX1_KARDEX K 
WHERE p.codproveedor = k.codproveedor
AND K.TIPOPERACION LIKE 'S%';

--AHORA UNIMOS LAS 2 TABLAS
SELECT P.CODPROVEEDOR, P.NOMPROVEEDOR, K.CODMOVIMIENTO,-1*K.CANTIDAD AS CANTIDAD
FROM EX1_PROVEEDOR P, EX1_KARDEX K 
WHERE p.codproveedor = k.codproveedor
AND K.TIPOPERACION LIKE 'S%'
UNION ALL
SELECT P.CODPROVEEDOR, P.NOMPROVEEDOR, K.CODMOVIMIENTO, K.CANTIDAD AS CANTIDAD
FROM EX1_PROVEEDOR P, EX1_KARDEX K 
WHERE p.codproveedor = k.codproveedor
AND K.TIPOPERACION LIKE 'I%'
AND ROWNUM <4;

--------------------------------------------------------------------------------------------------
-- P.3 Muestre las recetas activas donde alguno de sus componentes ha sido vendido por 
-- un proveedor, el reporte debe mostrar el proveedor y componente, además de la receta y version
-- ordenado por codigo del componente
--------------------------------------------------------------------------------------------------
SELECT * FROM EX1_PROVEEDOR; -- CODPROVEEDOR + NOMPROVEEDOR 
SELECT * FROM EX1_KARDEX; -- CODPRODUCTO
SELECT * FROM EX1_PRODUCTO; -- CODPRODUCTO + NOMPRODUCTO
SELECT * FROM EX1_RECETA; -- CODPRODUCTO + VERSION 
SELECT * FROM EX1_DETALLE_RECETA; -- CODPRODUCTO + CODCOMPONENTE + VERSION

SELECT PR.CODPROVEEDOR , PR.NOMPROVEEDOR , R.CODPRODUCTO, R.VERSION, D.CODCOMPONENTE, P.NOMPRODUCTO
FROM EX1_PROVEEDOR PR, EX1_KARDEX K, EX1_PRODUCTO P, EX1_RECETA R, EX1_DETALLE_RECETA D
WHERE pr.codproveedor = k.codproveedor AND k.codproducto = d.CODCOMPONENTE
AND r.version = D.version AND R.CODPRODUCTO = D.CODPRODUCTO
AND p.codproducto = k.codproducto
AND R.ESTADO = 'A'
AND K.TIPOPERACION LIKE 'I%'
GROUP BY PR.CODPROVEEDOR , PR.NOMPROVEEDOR , R.CODPRODUCTO, R.VERSION, D.CODCOMPONENTE, P.NOMPRODUCTO --USO GROUP BY PARA JUNTAR LOS REPETIDOS
ORDER BY D.CODCOMPONENTE ;

----------------------------------------------------------------------------------
-- P.4 MUESTRE LOS PRODUCTOS SEGÚN LA UNIDAD DE MEDIDA QUE TIENEN MAYOR STOCK EN 
-- CADA ALMACEN, EL REPORTE DEBE MOSTRAR EL ALMACEN, CODIGO Y NOMBRE DEL PRODUCTO
-- la unidad y la cantidad.
----------------------------------------------------------------------------------
SELECT * FROM EX1_ALMACEN;-- CODALMACEN
SELECT * FROM EX1_PRODUCTO; -- CODPRODUCTO + NOMPRODUCTO + UNIDAD 
SELECT * FROM EX1_STOCK; -- CODPRODUCTO + CODALMACEN + CANTIDAD

--PRIMERO: agrupados por el almacén al que pertenecen y la unidad de medida que tienen.
SELECT A.CODALMACEN, P.UNIDAD, MAX(S.CANTIDAD) AS CANTIDAD
FROM EX1_ALMACEN A, EX1_PRODUCTO P, EX1_STOCK S
WHERE s.codalmacen = a.codalmacen AND s.codproducto = p.codproducto
GROUP BY A.CODALMACEN, P.UNIDAD
ORDER BY A.CODALMACEN, P.UNIDAD;
--CASO QUE TOME TODOS LOS ALMACENES CON MISMA UNIDAD, YO APLICO EL ANTERIOR PARA SACAR EL MAX VALOR POR UNIDAD
SELECT A.CODALMACEN, P.UNIDAD, S.CANTIDAD
FROM EX1_ALMACEN A, EX1_PRODUCTO P, EX1_STOCK S
WHERE s.codalmacen = a.codalmacen AND s.codproducto = p.codproducto
GROUP BY A.CODALMACEN, P.UNIDAD, S.CANTIDAD
ORDER BY A.CODALMACEN, P.UNIDAD;

SELECT S.CODALMACEN, P.CODPRODUCTO, P.NOMPRODUCTO, P.UNIDAD, M.MAXIMO AS CANTIDAD
FROM EX1_PRODUCTO P, EX1_STOCK S,(SELECT A.CODALMACEN, P.UNIDAD, MAX(S.CANTIDAD) AS MAXIMO
                                     FROM EX1_ALMACEN A, EX1_PRODUCTO P, EX1_STOCK S
                                     WHERE s.codalmacen = a.codalmacen AND s.codproducto = p.codproducto
                                     GROUP BY A.CODALMACEN, P.UNIDAD
                                     ORDER BY A.CODALMACEN, P.UNIDAD) M
WHERE s.codproducto = p.codproducto
AND M.CODALMACEN = S.CODALMACEN AND S.CANTIDAD = M.MAXIMO;

---------------------------------------------------------------------------------------
-- P.5 Muestre todos los productos intermedios que tiene el sistema, y sus respectivas
-- componentes de su receta    2.5
-- ordenados por el producto intermedio Y SOLO CONSIDERAR RECETAS ACTIVAS
---------------------------------------------------------------------------------------
SELECT * FROM EX1_PRODUCTO; -- NOMPRODUCTO(COMPONENTES) + UNIDAD 
SELECT * FROM EX1_DETALLE_RECETA; --CODCOMPONENTE + CODPRODUCTO + CANTIDAD + UNIDAD
SELECT * FROM EX1_RECETA; -- CODPRODUCTO + ESTADO
SELECT P.NOMPRODUCTO, C.NOMPRODUCTO AS COMPONENTE, D.CANTIDAD, D.UNIDAD
FROM EX1_PRODUCTO P, EX1_PRODUCTO C,EX1_DETALLE_RECETA D, EX1_RECETA R
WHERE r.version = d.version AND C.CODPRODUCTO = D.CODCOMPONENTE  --COMPONENTE ES HARNA,AZUCAR,ETC
AND r.codproducto = p.codproducto AND r.codproducto = d.codPRODUCTO --PRODUCTO QUE ES PARTE DE UNA RECETA, COMPONENTE
AND p.codproducto = d.codproducto AND R.ESTADO = 'A'
-- SI EL CODPRODUCTO ES IGUAL A UN CODCOMPONENTE, SIGNIFICA QUE ESTE EN REALIDAD ES UN COMPONENTE
AND D.CODPRODUCTO IN (SELECT CODCOMPONENTE
                      FROM EX1_DETALLE_RECETA)
ORDER BY 1,2;

----------------------------------------------------------------------------------------
-- P.6 desarrollar un reporte que muestre que productos no deben
-- considerarse, en dicho almacén. Debe presentar el código y nombre del producto, así 
-- como la cantidad almacenada
----------------------------------------------------------------------------------------
-- NECESARIO SABER LO SIGUIENTE:
--a los productos que tienen recetas y a su vez pertenecen a otras recetas se les conoce como PRODUCTOS INTERMEDIOS 
--los productos que no tienen receta se les llama MATERIA PRIMA.

--CREO UNA VISTA DE LOS PRODUCTOS INTERMEDIOS, PARA DESPÚES SOLO COMPARAR LOS QUE SON DIFERENTES Y ESOS SERÁN LOS MATERIA PRIMA
CREATE VIEW V_INTERMEDIOS
AS
        SELECT P.CODPRODUCTO,C.CODPRODUCTO AS COMPONENTE,CANTIDAD,C.UNIDAD
        FROM EX1_DETALLE_RECETA DR, EX1_PRODUCTO P,EX1_PRODUCTO C,EX1_RECETA R
        WHERE DR.CODPRODUCTO = P.CODPRODUCTO -- EL PRODUCTO
        AND DR.CODCOMPONENTE = C.CODPRODUCTO -- EL COMPONENTE
        AND R.CODPRODUCTO = DR.CODPRODUCTO
        AND DR.VERSION = R.VERSION
        AND R.ESTADO = 'A' -- SEAN ACTIVOS
-- SI EL CODPRODUCTO ES IGUAL A UN CODCOMPONENTE, SIGNIFICA QUE ESTE EN REALIDAD ES UN COMPONENTE
        AND DR.CODPRODUCTO  IN ( SELECT CODCOMPONENTE 
                                        FROM EX1_DETALLE_RECETA);
                                        
SELECT * FROM V_INTERMEDIOS; --LA CREO COMO OTRA TABLA A USAR -> NOMPRODUCTO + COMPONENTE + CANTIDAD + UNIDAD

SELECT P.CODPRODUCTO, P.NOMPRODUCTO,CANTIDAD
FROM EX1_STOCK S,EX1_PRODUCTO P
WHERE S.CODALMACEN LIKE '2%'
AND S.CODPRODUCTO NOT  IN (SELECT CODPRODUCTO FROM V_INTERMEDIOS)
AND  S.CODPRODUCTO = P.CODPRODUCTO;

----------------------------------------------------------------------------------------
-- P.7   OBTENGA UN REPORTE DE SALDO DE PRODUCTOS
-- DE LAS OPERACIONES DEL MES DE MARZO DEL 2020    2.5
----------------------------------------------------------------------------------------
SELECT ADD_MONTHS(TO_DATE('14/05/2020','DD/MM/YYYY')+10,-3)
FROM DUAL;

CREATE VIEW V_MOVIMIENTOS
AS
SELECT CODPRODUCTO,SUM(CANTIDAD) CANTIDAD
FROM EX1_KARDEX K
WHERE TO_CHAR(FECHA,'MM/YYYY') = TO_CHAR(ADD_MONTHS(TO_DATE('14/05/2020','DD/MM/YYYY'),-3),'MM/YYYY')
AND K.TIPOPERACION LIKE 'I%'
GROUP BY CODPRODUCTO
UNION ALL
SELECT CODPRODUCTO,-1*SUM(CANTIDAD) CANTIDAD
FROM EX1_KARDEX K
WHERE TO_CHAR(FECHA,'MM/YYYY') = TO_CHAR(ADD_MONTHS(TO_DATE('14/05/2020','DD/MM/YYYY'),-3),'MM/YYYY')
AND K.TIPOPERACION LIKE 'S%'
GROUP BY CODPRODUCTO;

SELECT * FROM V_MOVIMIENTOS;

SELECT P.CODPRODUCTO,P.NOMPRODUCTO,SUM(V.CANTIDAD) SALDO
FROM PRODUCTO P, V_MOVIMIENTOS V
WHERE P.CODPRODUCTO = V.CODPRODUCTO
GROUP BY P.CODPRODUCTO,P.NOMPRODUCTO
HAVING SUM(V.CANTIDAD)>0
ORDER BY CODPRODUCTO;


select b.codproducto, b.nomproducto, SUM((case when a.tipoperacion like 'I%' then 1 
              when a.tipoperacion like 'S%' then -1 end)*a.cantidad) as SALDO
from ex1_kardex a, ex1_producto b
where b.codproducto = a.codproducto
and to_char(a.fecha,'mm/yy') = to_char(ADD_MONTHS(to_date('06/20','mm/yy'),-3),'mm/yy')
group by b.codproducto, b.nomproducto
having SUM((case when a.tipoperacion like 'I%' then 1 
              when a.tipoperacion like 'S%' then -1 end)*a.cantidad)>0
order by b.codproducto;

--h
--ACTUALZIAR E INSERTAR
select * 
from ex1_almacen a, ex1_stock b 
where a.codalmacen = b.codalmacen;

select b.codproducto, b.nomproducto,a.cantidad
from ex1_stock a, ex1_producto b
where a.codalmacen like '2%'
and a.codproducto NOT in (select codproducto from MVIEW_INTERMEDIOS)
and a.codproducto = b.codproducto;
update 
