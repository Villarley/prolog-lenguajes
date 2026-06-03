% respuestas del bot

responder(String) :-
    format('Bot> ~s~n', [String]).

responder_concepto(Termino) :-
    concepto_de_termino(Termino, Clave, Texto),
    format('Bot> ~w: ~s~n', [Clave, Texto]).

% fail avisa al caller sin concepto
responder_inferencia(Termino) :-
    forma_canonica(Termino, Canonico),
    (   listar_categorias(Canonico, Categorias), Categorias \== []
    ->  mostrar_categorias(Canonico, Categorias)
    ;   true
    ),
    (   listar_propiedades(Canonico, Propiedades), Propiedades \== []
    ->  mostrar_propiedades(Canonico, Propiedades),
        fail
    ;   fail
    ).

mostrar_categorias(Termino, [Cat|Resto]) :-
    format('Bot> ~w es un ~w', [Termino, Cat]),
    mostrar_categorias_resto(Resto).
mostrar_categorias(_, []) :- nl.

mostrar_categorias_resto([Cat|Resto]) :-
    format(', que a su vez es un ~w', [Cat]),
    mostrar_categorias_resto(Resto).
mostrar_categorias_resto([]) :- true.

mostrar_propiedades(Termino, [P|Resto]) :-
    format('Bot> ~w tiene la propiedad: ~w~n', [Termino, P]),
    mostrar_propiedades(Termino, Resto).
mostrar_propiedades(_, []).

bienvenida :-
    nl,
    responder('Bienvenido al Chatbot Inteligente (Paradigma Logico).'),
    responder('Puedes preguntar (que es Prolog?), aprender hechos o escribir salir.'),
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
    responder('Puedes ensenarme con frases como: aprender que X es ...').
