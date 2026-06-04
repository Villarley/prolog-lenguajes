% kb_randy.pl
% Base del conocimiento de Randy
% Tema: Animales con categorias generales

:- multifile concepto/2, es_un/2, tiene/2, sinonimo/2, relacion/3.

% Conceptos
concepto(animal, 'Ser vivo que se mueve y se alimenta de otros seres').
concepto(mamifero, 'Animal con pelo y que amamanta a sus crías').
concepto(ave, 'Animal con plumas, pico y alas').
concepto(pez, 'Animal acuático con escamas y aletas').
concepto(reptil, 'Animal terrestre de sangre fría con escamas').
concepto(anfibio, 'Animal que vive en agua y tierra').
concepto(insecto, 'Animal pequeño que suele tener exoesqueleto').
concepto(carnivoro, 'Animal que come carne').
concepto(herbivoro, 'Animal que come plantas').
concepto(omnivoro, 'Animal que come de todo').
concepto(mascota, 'Animal que convive con humanos como compañía').

% Mamíferos
es_un(perro, mamifero).
es_un(gato, mamifero).
es_un(vaca, mamifero).
es_un(caballo, mamifero).
es_un(elefante, mamifero).
es_un(delfin, mamifero).
es_un(leon, mamifero).
es_un(oso, mamifero).

% Aves
es_un(aguila, ave).
es_un(pinguino, ave).
es_un(canario, ave).
es_un(paloma, ave).

% Peces
es_un(tiburon, pez).
es_un(salmon, pez).
es_un(atun, pez).

% Reptiles
es_un(cocodrilo, reptil).
es_un(serpiente, reptil).
es_un(tortuga, reptil).

% Anfibios
es_un(rana, anfibio).
es_un(sapo, anfibio).

% Insectos
es_un(abeja, insecto).
es_un(mariposa, insecto).
es_un(mosca, insecto).

% Clasificación general
es_un(mamifero, animal).
es_un(ave, animal).
es_un(pez, animal).
es_un(reptil, animal).
es_un(anfibio, animal).
es_un(insecto, animal).

% Clasificacion alimenticia
es_un(perro, omnivoro).      
es_un(gato, carnivoro).
es_un(vaca, herbivoro).
es_un(caballo, herbivoro).
es_un(elefante, herbivoro).
es_un(leon, carnivoro).
es_un(oso, omnivoro).
es_un(aguila, carnivoro).
es_un(tiburon, carnivoro).

% Mascotas
es_un(perro, mascota).
es_un(gato, mascota).
es_un(canario, mascota).

% caracteristicas
tiene(mamifero, pelo).
tiene(mamifero, glandulas_mamarias).
tiene(ave, plumas).
tiene(ave, alas).
tiene(pez, escamas).
tiene(pez, aletas).
tiene(reptil, escamas).
tiene(reptil, sangre_fria).
tiene(anfibio, piel_humeda).

% Relaciones
relacion(perro, es_mascota_de, humano).
relacion(gato, es_mascota_de, humano).
relacion(perro, es_enemigo_de, gato).

% sinonimos
sinonimo(felino, gato).
sinonimo(pajaro, ave).
sinonimo(serpiente, culebra).

