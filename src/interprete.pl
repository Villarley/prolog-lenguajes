% interprete: tokens a intencion

% salir antes que consultar
% listas fijas evitan backtracking infinito

interpretar(Tokens, intencion(salir)) :-
    palabra_salir(Tokens), !.

interpretar(Tokens, intencion(aprender_sinonimo, A, B)) :-
    patron_aprender_sinonimo(Tokens, A, B), !.

interpretar(Tokens, intencion(aprender_es_un, X, Y)) :-
    patron_aprender_es_un(Tokens, X, Y), !.

interpretar(Tokens, intencion(aprender_concepto, Clave, Texto)) :-
    patron_aprender_concepto(Tokens, Clave, Texto), !.

interpretar(Tokens, intencion(saludo)) :-
    palabra_saludo(Tokens), !.

interpretar(Tokens, intencion(agradecer)) :-
    member(gracias, Tokens), !.

interpretar(Tokens, intencion(consultar, Termino)) :-
    patron_consultar(Tokens, Termino), !.

interpretar(Tokens, intencion(desconocido, Tokens)).

palabra_salir(Tokens) :-
    member(P, Tokens),
    member(P, [salir, adios, chao, exit, bye, cerrar]).

palabra_saludo(Tokens) :-
    member(P, Tokens),
    member(P, [hola, buenas, saludos, buenos, dias, tardes, noches]).

patron_aprender_sinonimo([aprender, que, A, significa, B], A, B).
patron_aprender_sinonimo([aprender, que, A, es, sinonimo, de, B], A, B).
patron_aprender_sinonimo(Tokens, A, B) :-
    Tokens = [A, es, sinonimo, de, B],
    \+ member(aprender, Tokens).
patron_aprender_sinonimo([A, significa, B], A, B).

patron_aprender_es_un([aprender, que, un, X, es, un, Y], X, Y).
patron_aprender_es_un([aprender, que, X, es, un, Y], X, Y).
patron_aprender_es_un([aprender, que, X, es, Y], X, Y) :-
    atom(X), atom(Y),
    X \== un, Y \== un,
    Y \== sinonimo.
patron_aprender_es_un(Tokens, X, Y) :-
    member(aprender, Tokens),
    Tokens = [_, _, X, es, un, Y].

patron_aprender_concepto([aprender, que, Clave, es | Definicion], Clave, Texto) :-
    atom(Clave),
    Definicion \== [],
    \+ patron_aprender_es_un([aprender, que, Clave, es | Definicion], _, _),
    \+ patron_aprender_sinonimo([aprender, que, Clave, es | Definicion], _, _),
    unir_tokens(Definicion, TextoAtomo),
    atom_string(Texto, TextoAtomo).
patron_aprender_concepto([aprender, que, Clave], Clave, '').
patron_aprender_concepto([aprender, Clave | _], Clave, '') :-
    atom(Clave), Clave \== que.

% append ok: termino al final
patron_consultar(Tokens, Termino) :-
    append([que, es, Termino], _, Tokens),
    atom(Termino), Termino \== un, !.
patron_consultar(Tokens, Termino) :-
    append([que, es, un, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([define, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([definir, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([explique, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([explica, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([para, que, sirve, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([que, significa, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([cuentame, sobre, Termino], _, Tokens), !.

unir_tokens([], '').
unir_tokens([Uno], Uno) :- atom(Uno).
unir_tokens([Primero|Resto], Texto) :-
    unir_tokens(Resto, RestoTexto),
    atom_string(P, Primero),
    (   RestoTexto == ''
    ->  Texto = P
    ;   atom_string(R, RestoTexto),
        string_concat(P, " ", ConEspacio),
        string_concat(ConEspacio, R, S),
        atom_string(Texto, S)
    ).
