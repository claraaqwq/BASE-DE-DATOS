--RESOLUCION PREGUNTA 4 EXAMEN PARCIAL

--INCISO A)
--LISTADO DE CLIENTES CORPORATIVOS REFERENCIADOS POR OTROS
--ACTUALMENTE ESTAN ALQUILANDO 1 O + APARTAMENTOS

SELECT * FROM E1_CLIENTECORP; --CCID + CCNOMBRE + CCINDUSTRIA + REFERCCID
SELECT * FROM E1_APARTAMENTO; -- APARTNO

SELECT C.CCID, C.CCNOMBRE AS CLIENTE, C.CCINDUSTRIA AS INDUSTRIA
FROM E1_CLIENTECORP C, E1_APARTAMENTO A
WHERE A.CCID = C.REFERCCID --QUE EST� REFERENCIADO :)
GROUP BY C.CCID, C.CCNOMBRE, C.CCINDUSTRIA
HAVING COUNT(A.APARTNO)>1
ORDER BY C.CCID;

--INCISO B)
--LISTADO DE LOS INSPECTORES QUE TIENEN INSPECCIONES PROGRAMADAS DPS
-- DEL 15/05/22, INDICANDO LA CANTIDAD DE INSPECCIONES A REALIZAR POR MES
SELECT * FROM E1_INSPECTOR; -- INSNOMBRE , INSID
SELECT * FROM E1_INSPECCIONA; --IDINSPECTOR, SGTEINSP

SELECT I.INSID, I.INSNOMBRE ,TO_CHAR(IP.SGTEINSP,'MM') AS MES, COUNT(*) AS CANTIDAD
FROM E1_INSPECTOR I, E1_INSPECCIONA IP
WHERE IP.SGTEINSP > TO_DATE('15/05/22','DD/MM/YY')
AND I.INSID = IP.IDINSPECTOR
GROUP BY I.INSID, I.INSNOMBRE,TO_CHAR(IP.SGTEINSP,'MM') 
ORDER BY I.INSID, I.INSNOMBRE ,TO_CHAR(IP.SGTEINSP,'MM') , COUNT(*);

--INCISO C)
--LISTADO DEL EDIFICIO Y NUMERO DE APARTAMENTO DE TODOS LOS ALQUILADOS
--POR CLIENTE CORPORATIVO 'SPOTIS'
SELECT * FROM E1_APARTAMENTO; -- EDIFICIOID + APARTNO
SELECT * FROM E1_CLIENTECORP; -- CCNOMBRE(SPOTI5)

SELECT A.EDIFICIOID , A.APARTNO AS NRO_APARTAMENTO
FROM E1_APARTAMENTO A, E1_CLIENTECORP C
WHERE c.ccid = a.ccid
AND C.CCNOMBRE = 'SPOTI5';

--INCISO D)
--LISTADO DE TODOS LOS INTEGRANTES DEL PERSONAL DE LIMPIEZA, QUE 
--REALIZARON A ALQUILADOS POR EL CLIENTE CORPORATIVO 'BARCELONA'
--OJO: NO USAR REPETIDOS --> DISTINCT
SELECT * FROM E1_APARTAMENTO;
SELECT * FROM E1_LIMPIEZA; --PID
SELECT * FROM E1_PERSONAL; -- PID + PNOMBRE
SELECT * FROM E1_CLIENTECORP; -- CCNOMBRE(BARCELONA)

SELECT DISTINCT L.PID, P.PNOMBRE
FROM E1_APARTAMENTO A, E1_LIMPIEZA L, E1_PERSONAL P, E1_CLIENTECORP C
WHERE l.edificioid = a.edificioid AND c.ccid = a.ccid
AND l.apartno = a.apartno AND p.pid = l.pid
AND C.CCNOMBRE = 'BARCELONA';

--TERMINADO  :)