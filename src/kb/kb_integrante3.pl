%% kb_integrante3.pl
%% Base de conocimiento del Integrante 3.
%% TODO: rellenar con 50 hechos del integrante (tema principal a definir).
%% Muestras de ciencia y tecnología para demostrar consultas e inferencias.

:- multifile concepto/2, es_un/2, tiene/2, sinonimo/2, relacion/3.

concepto(ia, 'Campo de la informática que simula inteligencia humana').
concepto(algoritmo, 'Secuencia finita de pasos para resolver un problema').
concepto(red_neuronal, 'Modelo computacional inspirado en neuronas biológicas').

es_un(ia, disciplina_ciencia).
es_un(algoritmo, metodo_computacion).
es_un(red_neuronal, modelo_ia).

tiene(disciplina_ciencia, investigacion).
tiene(modelo_ia, entrenamiento).

relacion(ia, utiliza, red_neuronal).
relacion(algoritmo, requiere, logica).
sinonimo(inteligencia_artificial, ia).
