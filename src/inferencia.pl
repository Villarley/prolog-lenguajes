% inferencia: es_un y tiene

% visitados corta ciclos de es_un
es_categoria(X, Y) :-
    es_categoria_aux(X, Y, []).

es_categoria_aux(X, Y, _) :-
    es_un(X, Y).
es_categoria_aux(X, Z, Visitados) :-
    es_un(X, Intermedio),
    \+ member(Intermedio, Visitados),
    es_categoria_aux(Intermedio, Z, [Intermedio|Visitados]).

% tiene directo o por herencia
propiedad_de(X, P) :-
    propiedad_de_aux(X, P, []).

propiedad_de_aux(X, P, _) :-
    tiene(X, P).
propiedad_de_aux(X, P, Visitados) :-
    es_un(X, Categoria),
    \+ member(Categoria, Visitados),
    propiedad_de_aux(Categoria, P, [Categoria|Visitados]).

% string explicando X tiene P
explicar_inferencia(X, P, Explicacion) :-
    (   tiene(X, P)
    ->  format(string(Explicacion),
               '~w tiene ~w directamente.', [X, P])
    ;   cadena_herencia(X, P, Cadena),
        formatear_explicacion(Cadena, Explicacion)
    ).

cadena_herencia(X, P, [paso(X, Categoria)|Resto]) :-
    es_un(X, Categoria),
    (   tiene(Categoria, P)
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
    findall(P, propiedad_de(X, P), Todas),
    sort(Todas, Propiedades).

listar_categorias(X, Categorias) :-
    findall(C, es_categoria(X, C), Todas),
    sort(Todas, Categorias).
