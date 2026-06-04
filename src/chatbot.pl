% chatbot: bucle recursivo

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

manejar(intencion(consultar_relacion, Sujeto, Relacion), seguir) :-
    manejar_consulta_relacion(Sujeto, Relacion).

manejar(intencion(consultar_relacion_entre, X, Y), seguir) :-
    manejar_consulta_relacion_entre(X, Y).

manejar(intencion(listar_relaciones, Sujeto), seguir) :-
    manejar_listar_relaciones(Sujeto).

manejar(intencion(aprender_concepto, Clave, Texto), seguir) :-
    manejar_aprender_concepto(Clave, Texto).

manejar(intencion(aprender_sinonimo, A, B), seguir) :-
    aprender_sinonimo(A, B).

manejar(intencion(aprender_es_un, X, Y), seguir) :-
    aprender_es_un(X, Y).

manejar(intencion(aprender_relacion, X, R, Y), seguir) :-
    aprender_relacion(X, R, Y).

manejar(intencion(desconocido, _), seguir) :-
    no_entiendo,
    ofrecer_ensenar.

manejar_consulta(Termino) :-
    (   responder_concepto(Termino)
    ->  (   responder_datos_termino(Termino)
        ->  true
        ;   true
        )
    ;   (   responder_datos_termino(Termino)
        ->  true
        ;   flujo_aprendizaje(Termino)
        )
    ).

manejar_consulta_relacion(Sujeto, Relacion) :-
    (   responder_relacion_verbo(Sujeto, Relacion)
    ->  true
    ;   no_entiendo,
        ofrecer_ensenar
    ).

manejar_consulta_relacion_entre(X, Y) :-
    (   responder_relacion_entre(X, Y)
    ->  true
    ;   no_entiendo,
        ofrecer_ensenar
    ).

manejar_listar_relaciones(Sujeto) :-
    (   responder_listar_relaciones(Sujeto)
    ->  true
    ;   no_entiendo,
        ofrecer_ensenar
    ).

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
