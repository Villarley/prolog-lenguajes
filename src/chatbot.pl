% chatbot: bucle recursivo

% un turno y vuelve a conversar
% normalizar_entrada conserva que/es

iniciar :-
    bienvenida,
    conversar.

conversar :-
    mostrar_prompt,
    read_line_to_string(user_input, Linea),
    procesar_entrada(Linea).

procesar_entrada(end_of_file) :-
    !,
    manejar(intencion(salir), _).
procesar_entrada(Linea) :-
    trim_string(Linea, LineaTrim),
    (   LineaTrim == ""
    ->  Continuar = seguir
    ;   normalizar_entrada(LineaTrim, Tokens),
        interpretar(Tokens, Intencion),
        manejar(Intencion, Continuar)
    ),
    continuar_si_corresponde(Continuar).

continuar_si_corresponde(seguir) :-
    !,
    conversar.
continuar_si_corresponde(parar).

mostrar_prompt :-
    write('Tu> '),
    flush_output.

manejar(intencion(salir), parar) :-
    despedida.

manejar(intencion(saludo), seguir) :-
    respuesta_saludo.

manejar(intencion(agradecer), seguir) :-
    respuesta_agradecimiento.

manejar(intencion(consultar, Termino), seguir) :-
    manejar_consulta(Termino).

manejar(intencion(aprender_concepto, Clave, Texto), seguir) :-
    manejar_aprender_concepto(Clave, Texto).

manejar(intencion(aprender_sinonimo, A, B), seguir) :-
    aprender_sinonimo(A, B).

manejar(intencion(aprender_es_un, X, Y), seguir) :-
    aprender_es_un(X, Y).

manejar(intencion(desconocido, _), seguir) :-
    no_entiendo,
    ofrecer_ensenar.

% concepto, inferencia, sino definicion
manejar_consulta(Termino) :-
    (   responder_concepto(Termino)
    ->  true
    ;   (   responder_inferencia_parcial(Termino)
        ->  true
        ;   flujo_aprendizaje(Termino)
        )
    ).

responder_inferencia_parcial(Termino) :-
    forma_canonica(Termino, Canonico),
    listar_categorias(Canonico, Categorias),
    listar_propiedades(Canonico, Propiedades),
    (   Categorias \== []
    ;   Propiedades \== []
    ),
    (   Categorias \== [] -> mostrar_categorias(Canonico, Categorias) ; true ),
    (   Propiedades \== [] -> mostrar_propiedades(Canonico, Propiedades) ; true ).

flujo_aprendizaje(Termino) :-
    no_entiendo,
    pedir_definicion(Termino),
    leer_definicion(Definicion),
    (   Definicion == end_of_file
    ->  true
    ;   trim_string(Definicion, DefTrim),
        (   DefTrim == ""
        ->  responder('No recibi definicion.')
        ;   aprender_concepto(Termino, DefTrim)
        )
    ).

manejar_aprender_concepto(Clave, Texto) :-
    (   Texto == ''
    ->  pedir_definicion(Clave),
        leer_definicion(Definicion),
        procesar_definicion_aprendizaje(Clave, Definicion)
    ;   aprender_concepto(Clave, Texto)
    ).

procesar_definicion_aprendizaje(_, end_of_file).
procesar_definicion_aprendizaje(Clave, Definicion) :-
    trim_string(Definicion, DefTrim),
    (   DefTrim == ""
    ->  responder('No recibi definicion.')
    ;   aprender_concepto(Clave, DefTrim)
    ).

leer_definicion(Linea) :-
    write('    > '),
    flush_output,
    read_line_to_string(user_input, Linea).
