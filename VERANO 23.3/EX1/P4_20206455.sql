-- INCISO A
SELECT d.nombre DOCENTE, c.nombre CURSO, c.encpuntaje PUNTAJE
FROM x230_docente d, x230_curso c
WHERE d.docente = c.docente AND c.encpuntaje IS NOT NULL;

-- INCISO B
SELECT c.nombre CURSO, d.nombre DOCENTE, p.descripcion PREGUNTA,
o.descripcion OPCION, count (*) FRECUENCIA
FROM x230_curso c, x230_docente d, x230_puntajexpreguntaxcurso ppc,
x230_pregunta p, x230_opcxpreg o, x230_respuestasxcurso r
WHERE d.docente = c.docente AND ppc.curso = c.curso AND ppc.pregunta = p.pregunta
AND p.pregunta = o.pregunta AND o.opcion = r.opcion
GROUP BY c.nombre, d.nombre, p.descripcion, o.descripcion;

-- INCISO C
-- no me acuerdo profe :(
SELECT nombre DOCENTE FROM x230_docente;
