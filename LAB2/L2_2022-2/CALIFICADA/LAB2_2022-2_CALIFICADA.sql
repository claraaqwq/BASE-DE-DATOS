--LAB2 CALIFICADA 2022-2

--PREGUNTA 1: MOSTRAR LA CANTIDAD DE INSUMOS EMPLEADOS EN LA FAB DE CADA TIPO DE PRODUCTO (GROUP BY)
SELECT * FROM SP_PRODUCTO; 
SELECT * FROM SP_TIPO_PRODUCTO;--NOMBRE
SELECT * FROM SP_MATRIZ_INSUMO; 
SELECT * FROM SP_INSUMO; -- NOMBRE
--COMO ME PIDEN APLICAR UNA FUNCION DE CONTAR, SE QUE TRABAJAR� CON GROUP BY
SELECT TP.NOMBRE AS NOMB_TIP_PROD, I.NOMBRE AS NOMB_INSUM, COUNT(I.ID_INSUMO)
FROM SP_PRODUCTO P, SP_TIPO_PRODUCTO TP, SP_MATRIZ_INSUMO M, SP_INSUMO I
WHERE tp.id_tipo = p.id_tipo
AND p.id_producto = m.id_producto
AND m.id_insumo = i.id_insumo
GROUP BY TP.NOMBRE, I.NOMBRE
ORDER BY (TP.NOMBRE||I.NOMBRE);

--PREGUNTA 2:MOSTRAR LA CANT DE ORDENES DE COMPRA REGISTRADAS HACE 2 MESES Y LA CANT DE INSUMOS ADQUIRIDOS EN DICHAS ORDENAS
SELECT * FROM SP_INSUMO;--NOMBRE
SELECT * FROM SP_DETALLE_COMPRA;--CANTIDAD
SELECT * FROM SP_ORDEN_COMPRA; --FECHA_REGISTRO
--ME PIDEN LA SUMA DE CANT DE CDA PRODUCTO (GROUP BY)
SELECT OC.FECHA_REGISTRO, I.NOMBRE AS NOM_INSUM, SUM(DC.CANTIDAD) AS CANTIDAD
FROM SP_INSUMO I, SP_DETALLE_COMPRA DC, SP_ORDEN_COMPRA OC
WHERE OC.id_orden = dc.id_orden
AND i.id_insumo = dc.id_insumo
AND (TO_CHAR(TO_DATE('12/10/2022', 'DD/MM/YYYY'),'MM')-TO_CHAR(OC.FECHA_REGISTRO,'MM'))<2
GROUP BY OC.FECHA_REGISTRO, I.NOMBRE
ORDER BY I.NOMBRE ASC;

--PREGUNTA 3: MOSTRAR LAS ORDENES DE PRODUCCION QUE SE EMITIERON EN JULIO
SELECT * FROM SP_PRODUCTO; --NOMBRE Y PRECIO
SELECT * FROM SP_DETALLE_PRODUCTO; --ID_ORDEN
SELECT * FROM SP_ORDEN_PRODUCCION;--FECHA_REGISTRO
SELECT * FROM SP_MOTIVO; --NOMBRE

SELECT DP.ID_ORDEN AS NMR_ORDEN, OP.FECHA_REGISTRO AS FECHA_REG, P.NOMBRE, M.NOMBRE, P.PRECIO
FROM SP_PRODUCTO P, SP_DETALLE_PRODUCTO DP, SP_ORDEN_PRODUCCION OP, SP_MOTIVO M
WHERE p.id_producto = dp.id_producto
AND op.id_orden = dp.id_orden
AND OP.MOTIVO = M.ID_MOTIVO
AND TO_CHAR(OP.FECHA_REGISTRO,'MM') = '07';

--PREGUNTA 4: MOSTRAR MONTO TOTAL DE LAS ORDENES DE COMPRA, AGRUPADAS POR MM + YYYY
--EL MONTO DEBE CONSIDERAR EL IGV
SELECT * FROM SP_ORDEN_COMPRA; --FECHA_REGISTRO , MONTO TOTAL, MONTO IGV
--COMO ESTOY USANDO FUNCIONES, ES NECESARIO USAR GROUP BY
SELECT TO_CHAR(FECHA_REGISTRO,'fmMonth')||' del '||TO_CHAR(FECHA_REGISTRO,'YYYY') as MES, SUM(MONTO_TOTAL+MONTO_IGV) AS MONTO
FROM SP_ORDEN_COMPRA
GROUP BY TO_CHAR(FECHA_REGISTRO,'fmMonth')||' del '||TO_CHAR(FECHA_REGISTRO,'YYYY');

