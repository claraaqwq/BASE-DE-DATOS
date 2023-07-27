--RESOLUCION DEL EXAMEN 1 DEL CICLO 2022-1

------------------------------------------------
--PREGUNTA 2:
------------------------------------------------
--INCISO A: listado de todoslos libros(titulos) que disponen en m�s de un idioma
SELECT * FROM E1_LIBRO; --titulo + ID_LIBRO
SELECT * FROM E1_EDICION; --ID_IDIOMA + ID_LIBRO
SELECT * FROM E1_IDIOMA; --ID_IDIOMA
--PLANTEAMIENTO: CREO UN GROUP BY CON LOS LIBROS POR SU ID Y SUMO LA CANTIDAD DE IDIOMAS QUE TIENE
--HALLO LA CANTIDAD DE VECES QUE UN LIBRO SE REPITE EL IDIOMA
SELECT L.ID_LIBRO, L.TITULO, I.ID_IDIOMA, COUNT(*) AS CANTIDADxIDIOMA
FROM E1_LIBRO L, E1_EDICION E, E1_IDIOMA I
WHERE L.ID_LIBRO = E.ID_LIBRO
AND i.id_idioma = e.id_idioma
GROUP BY L.ID_LIBRO, L.TITULO, I.ID_IDIOMA
ORDER BY L.ID_LIBRO;
--SOLO SELECCIONO LOS IDIOMAS NO REPETIDOS
SELECT L.ID_LIBRO, L.TITULO, COUNT (DISTINCT I.ID_IDIOMA) AS CANT_IDIOMAS
FROM E1_LIBRO L, E1_EDICION E, E1_IDIOMA I
WHERE L.ID_LIBRO = E.ID_LIBRO
AND i.id_idioma = e.id_idioma
GROUP BY L.ID_LIBRO, L.TITULO
HAVING COUNT (DISTINCT I.ID_IDIOMA)>1
ORDER BY L.ID_LIBRO;

--INCISO B: kistado de todo los usuario que no han hecho uso de la biblioteca
SELECT * FROM E1_USUARIO; --NOMBRE + ID_USUARIO
SELECT * FROM E1_PRESTAMO; --ID_USUARIO

SELECT U.ID_USUARIO , U.NOMBRE
FROM E1_USUARIO U
WHERE u.ID_USUARIO NOT IN (SELECT ID_USUARIO
                         FROM E1_PRESTAMO);
                        

--INCISO C: listado que devuelva el numero de copias disponibles (que no esten prestadas)
--del libro cuyo ISBN es 9786124349720. Considerar prestado ->fechaback NULL
SELECT * FROM E1_PRESTAMO; --ID_USUARIO --FECHADEVUELTO
SELECT * FROM E1_COPIA; -- EDICION_ISBN + NUMCOPIA (DISPONIBLES)
SELECT * FROM E1_LIBRO; --TITULO
SELECT * FROM E1_EDICION; --ISBN
-- LAS CUALES SU FECHA DE DEVULTO SEAN DIFERENTES A NULL

--MOSTRAR LIBRO CUYO ISBN ES ++++
SELECT L.TITULO , E.ISBN, P.FECHADEVUELTO, COUNT(C.NUMCOPIA) AS NUMERO_COPIAS
FROM E1_LIBRO L, E1_EDICION E, E1_COPIA C, E1_PRESTAMO P
WHERE l.id_libro = e.id_libro AND E.ISBN = C.EDICION_ISBN AND p.numcopia = c.numcopia
AND E.ISBN = 9786124349720
AND P.FECHADEVUELTO IS NOT NULL
GROUP BY L.TITULO , E.ISBN, P.FECHADEVUELTO ;

--INCISO D: LISTADO DE LOS USUARIOS QUE ALGUNA VEZ  DEVOLVIERON TARDE UN LIBRO
SELECT * FROM E1_USUARIO; --NOMBRE + ID_USUARIO
SELECT * FROM E1_PRESTAMO; --ID_USUARIO + FECHADEVOLUCION + FECHADEVUELTO --> FECHADEVOLUCION<FECHADEVUELTO (TARDE)

SELECT DISTINCT(U.NOMBRE)
FROM E1_USUARIO U, E1_PRESTAMO P
WHERE u.id_usuario = p.id_usuario
AND TO_CHAR(P.FECHADEVOLUCION,'DD/MM/YYYY') < TO_CHAR(P.FECHADEVUELTO,'DD/MM/YYYY');
