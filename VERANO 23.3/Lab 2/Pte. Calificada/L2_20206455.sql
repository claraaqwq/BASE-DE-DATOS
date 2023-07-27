-- ALEX CALERO REVILLA - 20206455

-- PREGUNTA 1
SELECT TO_CHAR(p.fecha_pedido, 'dd/mm/yyyy') "FECHA DE PEDIDO",
       c.apellidos||', '||c.nombres CLIENTE, pos.nombre POSTRE,
       s.nombre SABOR, pps.numero_bolas VECES
FROM he_pedido p, he_cliente c, he_pedido_postre pp, he_postre pos,
     he_pedido_postre_sabor pps, he_sabor s
WHERE p.id_cliente = c.id_cliente AND p.id_pedido = pp.id_pedido AND
      pp.id_postre = pos.id_postre AND pp.id_pedido_postre = pps.id_pedido_postre
      AND pps.id_sabor = s.id_sabor AND pps.numero_bolas > 3
ORDER BY 5 DESC;

-- PREGUNTA 2
SELECT TO_CHAR(o.fecha_hora_registro, 'dd/mm/yyyy')"FECHA DE REGISTRO",
       (SELECT nombre FROM he_sabor WHERE o.id_sabor = he_sabor.id_sabor) SABOR,
       o.cantidad "NÚMERO DE LOTES",
       o.fecha_hora_term_real - o.fecha_hora_registro "DURACIÓN DE PEDIDO"
FROM he_orden_produccion o
WHERE o.estado = 'T' AND o.fecha_hora_term_real - o.fecha_hora_registro > 3
ORDER BY 4 DESC, 3 DESC;

-- PREGUNTA 3
SELECT s.nombre SABOR, COUNT(*) "NRO. DE POSTRES",
       SUM(p.numero_bolas) "NRO. DE BOLAS DE HELADO"
FROM he_sabor s, he_pedido_postre_sabor p, he_pedido_postre pp, he_pedido ped
WHERE s.id_sabor = p.id_sabor AND p.id_pedido_postre = pp.id_pedido_postre AND
      pp.id_pedido = ped.id_pedido AND ped.fecha_pedido BETWEEN
      TO_DATE('01/01/23', 'dd/mm/yy') AND TO_DATE('31/01/23', 'dd/mm/yy')
GROUP BY s.nombre
HAVING COUNT(*) > 3
ORDER BY 2 DESC;

-- PREGUNTA 4
SELECT p.nombre POSTRE, p.precio "PRECIO DE VENTA", COUNT(*) "NRO. DE PEDIDOS"
FROM he_postre p, he_pedido_postre pp, he_pedido ped
WHERE p.id_postre = pp.id_postre AND ped.id_pedido = pp.id_pedido AND
      ped.fecha_pedido BETWEEN TO_DATE('22/01/23', 'dd/mm/yy') AND
      TO_DATE('29/01/23', 'dd/mm/yy')
GROUP BY p.nombre, p.precio
HAVING COUNT(*) >= 2
ORDER BY 3 DESC, 2 DESC;

-- PREGUNTA 5
SELECT c.apellidos||', '||c.nombres CLIENTE, SUM(p.precio) "GASTO TOTAL"
FROM he_cliente c, he_pedido p
WHERE c.id_cliente = p.id_cliente AND TO_CHAR(p.fecha_pedido, 'MM') = '01'
GROUP BY c.apellidos||', '||c.nombres
ORDER BY 2 DESC;