--PREGUNTA 5: EMPLEANDO SUBCONSULTAS IDENTIFICAR EL PRODUCTO QUE REQUIERE LA MAYOR CANT DE INSUMOS
SELECT * FROM SP_PRODUCTO; --NOMBRE
SELECT * FROM SP_MATRIZ_INSUMO;
SELECT * FROM SP_INSUMO; --COUNT

SELECT *
FROM (SELECT P.NOMBRE, COUNT(I.ID_INSUMO)
      FROM SP_PRODUCTO P, SP_MATRIZ_INSUMO M, SP_INSUMO I
      WHERE m.id_insumo = i.id_insumo AND p.id_producto = m.id_producto
      GROUP BY P.NOMBRE
      ORDER BY COUNT(I.ID_INSUMO) DESC)
--QUIERO QUE ME DE LA PRIMERA
WHERE ROWNUM = 1;

--SACO LOS PRODUCTOS CON SUS CANT DE INSUMOS .- ESTO SE REALIZA ANTES
SELECT P.NOMBRE, COUNT(I.ID_INSUMO)
FROM SP_PRODUCTO P, SP_MATRIZ_INSUMO M, SP_INSUMO I
WHERE m.id_insumo = i.id_insumo AND p.id_producto = m.id_producto
GROUP BY P.NOMBRE
ORDER BY COUNT(I.ID_INSUMO) DESC;

--PREGUNTA 6: MOSTRAR LAS UNIDADES EN QUE SE DEBE COMPRAR CADA INSUMO PARA EL CALZADO
SELECT * FROM SP_INSUMO;--NOMBRE
SELECT * FROM SP_UNIDAD_DIVISORIA; -- NOMBRE
SELECT * FROM SP_DIMENSION;--DENOMINACION

SELECT I.NOMBRE AS NOMBRE_INSUMO, U.NOMBRE AS DESC_UNID_DIV, D.DENOMINACION AS DESC_DIMENSION
FROM SP_INSUMO I, SP_UNIDAD_DIVISORIA U, SP_DIMENSION D
WHERE u.id_unidad = i.id_unidad AND u.id_dimension = d.id_dimension
ORDER BY D.DENOMINACION ASC;

--PREGUNTA 7: EMPLEANDO SUBCONSULTAS IDENTIFICAR EL INSUMO QUE M�S SE COMPR� EN EL ULTIMO MES PARA LA FABRICACION DE CALZADOS
SELECT * FROM SP_INSUMO; -- NOMBRE
SELECT * FROM SP_DETALLE_COMPRA; -- CANTIDAD
SELECT * FROM SP_ORDEN_COMPRA;--FECHA_REGISTRO
--PUEDO MOSTRAR TODOS LOS INSUMOS QUE SE COMPRARON EN EL ULTIMO MES
SELECT I.NOMBRE AS NOM_INSUM , D.CANTIDAD AS CANT_COMPRADA
FROM SP_INSUMO I, SP_DETALLE_COMPRA D, SP_ORDEN_COMPRA O
WHERE i.id_insumo = d.id_insumo AND o.id_orden = d.id_orden
AND TO_CHAR(O.FECHA_REGISTRO,'MM') = TO_CHAR(TO_DATE('12/09/2022', 'DD/MM/YYYY'),'MM')
ORDER BY 2 DESC;

--AHORA LO AGREGO EN LA SUBCONSULTA
SELECT *
FROM (SELECT I.NOMBRE AS NOM_INSUM , D.CANTIDAD AS CANT_COMPRADA
      FROM SP_INSUMO I, SP_DETALLE_COMPRA D, SP_ORDEN_COMPRA O
      WHERE i.id_insumo = d.id_insumo AND o.id_orden = d.id_orden
      AND TO_CHAR(O.FECHA_REGISTRO,'MM') = TO_CHAR(TO_DATE('12/09/2022', 'DD/MM/YYYY'),'MM')
      ORDER BY 2 DESC)
WHERE ROWNUM = 1;

