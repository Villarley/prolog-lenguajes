% interprete: tokens a intencion (patrones + palabras clave)

interpretar(Tokens, intencion(salir)) :-
    palabra_salir(Tokens), !.

interpretar(Tokens, intencion(aprender_sinonimo, A, B)) :-
    patron_aprender_sinonimo(Tokens, A, B), !.

interpretar(Tokens, intencion(aprender_es_un, X, Y)) :-
    patron_aprender_es_un(Tokens, X, Y), !.

interpretar(Tokens, intencion(aprender_relacion, X, R, Y)) :-
    patron_aprender_relacion(Tokens, X, R, Y), !.

interpretar(Tokens, intencion(aprender_concepto, Clave, Texto)) :-
    patron_aprender_concepto(Tokens, Clave, Texto), !.

interpretar(Tokens, intencion(saludo)) :-
    palabra_saludo(Tokens), !.

interpretar(Tokens, intencion(agradecer)) :-
    member(gracias, Tokens), !.

interpretar(Tokens, intencion(consultar_relacion, Sujeto, Relacion)) :-
    patron_consultar_relacion(Tokens, Sujeto, Relacion), !.

interpretar(Tokens, intencion(consultar_relacion_entre, X, Y)) :-
    patron_consultar_relacion_entre(Tokens, X, Y), !.

interpretar(Tokens, intencion(listar_relaciones, Sujeto)) :-
    patron_listar_relaciones(Tokens, Sujeto), !.

interpretar(Tokens, intencion(consultar, Termino)) :-
    patron_consultar(Tokens, Termino), !.

interpretar(Tokens, intencion(consultar, Termino)) :-
    patron_consultar_por_clave(Tokens, Termino), !.

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

patron_aprender_relacion([aprender, que, X, R, Y], X, R, Y) :-
    atom(X), atom(R), atom(Y),
    R \== es, R \== un, R \== sinonimo.
patron_aprender_relacion(Tokens, X, R, Y) :-
    member(aprender, Tokens),
    Tokens = [_, _, X, R, Y],
    atom(X), atom(R), atom(Y),
    R \== es, R \== un.

patron_aprender_concepto([aprender, que, Clave, es | Definicion], Clave, Texto) :-
    atom(Clave),
    Definicion \== [],
    \+ patron_aprender_es_un([aprender, que, Clave, es | Definicion], _, _),
    \+ patron_aprender_sinonimo([aprender, que, Clave, es | Definicion], _, _),
    \+ patron_aprender_relacion([aprender, que, Clave, es | Definicion], _, _, _),
    unir_tokens(Definicion, TextoAtomo),
    atom_string(Texto, TextoAtomo).
patron_aprender_concepto([aprender, que, Clave], Clave, '').
patron_aprender_concepto([aprender, Clave | _], Clave, '') :-
    atom(Clave), Clave \== que.

verbo_relacion(utiliza).
verbo_relacion(usa).
verbo_relacion(requiere).
verbo_relacion(depende_de).
verbo_relacion(implementa).
verbo_relacion(procesa).
verbo_relacion(analiza).
verbo_relacion(controla).
verbo_relacion(regula).
verbo_relacion(almacena_en).
verbo_relacion(mejora).
verbo_relacion(especializa_en).
verbo_relacion(popular_en).
verbo_relacion(es_mascota_de).
verbo_relacion(es_enemigo_de).

patron_consultar_relacion(Tokens, Sujeto, Relacion) :-
    append([que, Relacion, Sujeto], _, Tokens),
    verbo_relacion(Relacion).

patron_consultar_relacion_entre(Tokens, X, Y) :-
    append([que, relacion, tiene, X, con, Y], _, Tokens).

patron_listar_relaciones(Tokens, Sujeto) :-
    append([relaciones, de, Sujeto], _, Tokens).
patron_listar_relaciones(Tokens, Sujeto) :-
    append([que, relaciones, tiene, Sujeto], _, Tokens).

patron_consultar(Tokens, Termino) :-
    append([que, es, Termino], _, Tokens),
    atom(Termino), Termino \== un, !.
patron_consultar(Tokens, Termino) :-
    append([que, es, un, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([_, que, es, Termino], _, Tokens),
    atom(Termino), Termino \== un, !.
patron_consultar(Tokens, Termino) :-
    append([_, que, es, un, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([define, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([definir, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([definicion, de, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([explique, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([explica, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([describe, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([para, que, sirve, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([que, significa, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([cuentame, sobre, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([hablame, de, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([dime, sobre, Termino], _, Tokens), !.
patron_consultar(Tokens, Termino) :-
    append([informacion, sobre, Termino], _, Tokens), !.

% variaciones con palabras clave cuando el orden no coincide
patron_consultar_por_clave(Tokens, Termino) :-
    tokens_clave(Tokens, Claves),
    tokens_indican_consulta(Tokens),
    \+ member(aprender, Tokens),
    seleccionar_termino_consulta(Claves, Termino).

tokens_indican_consulta(Tokens) :-
    member(T, Tokens),
    indicador_consulta(T).

indicador_consulta(es).
indicador_consulta(define).
indicador_consulta(definir).
indicador_consulta(definicion).
indicador_consulta(explique).
indicador_consulta(explica).
indicador_consulta(describe).
indicador_consulta(significa).
indicador_consulta(sirve).
indicador_consulta(sobre).
indicador_consulta(cuentame).
indicador_consulta(hablame).
indicador_consulta(dime).
indicador_consulta(informacion).

seleccionar_termino_consulta(Claves, Termino) :-
    include(es_candidato_termino, Claves, Candidatos),
    Candidatos = [Termino|_].

es_candidato_termino(T) :-
    atom(T),
    \+ indicador_consulta(T),
    \+ verbo_relacion(T).

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
