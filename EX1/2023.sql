--1)
select * from E1_CLIENTECORP; --CCID + CCNOMBRE  + CCINDUCTRIA
SELECT * FROM E1_APARTAMENTO; --APARTNO --CCID

--primero hallo los que posean mas de 1 alquilado
SELECT C.CCNOMBRE, COUNT(A.EDIFICIOID)
FROM E1_CLIENTECORP C, E1_APARTAMENTO A
WHERE A.CCID = C.CCID
GROUP BY C.CCNOMBRE;

SELECT C.CCID,C.CCNOMBRE,C.CCINDUSTRIA
FROM E1_CLIENTECORP C, E1_APARTAMENTO A
WHERE A.CCID=C.CCID
GROUP BY C.CCID, C.CCNOMBRE,C.CCINDUSTRIA
HAVING COUNT(A.EDIFICIOID)>1 
ORDER BY 1;

--2)
/*Un listado de todos los Inspectores que tienen inspecciones programadas
después del 21 de abril del 2022. No mostrar la misma información más de una vez*/
--DISTINCT // 21/04/22
SELECT * FROM E1_INSPECTOR; -- INSID , INSNOMBRE
SELECT * FROM E1_INSPECCIONA; --SGTEINSP > FECHA

SELECT DISTINCT I.INSID, I.INSNOMBRE
FROM E1_INSPECTOR I, E1_INSPECCIONA INC
WHERE INC.SGTEINSP > TO_DATE('21/04/22','DD/MM/YY') 
AND i.insid = INC.IDINSPECTOR
ORDER BY 1;

--3)
/*Un listado del edificio y número de apartamento de todos los
apartamentos alquilados por la empresa ‘SPOTI5’*/

SELECT * FROM E1_EDIFICIO; --EDIFICIOID
SELECT * FROM E1_APARTAMENTO; -- APARTNO
select * from E1_CLIENTECORP; --CCID + CCNOMBRE(SPOTIS)  + CCINDUCTRIA

SELECT E.EDIFICIOID , A.APARTNO AS NMRAPARTAMENTO
FROM E1_EDIFICIO E, E1_APARTAMENTO A, E1_CLIENTECORP C
WHERE A.CCID = C.CCID AND e.edificioid = a.edificioid
AND C.CCNOMBRE = 'SPOTIS';

--5
/*Un listado de todos los integrantes de limpieza que han realizado
servicio de limpieza a apartamentos alquilados por la empresa ‘BARCELONA’. No
mostrar la misma información repetida. -> DISTINCT
*/

SELECT * FROM E1_LIMPIEZA; --PID
SELECT * FROM E1_PERSONAL; --PNOMBRE + PID
select * from E1_CLIENTECORP; --CCID + CCNOMBRE(BARCELONA)  + CCINDUCTRIA
SELECT * FROM E1_APARTAMENTO;
SELECT DISTINCT L.PID , P.PNOMBRE
FROM E1_LIMPIEZA L, E1_PERSONAL P, E1_CLIENTECORP C, E1_APARTAMENTO A
WHERE p.pid = l.pid AND l.apartno = a.apartno
AND c.ccid = a.ccid AND l.edificioid = a.edificioid
AND C.CCID = C.REFERCCID
AND C.CCNOMBRE = 'BARCELONA';



