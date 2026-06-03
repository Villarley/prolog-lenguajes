%% kb_santiago.pl
%% Base de conocimiento de Santiago — tema: programación, lógica y Prolog.
%% Hechos de muestra (~12-15). Completar hasta 50 para la entrega.

:- multifile concepto/2, es_un/2, tiene/2, sinonimo/2, relacion/3.

concepto(prolog, 'Lenguaje de programación lógica basado en hechos y reglas').
concepto(recursividad, 'Técnica donde un predicado se define en términos de sí mismo').
concepto(backtracking, 'Mecanismo de Prolog para retroceder y buscar soluciones alternativas').
concepto(hecho, 'Afirmación atómica en la base de conocimiento de Prolog').
concepto(regla, 'Cláusula con cabeza y cuerpo que define relaciones derivadas').

es_un(prolog, lenguaje_logico).
es_un(lenguaje_logico, lenguaje_programacion).
es_un(lenguaje_programacion, herramienta_computacion).

tiene(lenguaje_programacion, sintaxis).
tiene(lenguaje_logico, backtracking).
tiene(lenguaje_logico, unificacion).
tiene(herramienta_computacion, compilador).

sinonimo(pl, programacion_logica).
sinonimo(programacion_logica, lenguaje_logico).

relacion(prolog, usa, backtracking).
relacion(prolog, implementa, recursividad).
relacion(regla, depende_de, hecho).
