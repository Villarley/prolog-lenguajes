%% kb_integrante2.pl
%% Base de conocimiento del Integrante 2.
%% TODO: rellenar con 50 hechos del integrante (tema principal a definir).
%% Muestras de animales para demostrar inferencia por herencia.

:- multifile concepto/2, es_un/2, tiene/2, sinonimo/2, relacion/3.

concepto(perro, 'Animal mamífero doméstico leal al humano').
concepto(gato, 'Animal mamífero doméstico independiente').
concepto(mamifero, 'Animal vertebrado de sangre caliente con glándulas mamarias').

es_un(perro, mamifero).
es_un(gato, mamifero).
es_un(mamifero, animal).

tiene(animal, vida).
tiene(animal, metabolismo).

relacion(perro, convive_con, humano).
sinonimo(can, perro).
