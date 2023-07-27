create or replace PROCEDURE p_CrearCita(
psMedico E2CITA.medico%TYPE,
psEspecialidad E2CITA.especialidad%TYPE,
psAsociado E2CITA.asociado%TYPE,
psAno CHAR,
psMes CHAR,
psDia CHAR,
psDuracion CHAR,
psExito OUT CHAR
) IS
nAtiende NUMBER;
nHayCita NUMBER;
nCicloAtencion NUMBER;
sHoraInicio CHAR(4);
sHoraFin CHAR(4);
sMaxHoraFin CHAR(4);
sHoraFinCita CHAR(4);
BEGIN

-- se determina si el medico atiende ese dia
SELECT COUNT(*)
INTO nAtiende
FROM E2FECHADATENCION a
WHERE a.medico = psMedico  AND
a.especialidad = psEspecialidad AND
a.fechadatencion = TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY');

IF nAtiende>0 THEN

   -- se obtiene el ciclo de atencion
   SELECT cicloatencion
   INTO nCicloAtencion
   FROM E2CICLODATENCION a
   WHERE a.medico = psMedico  AND
   a.especialidad = psEspecialidad AND
   a.fechainicio <= TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY') AND
   a.fechafin >= TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY');
   
   -- se determina si ya existen citas para ese dia
   SELECT COUNT (*)
   INTO nHayCita
   FROM E2CITA a
   WHERE a.medico = psMedico  AND
	a.especialidad = psEspecialidad AND
	a.cicloatencion=nCicloAtencion AND
	a.fechadatencion = TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY');

   -- se obtiene la hora inicial y final de atencion del medico para ese dia
   SELECT horainicio, horafin
   INTO sHorainicio, sHorafin
   FROM E2DIADATENCION a
   WHERE a.medico = psMedico  AND
   a.especialidad = psEspecialidad AND
   a.cicloatencion=nCicloAtencion AND
   dia=TO_CHAR(TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY'),'D');


    IF nHayCita>0 THEN

     -- se obtiene la hora fin de la ultima cita del medico para ese dia
      SELECT MAX (HORAFIN)
	INTO sMaxHoraFin
	FROM E2CITA a
	WHERE  a.medico = psMedico  AND
	a.especialidad = psEspecialidad AND
	a.cicloatencion=nCicloAtencion AND
	a.fechadatencion = TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY');

      sHoraFinCita := TO_CHAR(TO_NUMBER(sMaxHoraFin)+TO_NUMBER(psDuracion),'FM0000');

      IF TO_NUMBER(sHoraFinCita) >  TO_NUMBER(sHoraFin) THEN
	 psExito := '0';
      ELSE
	 INSERT INTO E2CITA (MEDICO, ESPECIALIDAD, CICLOATENCION, FECHADATENCION, HORAINICIO, HORAFIN, ASOCIADO, INDICAASISTENCIA, DIAGNOSTICO, OBSERVACIONES, INDICAREPROG)
	   VALUES (psMedico, psEspecialidad, nCicloAtencion, TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY'), sMaxHoraFin,sHoraFinCita, psAsociado,'1',NULL,NULL,0);
	 psExito := '1';
      END IF;			
   ELSE
     sHoraFinCita := TO_CHAR(TO_NUMBER(sHorainicio)+TO_NUMBER(psDuracion),'FM0000');
     IF TO_NUMBER(sHoraFinCita) >  TO_NUMBER(sHoraFin) THEN
	psExito := '0';
     ELSE
	INSERT INTO  E2CITA  (MEDICO, ESPECIALIDAD, CICLOATENCION, FECHADATENCION, HORAINICIO, HORAFIN, ASOCIADO, INDICAASISTENCIA, DIAGNOSTICO, OBSERVACIONES, INDICAREPROG)
	  VALUES (psMedico, psEspecialidad, nCicloAtencion, TO_DATE( psDia || '-' || psMes || '-' || psAno, 'DD-MM-YYYY'), sHorainicio,sHoraFinCita, psAsociado,'1',NULL,NULL,0);
        psExito := '1';
     END IF;			
   END IF;

ELSE
    psExito := '0';
END IF;
 
END;
