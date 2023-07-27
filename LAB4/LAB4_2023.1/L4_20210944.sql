--LABORATORIO 5
--2023.1
--PARTE CALIFICADA
SET SERVEROUTPUT ON
/
--------------------------------------------------------------------------------
--PREGUNTA 1: subprograma que calcule el precio final entre el paradero inicial
--y final
--------------------------------------------------------------------------------
SELECT * FROM ET_PARADERO;--ID_PARADERO,NOMBRE,ID_DISTRITO
SELECT * FROM ET_DISTRITO;
SELECT * FROM ET_MATRIZ_PAGO;--ID_PARADERO_INICIAL,ID_PARADERO_FINAL, PRECIO
SELECT * FROM ET_TICKET;
SELECT D.NOMBRE,M.ID_PARADERO_INICIAL,M.ID_PARADERO_FINAL,P1.ID_DISTRITO,P2.ID_DISTRITO
    FROM ET_DISTRITO D, ET_PARADERO P1, ET_PARADERO P2, ET_MATRIZ_PAGO M
    WHERE P1.NOMBRE = 'Museo Osma' 
    AND P2.NOMBRE = 'Canada'
    AND P1.ID_DISTRITO = D.ID_DISTRITO
    AND P1.ID_PARADERO = M.ID_PARADERO_INICIAL
    AND P2.ID_PARADERO = M.ID_PARADERO_FINAL
    ORDER BY 1;
/
CREATE OR REPLACE FUNCTION PR_OBTENER_PRECIO_FUNC(P_PARADERO1 VARCHAR2, P_PARADERO2 VARCHAR2)
RETURN NUMBER
IS
    FC_ID_DISTRITO NUMBER;
    FC_NOMBREDISTRI VARCHAR2(60);
    FC_PARADERO_IN NUMBER;
    FC_PARADERO_OUT NUMBER;
    FC_DIFERENCIA NUMBER;
    FC_PRECIO NUMBER;
BEGIN
    SELECT D.ID_DISTRITO, D.NOMBRE,M.ID_PARADERO_INICIAL,M.ID_PARADERO_FINAL,M.PRECIO 
    INTO FC_ID_DISTRITO, FC_NOMBREDISTRI, FC_PARADERO_IN, FC_PARADERO_OUT, FC_PRECIO
    FROM ET_DISTRITO D, ET_PARADERO P1, ET_PARADERO P2, ET_MATRIZ_PAGO M
    WHERE P1.NOMBRE = P_PARADERO1
    AND P2.NOMBRE = P_PARADERO2
    AND P2.ID_DISTRITO = D.ID_DISTRITO
    AND P1.ID_PARADERO = M.ID_PARADERO_INICIAL
    AND P2.ID_PARADERO = M.ID_PARADERO_FINAL
    ORDER BY 1;
    
    FC_DIFERENCIA:=FC_PARADERO_OUT-FC_PARADERO_IN;
    FC_PRECIO := FC_PRECIO + FC_DIFERENCIA;
    --ahora agrego el precio base al pasaje
    RETURN FC_PRECIO;
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existen los datos');
END;
/
SELECT PR_OBTENER_PRECIO_FUNC ('Museo Osma','Canada') as precio 
FROM DUAL;
/
--------------------------------------------------------------------------------
--PREGUNTA 2: realizar cursor que actualice los precios de la tabla ET_MATRIZ_PAGO
--------------------------------------------------------------------------------
SELECT * FROM ET_MATRIZ_PAGO;
/
CREATE OR REPLACE PROCEDURE PR_ACTUALIZAR_DATOS
IS
    --creo un cursor que recorra la tabla matriz pago
    CURSOR C_MATRIZ_PAGO IS
        SELECT ID_PARADERO_INICIAL,ID_PARADERO_FINAL,PRECIO
        FROM ET_MATRIZ_PAGO;
    --declaro otras variables
    C_NOMBRE_PARADEROIN VARCHAR2(100);
    C_NOMBRE_PARADEROOUT VARCHAR2(100);
    C_PRECIO NUMBER;
BEGIN
FOR RMATRIZ IN C_MATRIZ_PAGO
    LOOP
        --ahora tengo que encontrar los nombres de los paraderos
        SELECT P1.NOMBRE , P2.NOMBRE INTO C_NOMBRE_PARADEROIN, C_NOMBRE_PARADEROOUT
        FROM ET_PARADERO P1, ET_PARADERO P2
        WHERE P1.ID_PARADERO = RMATRIZ.ID_PARADERO_INICIAL
        AND P2.ID_PARADERO = RMATRIZ.ID_PARADERO_FINAL;
        --Ahora llamo a la funcion y realizo su update
        C_PRECIO := PR_OBTENER_PRECIO_FUNC(C_NOMBRE_PARADEROIN,C_NOMBRE_PARADEROOUT);
        IF (C_PRECIO>=0) THEN
            UPDATE ET_MATRIZ_PAGO
            SET PRECIO = C_PRECIO
            WHERE ID_PARADERO_INICIAL = RMATRIZ.ID_PARADERO_INICIAL
            AND ID_PARADERO_FINAL = RMATRIZ.ID_PARADERO_FINAL;
            dbms_output.put_line('Actualizacion de precios completada.');
            COMMIT;
        END IF;
    END LOOP;
EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No existen los datos');
END;
/
exec PR_ACTUALIZAR_DATOS();
/
--------------------------------------------------------------------------------
--PREGUNTA 3: cuando se registre un nuevo ticket, se debe actualizar el precio en la tabla
--ET_TICKET
--------------------------------------------------------------------------------
SELECT * FROM ET_TICKET;
SELECT * FROM ET_MATRIZ_PAGO;
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_PRECIO
BEFORE INSERT ON ET_TICKET
FOR EACH ROW
DECLARE
    C_PRECIO NUMBER;
BEGIN
    --saco el precio de la tabla ET_MATRIZ_PAGO
    SELECT PRECIO INTO C_PRECIO
    FROM ET_MATRIZ_PAGO
    WHERE ID_PARADERO_INICIAL = :NEW.ID_PARADERO_INICIAL
    AND ID_PARADERO_FINAL = :NEW.ID_PARADERO_FINAL;
    
    IF (:NEW.TIPO_PASAJE = 'U') THEN
        IF(C_PRECIO = 1) THEN
            C_PRECIO := 0.8;
        ELSE
            C_PRECIO := ROUND(C_PRECIO/2);
        END IF;
    END IF;
    
    dbms_output.put_line('El precio Obtenido correctamente: '||C_PRECIO);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe el precio en la MATRIZ PAGO');
END;
/
--------------------------------------------------------------------------------
--PREGUNTA 4: 
--------------------------------------------------------------------------------
SELECT * FROM ET_TURNO_PARADERO; 
SELECT * FROM ET_TICKET;
/
TO_CHAR(SYSDATE('HHMM'))
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_PASAJEROS
AFTER INSERT ON ET_TICKET
FOR EACH ROW
DECLARE
    
BEGIN
    --actualizar ET_TURNO_PARADERO
    UPDATE ET_TURNO_PARADERO
    SET PASAJEROS_SUBIDA = PASAJEROS_SUBIDA+1
    WHERE ID_PARADERO = :NEW.ID_PARADERO_INICIAL 
    AND ID_TURNO = :NEW.ID_TURNO;
	
	UPDATE ET_TURNO_PARADERO
    SET HORA_LLEGADA=TO_CHAR(sysdate, 'HHMM')
    WHERE ID_TURNO=:NEW.ID_TURNO 
	AND ID_PARADERO=:NEW.ID_PARADERO_INICIAL;
	
END;

/
--------------------------------------------------------------------------------
--PREGUNTA 5: realizar un informe final de las ganancias obtenidas en los viajes
--
--------------------------------------------------------------------------------
SELECT * FROM ET_CONDUCTOR;
SELECT * FROM ET_TURNO;
/
CREATE OR REPLACE PROCEDURE PR_INFORME_FINAL 
IS
    --creo cursor por conductor
    CURSOR C_CONDUCTOR IS
        SELECT C.ID_CONDUCTOR, C.NOMBRES, C.APELLIDO_PATERNO, C.APELLIDO_MATERNO,SUM(TI.PRECIO) SUMA
        FROM ET_CONDUCTOR, ET_TICKET TI, ET_TURNO TU
		WHERE C.ID_CONDUCTOR = TU.ID_CONDUCTOR AND TI.ID_TURNO = TU.ID_TURNO_VIAJE
        GROUP BY C.ID_CONDUCTOR, C.NOMBRES;
    C_NOMBRE VARCHAR2(100);
BEGIN
FOR RCONDUCTOR IN C_CONDUCTOR
    LOOP
        --primero junto el nombre
        C_NOMBRE := (RCONDUCTOR.NOMBRES||' '||RCONDUCTOR.APELLIDO_PATERNO||' '||RCONDUCTOR.APELLIDO_PATERNO);
        --imprimo los datos
        dbms_output.put_line('Conductor ID: '||RCONDUCTOR.ID_CONDUCTOR);
        dbms_output.put_line('Nombre: '||C_NOMBRE);
        dbms_output.put_line('Ganancias Totales: '||RCONDUCTOR.SUMA);
        dbms_output.put_line('--------------------------------------------------');
    END LOOP;
END;
/
EXEC PR_INFORME_FINAL();