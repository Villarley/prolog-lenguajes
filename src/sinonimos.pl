% sinonimos: clausura en ambas direcciones y resolución en consultas

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

miembros_sinonimos(Termino, Miembros) :-
    clausura_sinonimos(Termino, Clase, []),
    sort(Clase, Miembros).

% hechos enlazados por cualquier miembro de la clase de sinonimos
es_un_por_sinonimo(X, Y) :-
    miembros_sinonimos(X, Miembros),
    member(M, Miembros),
    es_un(M, Y).

tiene_por_sinonimo(X, P) :-
    miembros_sinonimos(X, Miembros),
    member(M, Miembros),
    tiene(M, P).

concepto_de_termino(Termino, Clave, Texto) :-
    miembros_sinonimos(Termino, Miembros),
    member(Clave, Miembros),
    concepto(Clave, Texto),
    !.

termino_presente_en_kb(Termino) :-
    miembros_sinonimos(Termino, Miembros),
    member(M, Miembros),
    (   concepto(M, _)
    ;   es_un(M, _)
    ;   es_un(_, M)
    ;   tiene(M, _)
    ;   relacion(M, _, _)
    ;   relacion(_, _, M)
    ),
    !.
