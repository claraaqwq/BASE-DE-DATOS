-- Codigo: 20191254
-- Nombre: Daniel Martin Fiestas Tasayco
SET SERVEROUTPUT ON;
-- Pregunta 1
CREATE OR REPLACE FUNCTION obtener_precio_func(p_paradero_inicial VARCHAR2, p_paradero_final VARCHAR2)
RETURN NUMBER IS
    CURSOR c1 IS
        SELECT ID_DISTRITO, NOMBRE
        FROM ET_DISTRITO
        ORDER BY NOMBRE;
    v_paradero_inicial NUMBER;
    v_paradero_final NUMBER;
    v_distrito_inicial CHAR(6);
    v_id_distrito_inicial NUMBER;
    v_distrito_final CHAR(6);
    v_id_distrito_final NUMBER;
    v_precio NUMBER :=0;
    v_precio_distrito NUMBER :=0;
    v_contador NUMBER :=0;
BEGIN
    SELECT ID_DISTRITO, ID_PARADERO INTO v_distrito_inicial, v_paradero_inicial FROM ET_PARADERO
    WHERE UPPER(NOMBRE)=UPPER(p_paradero_inicial);
    SELECT ID_DISTRITO, ID_PARADERO INTO v_distrito_final, v_paradero_final FROM ET_PARADERO
    WHERE UPPER(NOMBRE)=UPPER(p_paradero_final);
    FOR cur_distrito IN c1
    LOOP
        v_contador:=v_contador+1;
        IF cur_distrito.id_distrito=v_distrito_inicial
        THEN v_id_distrito_inicial:=v_contador;
        END IF;
        IF cur_distrito.id_distrito=v_distrito_final
        THEN v_id_distrito_final:=v_contador;
        END IF;
    END LOOP;
    v_precio:=1+(ABS(v_id_distrito_final-v_id_distrito_inicial)/2);
    
    RETURN v_precio;
END;

SELECT obtener_precio_func('Museo Osma', 'Canada') as precio from dual;

-- Pregunta 2

CREATE OR REPLACE PROCEDURE Actualizar_Matriz_Pago
IS
    CURSOR c2 IS
        SELECT ID_PARADERO_INICIAL, ID_PARADERO_FINAL, PRECIO
        FROM ET_MATRIZ_PAGO;
    v_paradero_inicial VARCHAR2(40);
    v_paradero_final VARCHAR2(40);
    v_precio NUMBER :=0;
    v_contador NUMBER :=0;  
BEGIN
    FOR cur_matriz IN c2
    LOOP
        SELECT NOMBRE INTO v_paradero_inicial FROM ET_PARADERO
        WHERE ID_PARADERO=cur_matriz.id_paradero_inicial;
        SELECT NOMBRE INTO v_paradero_final FROM ET_PARADERO
        WHERE ID_PARADERO=cur_matriz.id_paradero_final;
        IF v_paradero_inicial IS NOT NULL AND v_paradero_final IS NOT NULL THEN
            v_contador:=v_contador+1;
            v_precio:=obtener_precio_func(v_paradero_inicial, v_paradero_final);
        
            UPDATE ET_MATRIZ_PAGO
            SET PRECIO=v_precio
            WHERE ID_PARADERO_INICIAL=cur_matriz.id_paradero_inicial
            AND ID_PARADERO_FINAL=cur_matriz.id_paradero_final;
        END IF;
    END LOOP;
    dbms_output.put_line('Actualización de precios completada. Filas actualizadas: '||v_contador);
END;
-- Para regresar
-- ROLLBACK;
EXEC Actualizar_Matriz_Pago();

-- Pregunta 3

CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_TICKET
BEFORE INSERT ON ET_TICKET
FOR EACH ROW
DECLARE
    v_precio NUMBER :=0;
BEGIN
    SELECT PRECIO INTO v_precio FROM ET_MATRIZ_PAGO
    WHERE ID_PARADERO_INICIAL=:NEW.ID_PARADERO_INICIAL AND ID_PARADERO_FINAL=:NEW.ID_PARADERO_FINAL;
    
    IF :NEW.TIPO_PASAJE='U' THEN
        v_precio:=v_precio/2;
    END IF;
    :NEW.PRECIO:=v_precio;
    dbms_output.put_line('Precio Obtenido correctamente: '||v_precio);
END;

INSERT INTO ET_TICKET (ID_TICKET, ID_TURNO, ID_PARADERO_INICIAL, ID_PARADERO_FINAL, PRECIO, FECHA_HORA_EMISION, TIPO_PASAJE)
VALUES (2, 110, 1, 5, 0, SYSDATE, 'N');

-- Pregunta 4

CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_PASAJEROS
AFTER INSERT ON ET_TICKET
FOR EACH ROW
BEGIN
   UPDATE ET_TURNO_PARADERO
   SET PASAJEROS_SUBIDA=PASAJEROS_SUBIDA+1
   WHERE ID_TURNO=:NEW.ID_TURNO AND ID_PARADERO=:NEW.ID_PARADERO_INICIAL;
   
   UPDATE ET_TURNO_PARADERO
   SET HORA_LLEGADA=TO_CHAR(sysdate, 'HHMM')
   WHERE ID_TURNO=:NEW.ID_TURNO AND ID_PARADERO=:NEW.ID_PARADERO_INICIAL;
END;

INSERT INTO ET_TICKET (ID_TICKET, ID_TURNO, ID_PARADERO_INICIAL, ID_PARADERO_FINAL, PRECIO, FECHA_HORA_EMISION, TIPO_PASAJE)
VALUES (4, 110, 1, 5, 0, SYSDATE, 'U');

-- Pregunta 5

CREATE OR REPLACE PROCEDURE REPORTE_GANANCIAS
IS
    CURSOR c3 IS
        SELECT ID_CONDUCTOR, NOMBRES, APELLIDO_PATERNO, APELLIDO_MATERNO FROM ET_CONDUCTOR
        ORDER BY ID_CONDUCTOR;
    v_nombre VARCHAR2(100);
    v_ganancias NUMBER :=0;
BEGIN
    FOR cur_conductor IN c3
    LOOP
        v_nombre:=cur_conductor.nombres||', '||cur_conductor.apellido_paterno||' '||cur_conductor.apellido_materno;
        dbms_output.put_line('Conductor ID: '||cur_conductor.id_conductor);
        dbms_output.put_line('Nombre: '||v_nombre);
        dbms_output.put_line('Ganancias Totales: '||v_ganancias);
        dbms_output.put_line(' ');
    END LOOP;
END;

exec REPORTE_GANANCIAS();
        