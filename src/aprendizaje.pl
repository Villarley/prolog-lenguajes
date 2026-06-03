% aprendizaje: assertz volatil

aprender_concepto(Clave, Texto) :-
    retractall(concepto(Clave, _)),
    assertz(concepto(Clave, Texto)),
    confirmar_concepto(Clave).

aprender_es_un(X, Y) :-
    (   es_un(X, Y)
    ->  confirmar_es_un_existente(X, Y)
    ;   assertz(es_un(X, Y)),
        confirmar_es_un(X, Y)
    ).

aprender_sinonimo(A, B) :-
    (   sinonimo(A, B)
    ;   sinonimo(B, A)
    )
    ->  confirmar_sinonimo_existente(A, B)
    ;   assertz(sinonimo(A, B)),
        confirmar_sinonimo(A, B).

aprender_relacion(X, R, Y) :-
    (   relacion(X, R, Y)
    ->  confirmar_relacion_existente(X, R, Y)
    ;   assertz(relacion(X, R, Y)),
        confirmar_relacion(X, R, Y)
    ).

olvidar(Clave) :-
    retractall(concepto(Clave, _)),
    confirmar_olvidar(Clave).

confirmar_concepto(Clave) :-
    format(string(Msg), 'He aprendido el concepto de ~w.', [Clave]),
    responder(Msg).

confirmar_es_un(X, Y) :-
    format(string(Msg), 'He aprendido que ~w es un ~w.', [X, Y]),
    responder(Msg).

confirmar_es_un_existente(X, Y) :-
    format(string(Msg), 'Ya sabia que ~w es un ~w.', [X, Y]),
    responder(Msg).

confirmar_sinonimo(A, B) :-
    format(string(Msg), 'He aprendido que ~w y ~w son sinonimos.', [A, B]),
    responder(Msg).

confirmar_sinonimo_existente(A, B) :-
    format(string(Msg), 'Ya sabia que ~w y ~w son sinonimos.', [A, B]),
    responder(Msg).

confirmar_relacion(X, R, Y) :-
    format(string(Msg), 'He aprendido la relacion: ~w ~w ~w.', [X, R, Y]),
    responder(Msg).

confirmar_relacion_existente(X, R, Y) :-
    format(string(Msg), 'Ya conocia la relacion: ~w ~w ~w.', [X, R, Y]),
    responder(Msg).

confirmar_olvidar(Clave) :-
    format(string(Msg), 'He olvidado lo que sabia sobre ~w.', [Clave]),
    responder(Msg).
