% inferencia: es_un, tiene y relaciones (con sinonimos)

es_categoria(X, Y) :-
    es_categoria_aux(X, Y, []).

es_categoria_aux(X, Y, _) :-
    es_un_por_sinonimo(X, Y).
es_categoria_aux(X, Z, Visitados) :-
    es_un_por_sinonimo(X, Intermedio),
    \+ member(Intermedio, Visitados),
    es_categoria_aux(Intermedio, Z, [Intermedio|Visitados]).

propiedad_de(X, P) :-
    propiedad_de_aux(X, P, []).

propiedad_de_aux(X, P, _) :-
    tiene_por_sinonimo(X, P).
propiedad_de_aux(X, P, Visitados) :-
    es_un_por_sinonimo(X, Categoria),
    \+ member(Categoria, Visitados),
    propiedad_de_aux(Categoria, P, [Categoria|Visitados]).

explicar_inferencia(X, P, Explicacion) :-
    forma_canonica(X, Canon),
    (   tiene_por_sinonimo(Canon, P)
    ->  format(string(Explicacion),
               '~w tiene ~w directamente.', [Canon, P])
    ;   cadena_herencia(Canon, P, Cadena),
        formatear_explicacion(Cadena, Explicacion)
    ).

cadena_herencia(X, P, [paso(X, Categoria)|Resto]) :-
    es_un_por_sinonimo(X, Categoria),
    (   tiene_por_sinonimo(Categoria, P)
    ->  Resto = [tiene(Categoria, P)]
    ;   cadena_herencia(Categoria, P, Resto)
    ).

formatear_explicacion(Cadena, Explicacion) :-
    cadena_a_texto(Cadena, Texto),
    atom_string(Explicacion, Texto).

cadena_a_texto([paso(X, Cat), tiene(Cat, P)], Texto) :-
    format(string(Texto),
           '~w es un ~w, y los ~w tienen ~w.',
           [X, Cat, Cat, P]).
cadena_a_texto(Cadena, Texto) :-
    length(Cadena, L), L > 2,
    Cadena = [paso(X, Cat1)|Resto],
    cadena_a_texto(Resto, RestoTexto),
    format(string(Texto),
           '~w es un ~w, y ~s', [X, Cat1, RestoTexto]).

listar_propiedades(X, Propiedades) :-
    forma_canonica(X, Canon),
    findall(P, propiedad_de(Canon, P), Todas),
    sort(Todas, Propiedades).

listar_categorias(X, Categorias) :-
    forma_canonica(X, Canon),
    findall(C, es_categoria(Canon, C), Todas),
    sort(Todas, Categorias).

relacion_desde(Sujeto, Relacion, Objeto) :-
    miembros_sinonimos(Sujeto, Miembros),
    member(M, Miembros),
    relacion(M, Relacion, Objeto).

relacion_entre(Sujeto, Objeto, Relacion) :-
    miembros_sinonimos(Sujeto, Ms),
    miembros_sinonimos(Objeto, Mo),
    member(S, Ms),
    member(O, Mo),
    relacion(S, Relacion, O).

listar_relaciones_desde(Sujeto, Trios) :-
    forma_canonica(Sujeto, Canon),
    findall(par(R, O), relacion_desde(Canon, R, O), Todas),
    sort(Todas, Trios),
    Trios \== [].

listar_relaciones_entre(Sujeto, Objeto, Relaciones) :-
    findall(R, relacion_entre(Sujeto, Objeto, R), Todas),
    sort(Todas, Relaciones),
    Relaciones \== [].
