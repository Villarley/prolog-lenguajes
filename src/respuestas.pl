% respuestas del bot

responder(String) :-
    format('Bot> ~s~n', [String]).

responder_concepto(Termino) :-
    concepto_de_termino(Termino, Clave, Texto),
    format('Bot> ~w: ~s~n', [Clave, Texto]).

% categorias, propiedades con explicacion y relaciones
responder_datos_termino(Termino) :-
    forma_canonica(Termino, Canonico),
    listar_categorias(Canonico, Categorias),
    listar_propiedades(Canonico, Propiedades),
    listar_relaciones_desde(Canonico, Relaciones),
    (   Categorias \== []
    ;   Propiedades \== []
    ;   Relaciones \== []
    ),
    (   Categorias \== [] -> mostrar_categorias(Canonico, Categorias) ; true ),
    (   Propiedades \== [] -> mostrar_propiedades_explicadas(Canonico, Propiedades) ; true ),
    (   Relaciones \== [] -> mostrar_relaciones(Canonico, Relaciones) ; true ).

responder_relacion_verbo(Sujeto, Relacion) :-
    forma_canonica(Sujeto, Canon),
    findall(Objeto, relacion_desde(Sujeto, Relacion, Objeto), Objetos),
    Objetos \== [],
    mostrar_relacion_verbo(Canon, Relacion, Objetos).

responder_relacion_entre(X, Y) :-
    listar_relaciones_entre(X, Y, Relaciones),
    forma_canonica(X, CanonX),
    forma_canonica(Y, CanonY),
    mostrar_relacion_entre(CanonX, CanonY, Relaciones).

responder_listar_relaciones(Sujeto) :-
    forma_canonica(Sujeto, Canon),
    listar_relaciones_desde(Sujeto, Relaciones),
    mostrar_relaciones(Canon, Relaciones).

mostrar_categorias(Termino, [Cat|Resto]) :-
    format('Bot> ~w es un ~w', [Termino, Cat]),
    mostrar_categorias_resto(Resto).
mostrar_categorias(_, []) :- nl.

mostrar_categorias_resto([Cat|Resto]) :-
    format(', que a su vez es un ~w', [Cat]),
    mostrar_categorias_resto(Resto).
mostrar_categorias_resto([]) :- true.

mostrar_propiedades_explicadas(Termino, [P|Resto]) :-
    explicar_inferencia(Termino, P, Explicacion),
    responder(Explicacion),
    mostrar_propiedades_explicadas(Termino, Resto).
mostrar_propiedades_explicadas(_, []).

mostrar_relacion_verbo(Sujeto, Relacion, [Objeto|Resto]) :-
    format(string(Msg), '~w ~w ~w.', [Sujeto, Relacion, Objeto]),
    responder(Msg),
    mostrar_relacion_verbo(Sujeto, Relacion, Resto).
mostrar_relacion_verbo(_, _, []).

mostrar_relacion_entre(X, Y, [R|Resto]) :-
    format(string(Msg), '~w ~w ~w.', [X, R, Y]),
    responder(Msg),
    mostrar_relacion_entre(X, Y, Resto).
mostrar_relacion_entre(_, _, []).

mostrar_relaciones(Sujeto, [par(R, O)|Resto]) :-
    format(string(Msg), '~w ~w ~w.', [Sujeto, R, O]),
    responder(Msg),
    mostrar_relaciones(Sujeto, Resto).
mostrar_relaciones(_, []).

bienvenida :-
    nl,
    responder('Bienvenido al Chatbot Inteligente (Paradigma Logico).'),
    responder('Pregunta (que es Prolog?), relaciones (que usa ia) o aprende hechos.'),
    nl.

despedida :-
    nl,
    responder('Hasta pronto. Fue un placer conversar contigo.'),
    nl.

no_entiendo :-
    responder('No tengo informacion sobre eso todavia.').

pedir_definicion(Termino) :-
    format('Bot> Cuentame, que es ~w? (escribe una definicion)~n', [Termino]).

respuesta_saludo :-
    responder('Hola! En que puedo ayudarte?').

respuesta_agradecimiento :-
    responder('De nada! Para eso estoy.').

ofrecer_ensenar :-
    responder('Ejemplos: aprender que X es ..., aprender que ia utiliza red_neuronal.').
