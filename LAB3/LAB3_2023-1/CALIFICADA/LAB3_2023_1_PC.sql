--SOLUCION LAB3 2023-1
--PARTE CALIFICADA => tristeza :(
SET SERVEROUTPUT ON
/
--------------------------------------------------------------------------------
--PREGUNTA 1: Se requiere subprograma que actualice el estado de un conductor a suspendido.
--El subprograma debe permitir indicar apellido paterno, materno y nombres. 
--No debe ser case sensitive.
--------------------------------------------------------------------------------V
SELECT * FROM ET_CONDUCTOR; --ESTADO = 'S' + NOMBRES, APELLIDO_PATERNO + APELLIDO_MATERNO
/
UPDATE ET_CONDUCTOR
SET ESTADO = 'S';
/
CREATE OR REPLACE PROCEDURE xx_SuspenderConductor(C_APELLIDO_PAT VARCHAR2,
    C_APELLIDO_MAT VARCHAR2, C_NOMBRES VARCHAR2)
IS
    C_CONTADOR NUMBER:= 0;
BEGIN
    UPDATE ET_CONDUCTOR
    SET ESTADO = 'S'
    --AHORA VALIDO QUE SEAN LOS MISMOS DATOS DEL CONDUCTOR
    WHERE UPPER(APELLIDO_PATERNO) = UPPER(C_APELLIDO_PAT)
    AND UPPER(APELLIDO_MATERNO) = UPPER(C_APELLIDO_MAT)
    AND UPPER(NOMBRES) = UPPER(C_NOMBRES);
    --LE ADJUNTO UN CONTADOR, PARA SABER SI ENCUENTRA A UNO Y SI LO ENCUENTRA LO ACTUALIZA
    C_CONTADOR:=sql%rowcount;
    --AHORA IMPRIMO LO QUE ME PIDEN
    IF C_CONTADOR != 0 THEN
        --cuando si encontró
        dbms_output.put_line('Conductor Suspendido');
    ELSE
        dbms_output.put_line('No existe el conductor indicado');
    END IF;
END;
/
--PRUEBO EL PROGRAMA:
exec xx_SuspenderConductor('VaLle','RETAMOZO','ROBERTO carlos');
exec xx_SuspenderConductor('Valverde','Alvarado','Jessica');
/
--------------------------------------------------------------------------------
--PREGUNTA 2:
--Se requiere obtener la cantidad de conductores activos para una fecha, sentido y
--rango de horas de acuerdo con sus horas de partida de sus turnos programados
--------------------------------------------------------------------------------
SELECT * FROM ET_CONDUCTOR; --ESTADO = 'A'  + ID_CONDUCTOR
SELECT * FROM ET_TURNO; --ID_CONDUCTOR + HORA_PARTIDA + FECHA + SENTIDO
--Para entender mejor: el conductor debe tener las horas mayores o iguales a las que
--te manda la funcion, para saber si estará activo en ese rango de tiempo
/
--HAGO SELECT CON LOS DATOS QUE ME PIDEN: 
SELECT COUNT(T.ID_CONDUCTOR)
FROM ET_CONDUCTOR C, ET_TURNO T
WHERE T.HORA_PARTIDA>='0900'
AND T.HORA_PARTIDA<='1130'
AND T.FECHA = to_date('01/03/2023', 'dd/mm/yyyy')
AND C.ID_CONDUCTOR = T.ID_CONDUCTOR
AND C.ESTADO = 'A'
AND SENTIDO = 'I';
/
CREATE OR REPLACE PROCEDURE xx_ObtenerConductoresActivos(C_FECHA DATE,
    C_SENTIDO CHAR, C_HORA_IN CHAR, C_HORA_OUT CHAR)
IS
 C_CANTIDAD_CONDUCTORES NUMBER;
BEGIN
    SELECT COUNT(T.ID_CONDUCTOR) INTO C_CANTIDAD_CONDUCTORES
    FROM ET_CONDUCTOR C, ET_TURNO T
    WHERE T.HORA_PARTIDA>=C_HORA_IN
    AND T.HORA_PARTIDA<= C_HORA_OUT
    AND T.FECHA = C_FECHA
    AND C.ID_CONDUCTOR = T.ID_CONDUCTOR
    AND C.ESTADO = 'A'
    AND SENTIDO = C_SENTIDO;
    dbms_output.put_line('Se cuenta con '||C_CANTIDAD_CONDUCTORES||' conductores activos en el horario consultado');
END;
/
--PRUEBO:
exec xx_ObtenerConductoresActivos(to_date('01/03/2023','dd/mm/yyyy'),'I','0900','1130');
/
--------------------------------------------------------------------------------
--PREGUNTA 3:Se requiere un subprograma que permita registrar un nuevo paradero. El
--subprograma debe alertar en caso el distrito asociado ingresado no exista en el
--sistema
--------------------------------------------------------------------------------
SELECT * FROM ET_PARADERO;--ID_PARADERO + ID_DISTRITO + TIPO
SELECT * FROM ET_DISTRITO; -- ID_DISTRITO + NOMBRE
/
SELECT P.ID_DISTRITO
FROM ET_PARADERO P, ET_DISTRITO D
WHERE UPPER(D.NOMBRE) = UPPER('miraflores');
/
CREATE OR REPLACE PROCEDURE xx_InsertaParadero(C_NOMBRE_PARADERO VARCHAR2,
    C_NOMBRE_DISTRITO VARCHAR2, C_TIPO CHAR)
IS
    C_ID_DISTRITO NUMBER;
    C_filas NUMBER := 0;
BEGIN
    SELECT D.ID_DISTRITO INTO C_ID_DISTRITO
    FROM ET_DISTRITO D
    WHERE UPPER(D.NOMBRE) = UPPER(C_NOMBRE_DISTRITO);
    --Solo si el distrito existe puedo agregar el paradero
    IF C_ID_DISTRITO IS NOT NULL THEN
        SELECT COUNT(*) INTO C_filas FROM ET_PARADERO;
        C_filas:=C_filas+1;
        INSERT INTO ET_PARADERO (ID_PARADERO,NOMBRE,ID_DISTRITO,TIPO,ESTADO)
        VALUES (C_filas,C_NOMBRE_PARADERO,C_ID_DISTRITO,C_TIPO,'A');
        dbms_output.put_line('Paradero registrado con exito');
    END IF;
EXCEPTION
    --caso no encuentre el id del distrito
    WHEN NO_DATA_FOUND THEN 
        dbms_output.put_line('El distrito '||C_NOMBRE_DISTRITO||' no existe en el sistema');
END;
/
--LO PRUEBO:
EXEC xx_InsertaParadero('Santa Luisda','Los olivos','N');
EXEC xx_InsertaParadero('Parque Kennedy','MIRAFLORES','N');
/
--------------------------------------------------------------------------------
--PREGUNTA 4: Elaborar un subprograma que permita eliminar aquellos buses 
--que no tengan turnos registrados
--------------------------------------------------------------------------------
SELECT * FROM ET_BUS; --ID_BUS + ESTADO
SELECT * FROM ET_TURNO; --ID_BUS + ID_TURNO_VIAJE
/
SELECT B.ID_BUS
FROM ET_BUS B, ET_TURNO T
WHERE B.ID_BUS = T.ID_BUS;
/
CREATE OR REPLACE PROCEDURE xx_LimpiarBuses
IS
    C_ID_BUS NUMBER;
    C_CANTIDAD NUMBER := 0;
BEGIN
    --pongo que tiene que ser igual a cero, porque esas serán las que no esten registradas
    --porque cuando si existe el id_turno_bus sale un nmr, caso salga cero es que no existe
    DELETE FROM ET_BUS B
    WHERE (SELECT COUNT(*)
           FROM ET_TURNO T
           WHERE B.ID_BUS = T.ID_BUS)=0;
    C_CANTIDAD:= sql%rowcount; --para contar cuantas veces realiza el proceso
    dbms_output.put_line(C_CANTIDAD||' eliminados');
END;
/
--PRUEBO:
EXEC xx_LimpiarBuses;
/
--------------------------------------------------------------------------------
--PREGUNTA 5:Procedimiento almacenado que actualice la hora de llegada real 
--de los turnos en función a las horas de retraso que se indiquen 
--para una fecha en un rango de horas en particular.
--------------------------------------------------------------------------------
SELECT *
FROM ET_TURNO T
WHERE T.FECHA = TO_dATE('01/03/2023','DD/MM/YYYY');
/
CREATE OR REPLACE PROCEDURE xx_ActualizarHoraLlegadaReal(P_FECHA DATE, P_HORA_IN CHAR,
    P_HORA_OUT CHAR, P_HORA_RETRASO NUMBER)
IS
    C_HORA_ATRASO CHAR(4);
BEGIN
    c_hora_atraso:='0'||P_HORA_RETRASO||'00';
    UPDATE ET_TURNO
    SET HORA_LLEGADA_REAL = HORA_LLEGADA_PROGRAMADA + C_HORA_ATRASO
    WHERE FECHA = P_FECHA
    AND HORA_PARTIDA>=P_HORA_IN AND HORA_PARTIDA<=P_HORA_OUT;
END;
/
exec xx_ActualizarHoraLlegadaReal(to_date('01/03/2023','dd/mm/yyyy'), '0630', '0730', 1);
/
SELECT * FROM ET_TURNO T
WHERE T.FECHA=TO_DATE('01/03/2023', 'dd/mm/yyyy');
/
--------------------------------------------------------------------------------
--PREGUNTA 6: subprograma que devuelva las horas trabajadas por un conductor en
--particular para un rango de tiempo. Tener en cuenta que si el turno tuvo algún retraso
--en su llegada, se coloca la hora real en HORA_LLEGADA_REAL.
--------------------------------------------------------------------------------



--------------------------------------------------------------------------------
--PREGUNTA 7:
--------------------------------------------------------------------------------
/
CREATE OR REPLACE PROCEDURE XX_CANT_PASAJEROS_Y_DISTRITO(C_CANT_SUBIDA OUT NUMBER, C_CANT_BAJADA OUT NUMBER,
    C_DISTRITO VARCHAR2, C_DIA DATE)
IS
    C_ID_DIS NUMBER;
BEGIN
    SELECT SUM(TP.PASAJEROS_SUBIDA), D.ID_DISTRITO INTO C_CANT_SUBIDA, C_ID_DIS
    FROM ET_TURNO_PARADERO TP, ET_TURNO T, ET_PARADERO P, ET_DISTRITO D
    WHERE TP.ID_TURNO = T.ID_TURNO_VIAJE
    AND TP.ID_PARADERO = P.ID_PARADERO
    AND P.ID_DISTRITO = D.ID_DISTRITO
    AND D.NOMBRE = C_DISTRITO
    AND T.FECHA = C_DIA
    GROUP BY D.ID_DISTRITO
    ORDER BY 2 DESC;
    
    SELECT SUM(TP.PASAJEROS_BAJADA), D.ID_DISTRITO INTO C_CANT_BAJADA, C_ID_DIS
    FROM ET_TURNO_PARADERO TP, ET_TURNO T, ET_PARADERO P, ET_DISTRITO D
    WHERE TP.ID_TURNO = T.ID_TURNO_VIAJE
    AND TP.ID_PARADERO = P.ID_PARADERO
    AND P.ID_DISTRITO = D.ID_DISTRITO
    AND D.NOMBRE = C_DISTRITO
    AND T.FECHA = C_DIA
    GROUP BY D.ID_DISTRITO
    ORDER BY 2 DESC;
END;
/
--PRUEBO: 
DECLARE
    C_CANT_SUBIDA NUMBER;
    C_CANT_BAJADA NUMBER;
    C_DISTRITO VARCHAR2(100);
    C_DIA DATE;
BEGIN
    C_DISTRITO := 'BARRANCO';
    C_DIA := '01/04/23';
    XX_CANT_PASAJEROS_Y_DISTRITO(C_CANT_SUBIDA, C_CANT_BAJADA,
    C_DISTRITO,C_DIA);
    --IMPRESION:
    dbms_output.put_line('En el distrito de '||C_DISTRITO||
        ' subieron '||C_CANT_SUBIDA||' y bajaron '||C_CANT_BAJADA||' en el dia '||to_char(C_DIA, 'dd-MON-YY'));
END;