--EX2 2021.2
--PREGUNTA 1
set serveroutput on;
ALTER SESSION set NLS_TERRITORY = 'AMERICA';
/
---------------------------------------------------------------------------------------------
--a) Crear función que devuelva un indicador ('1' o '0') para determinar si un medico de una 
--especialidad determinada tiene una cita para una fecha indicada
---------------------------------------------------------------------------------------------
/
SELECT * FROM E2CITA; --MEDICO,ESPECIALIDAD,(AÑO-MES-DIA),FECHADATENCION,INDICAASISTENCIA,HORAINICIO
/
SELECT INDICAASISTENCIA
FROM E2CITA
WHERE EXTRACT(DAY FROM FECHADATENCION) = '20'
AND EXTRACT(MONTH FROM FECHADATENCION) = '01'
AND EXTRACT(YEAR FROM FECHADATENCION) = '2021'
AND ESPECIALIDAD = '04' AND MEDICO = '00000003'
AND HORAINICIO <= '1340' AND HORAFIN >= '1340' ;
/
CREATE OR REPLACE FUNCTION FS_VerificarExisteCita(F_COD_MED char,F_ESPE char,F_AÑO char,
    F_MES char, F_DIA char,F_HORA char)
RETURN CHAR --va a retornar 1 o 0
IS
    INDICADOR char;
BEGIN
    SELECT INDICAASISTENCIA INTO INDICADOR
    FROM E2CITA
    WHERE EXTRACT(DAY FROM FECHADATENCION) = F_DIA
    AND EXTRACT(MONTH FROM FECHADATENCION) = F_MES
    AND EXTRACT(YEAR FROM FECHADATENCION) = F_AÑO
    AND ESPECIALIDAD = F_ESPE AND MEDICO = F_COD_MED
    AND HORAINICIO <= F_HORA AND HORAFIN >= F_HORA ;
    RETURN INDICADOR;
END;
/
SELECT FS_VerificarExisteCita('00000003','04','2021','01','20','1340')
FROM DUAL;
/
------------------------------------------------------------------------------------------
--b) Crear un trigger que al cancelar la fecha de atencion de un medico 
--(usar E2FECHADATENCION) marque todas sus citas posibles de ese dia como citas a 
--reprogramarse
------------------------------------------------------------------------------------------
SELECT * FROM E2FECHADATENCION; --INDICACANCELADO, MEDICO, FECHADATENCION
SELECT * FROM E2CITA;--MEDICO,FECHADATENCION,INDICAREPRO = 1
/
CREATE OR REPLACE TRIGGER TR_REPROGRAMAR_CITA
AFTER UPDATE ON E2FECHADATENCION
FOR EACH ROW
DECLARE
    ID_MEDICO CHAR(8);
BEGIN
    --saco el id del medico que posee esa misma fecha
    SELECT DISTINCT(C.MEDICO) INTO ID_MEDICO
    FROM E2CITA C
    WHERE C.FECHADATENCION = :NEW.FECHADATENCION;

    UPDATE E2CITA
    SET INDICAREPROG = '1'
    WHERE MEDICO = ID_MEDICO
    AND FECHADATENCION = :NEW.FECHADATENCION;
    dbms_output.put_line('Se actualizaron todas las filas.');
END;
/
UPDATE E2FECHADATENCION
SET INDICACANCELADO = '1'
WHERE TO_CHAR(FECHADATENCION,'DD/MM/YYYY') = '06/01/2021';
/
------------------------------------------------------------------------------------------
--c) Crear un trigger que controle la edicion de la hora de inicio y de fin de las citas
--verificando si es posible hacerlo en base a las horas de inicio y de fin de atencion
--del medico, guardadas en E2DIADATENCION
--Resumen: realizar un before update, para primero verificar si puedo modificar las horas
--de e2cita,valido su modificacion por la tabla E2DIADAENCION, si se puede se actualiza
--y si no se manda RAISE_APPLICATION_ERROR
------------------------------------------------------------------------------------------
SELECT * FROM E2DIADATENCION;--HORAINICIO, HORAFIN
SELECT * FROM E2CITA;--HORAINICIO, HORAFIN
/
CREATE OR REPLACE TRIGGER TR_ACTUALIZAR_HORAS
BEFORE UPDATE ON E2CITA
FOR EACH ROW
DECLARE
    TR_VERIFICAR NUMBER;
BEGIN
    SELECT COUNT(*) INTO TR_VERIFICAR
    FROM E2DIADATENCION
    WHERE MEDICO = :NEW.MEDICO
    AND HORAINICIO <= :NEW.HORAINICIO
    AND HORAFIN >= :NEW.HORAFIN;
    
    IF(TR_VERIFICAR > 0 ) THEN
        dbms_output.put_line('Si se pueden cambiar las horas.');
    ELSE
        RAISE_APPLICATION_ERROR(-20000,'No está permitido durante esos rangos');
    END IF;
    
END;
/
UPDATE E2CITA
SET HORAINICIO = HORAINICIO+10, HORAFIN = HORAFIN +10
WHERE MEDICO = '00000003';
/
------------------------------------------------------------------------------------------
--d) Crear un trigger que al insertar unacita permita inicializar la columna COSTOCONSULTA
--dandole el valor del costo de la consulta para el medico y la especialidad
------------------------------------------------------------------------------------------
SELECT * FROM E2CITA;--COSTOCONSULTA
SELECT * FROM E2MEDICOXESPECIALIDAD;--COSTOCONSULTA, ESPECIALIDAD,MEDICO,CONSULTORIO
/
CREATE OR REPLACE TRIGGER TR_INICIALIZAR
BEFORE INSERT ON E2CITA
FOR EACH ROW
DECLARE
    TR_COSTO NUMBER;
BEGIN
    --obtener el costo de consulta para el medico y la especialidad asociada
    SELECT COSTOCONSULTA INTO TR_COSTO
    FROM E2MEDICOXESPECIALIDAD
    WHERE ESPECIALIDAD = :NEW.ESPECIALIDAD
    AND MEDICO = :NEW.MEDICO;
    
    -- Asignar el valor del costo de la consulta a la columna COSTOCONSULTA
    :NEW.COSTOCONSULTA := TR_COSTO;
    
END;
/
DECLARE
    PSEXITO CHAR;
BEGIN
    P_CREARCITA('00000003','04','00000008','2021','01','20','0200',PSEXITO);
END;
/
SELECT * FROM E2CITA
WHERE MEDICO = '00000003' 
AND ESPECIALIDAD = '04' AND FECHADATENCION = TO_DATE('20-01-2021','DD-MM-YYYY')
ORDER BY HORAFIN DESC;