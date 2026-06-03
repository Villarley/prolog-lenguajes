% sinonimos: clausura bidireccional

% canonico = atomo menor de la clase
% visitados evita ciclos
forma_canonica(Termino, Canonico) :-
    clausura_sinonimos(Termino, Clase, []),
    sort(Clase, Ordenados),
    Ordenados = [Canonico|_].

clausura_sinonimos(Actual, Clase, Visitados) :-
    (   member(Actual, Visitados)
    ->  Clase = []
    ;   findall(Siguiente,
               (   sinonimo(Actual, Siguiente)
               ;   sinonimo(Siguiente, Actual)
               ),
               Vecinos),
        sort(Vecinos, VecinosUnicos),
        clausura_vecinos(VecinosUnicos, RestoClase, [Actual|Visitados]),
        Clase = [Actual|RestoClase]
    ).

clausura_vecinos([], [], _).
clausura_vecinos([V|Vs], Clase, Visitados) :-
    clausura_sinonimos(V, ClaseV, Visitados),
    clausura_vecinos(Vs, ClaseVs, Visitados),
    append(ClaseV, ClaseVs, Clase).

son_equivalentes(A, B) :-
    forma_canonica(A, Canonico),
    forma_canonica(B, Canonico),
    !.

% concepto por sinonimo de la clase
concepto_de_termino(Termino, Clave, Texto) :-
    clausura_sinonimos(Termino, Clase, []),
    member(Clave, Clase),
    concepto(Clave, Texto),
    !.
