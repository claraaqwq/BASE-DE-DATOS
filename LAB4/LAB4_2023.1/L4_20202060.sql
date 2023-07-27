/*
    Codigo: 20202060
*/

--PREGUNTA 1
CREATE OR REPLACE FUNCTION OBTENER_PRECIO_FUNC(p_paradero_ini VARCHAR2, p_paradero_fin VARCHAR2)
RETURN NUMBER
IS
    p_distrito_ini ET_DISTRITO.ID_DISTRITO%TYPE;
    p_pos_ini NUMBER;
    p_distrito_fin ET_DISTRITO.ID_DISTRITO%TYPE;
    p_pos_fin NUMBER;
    CURSOR c1 IS SELECT ID_DISTRITO FROM ET_DISTRITO ORDER BY NOMBRE;
    p_distrito_actual ET_DISTRITO.ID_DISTRITO%TYPE;
BEGIN
    SELECT ID_DISTRITO INTO p_distrito_ini FROM ET_PARADERO WHERE NOMBRE = p_paradero_ini;

    SELECT ID_DISTRITO INTO p_distrito_fin FROM ET_PARADERO WHERE NOMBRE = p_paradero_fin;

    OPEN c1;
    
    LOOP
        FETCH c1 INTO p_distrito_actual;
        EXIT WHEN c1%NOTFOUND;
        IF p_distrito_actual = p_distrito_ini THEN p_pos_ini := c1%rowcount;
        END IF;
        IF p_distrito_actual = p_distrito_fin THEN p_pos_fin := c1%rowcount;
        END IF;
    END LOOP;
    CLOSE c1;
    
    RETURN 1 +ABS(p_pos_fin - p_pos_ini) / 2;
    
END;
/
EXECUTE dbms_output.put_line(to_char(OBTENER_PRECIO_FUNC('Museo Osma', 'Canada')));
/
--PREGUNTA 2
CREATE OR REPLACE PROCEDURE ACTUALIZAR_MATRIZ_PAGO
IS
    CURSOR c1 IS SELECT ID_PARADERO_INICIAL, ID_PARADERO_FINAL FROM ET_MATRIZ_PAGO;
    p_nombre_par_ini ET_PARADERO.NOMBRE%TYPE;
    p_nombre_par_fin ET_PARADERO.NOMBRE%TYPE;
    p_id_par_ini ET_PARADERO.ID_DISTRITO%TYPE;
    p_id_par_fin ET_PARADERO.ID_DISTRITO%TYPE;
BEGIN
    OPEN c1;
    LOOP
        FETCH c1 INTO p_id_par_ini, p_id_par_fin;
        EXIT WHEN c1%NOTFOUND;
        SELECT NOMBRE INTO p_nombre_par_ini FROM ET_PARADERO WHERE ID_PARADERO = p_id_par_ini;
        SELECT NOMBRE INTO p_nombre_par_fin FROM ET_PARADERO WHERE ID_PARADERO = p_id_par_fin;        
        UPDATE ET_MATRIZ_PAGO
        SET PRECIO = OBTENER_PRECIO_FUNC(p_nombre_par_ini,p_nombre_par_fin)
        WHERE ID_PARADERO_INICIAL = p_id_par_ini AND ID_PARADERO_FINAL = p_id_par_fin;
    END LOOP;
    dbms_output.put_line('Actualizacion de precios completada: '||c1%rowcount||' filas actualizadas');
    CLOSE c1;
END;
/
EXECUTE ACTUALIZAR_MATRIZ_PAGO;
/
--PREGUNTA 3
CREATE OR REPLACE TRIGGER FIJAR_PRECIO_TICKET
BEFORE INSERT ON ET_TICKET
FOR EACH ROW
DECLARE
    p_precio NUMBER;
    p_nombre_paradero_inicial ET_PARADERO.NOMBRE%TYPE;
    p_nombre_paradero_final ET_PARADERO.NOMBRE%TYPE;
BEGIN
    SELECT NOMBRE INTO p_nombre_paradero_inicial FROM ET_PARADERO WHERE ID_PARADERO = :new.id_paradero_inicial;
    SELECT NOMBRE INTO p_nombre_paradero_final FROM ET_PARADERO WHERE ID_PARADERO = :new.id_paradero_final;
    p_precio := OBTENER_PRECIO_FUNC(p_nombre_paradero_inicial, p_nombre_paradero_final);
    :new.precio := p_precio;
    dbms_output.put_line('Precio obtenido correctamente: '||p_precio);
END;
/
INSERT INTO ET_TICKET(ID_TICKET,ID_TURNO,ID_PARADERO_INICIAL,ID_PARADERO_FINAL,PRECIO,FECHA_HORA_EMISION,TIPO_PASAJE)
VALUES (99,5,1,8,584,SYSTIMESTAMP,'A');
/
--PREGUNTA 4
CREATE OR REPLACE TRIGGER ACTUALIZAR_PASAJEROS_SUBIDOS
AFTER INSERT ON ET_TICKET
FOR EACH ROW
BEGIN 
    UPDATE ET_TURNO_PARADERO
    SET PASAJEROS_SUBIDA = PASAJEROS_SUBIDA + 1
    WHERE ID_PARADERO = :new.ID_PARADERO_INICIAL AND ID_TURNO = :new.ID_TURNO;
END;
/
INSERT INTO ET_TICKET(ID_TICKET,ID_TURNO,ID_PARADERO_INICIAL,ID_PARADERO_FINAL,PRECIO,FECHA_HORA_EMISION,TIPO_PASAJE)
VALUES (4564131,110,2,8,584,SYSTIMESTAMP,'A');
/
--PREGUNTA 5
CREATE OR REPLACE PROCEDURE IMPRIMIR_REPORTE
IS
    CURSOR c1 IS 
	    SELECT C.ID_CONDUCTOR CON, C.NOMBRES NOM, SUM(TI.PRECIO) SUMA
        FROM ET_CONDUCTOR C, ET_TICKET TI, ET_TURNO TU
        WHERE C.ID_CONDUCTOR = TU.ID_CONDUCTOR AND TI.ID_TURNO = TU.ID_TURNO_VIAJE
        GROUP BY C.ID_CONDUCTOR, C.NOMBRES;
    p_registro c1%ROWTYPE;
BEGIN
    
    OPEN c1;
    LOOP
        FETCH c1 INTO p_registro;
        EXIT WHEN c1%NOTFOUND;
        dbms_output.put_line('Conductor ID: '||p_registro.CON);
        dbms_output.put_line('Nombre: '||p_registro.NOM);
        dbms_output.put_line('Ganancias totales: '||p_registro.SUMA);
        dbms_output.put_line('-----------------------------------');
    END LOOP;
    CLOSE c1;
END;
/
EXECUTE IMPRIMIR_REPORTE;