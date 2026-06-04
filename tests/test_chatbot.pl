% tests plunit chatbot
% swipl -g "run_tests, halt." -t halt tests/test_chatbot.pl

:- set_prolog_flag(encoding, utf8).

:- prolog_load_context(file, TestFile),
   file_directory_name(TestFile, TestDir),
   directory_file_path(TestDir, '../src/kb/kb_core.pl', KbCore),
   directory_file_path(TestDir, '../src/kb/kb_santiago.pl', KbSantiago),
   directory_file_path(TestDir, '../src/kb/kb_randy.pl', KbRandy),
   directory_file_path(TestDir, '../src/kb/kb_fabian.pl', KbFabian),
   directory_file_path(TestDir, '../src/sinonimos.pl', Sinonimos),
   directory_file_path(TestDir, '../src/nlp.pl', Nlp),
   directory_file_path(TestDir, '../src/interprete.pl', Interprete),
   directory_file_path(TestDir, '../src/inferencia.pl', Inferencia),
   directory_file_path(TestDir, '../src/aprendizaje.pl', Aprendizaje),
   directory_file_path(TestDir, '../src/respuestas.pl', Respuestas),
   consult(KbCore),
   consult(KbSantiago),
   consult(KbRandy),
   consult(KbFabian),
   consult(Sinonimos),
   consult(Nlp),
   consult(Interprete),
   consult(Inferencia),
   consult(Aprendizaje),
   consult(Respuestas).

:- begin_tests(-).

test(forma_canonica_sinonimo_directo) :-
    forma_canonica(pl, Canonico),
    Canonico = lenguaje_logico.

test(forma_canonica_sinonimo_inverso) :-
    forma_canonica(lenguaje_logico, Canonico),
    Canonico = lenguaje_logico.

test(son_equivalentes) :-
    son_equivalentes(pl, lenguaje_logico).

test(concepto_por_sinonimo_ia) :-
    concepto_de_termino(inteligencia_artificial, ia, _).

test(es_categoria_transitivo) :-
    es_categoria(prolog, lenguaje_programacion), !.

test(propiedad_de_herencia_perro) :-
    propiedad_de(perro, vida), !.

test(propiedad_de_sinonimo_felino) :-
    propiedad_de(felino, pelo), !.

test(propiedad_de_directo) :-
    propiedad_de(lenguaje_logico, backtracking), !.

test(aprender_concepto_y_recuperar) :-
    retractall(concepto(test_concepto, _)),
    assertz(concepto(test_concepto, 'Concepto de prueba para plunit')),
    concepto(test_concepto, 'Concepto de prueba para plunit'),
    retractall(concepto(test_concepto, _)).

test(normalizar_quita_tildes_y_signos) :-
    normalizar_entrada('¿Qué es Prolog?', Tokens),
    member(prolog, Tokens),
    \+ member('¿', Tokens).

test(normalizar_minusculas) :-
    normalizar_entrada('HOLA MUNDO', Tokens),
    Tokens = [hola, mundo].

test(palabras_clave_sin_stopwords) :-
    palabras_clave('que es el prolog', Keywords),
    member(prolog, Keywords),
    \+ member(el, Keywords),
    \+ member(que, Keywords).

test(interprete_consultar) :-
    interpretar([que, es, prolog], intencion(consultar, prolog)).

test(interprete_consultar_variacion) :-
    interpretar([explique, prolog], intencion(consultar, prolog)).

test(interprete_consultar_por_clave) :-
    interpretar([dime, que, es, el, prolog], intencion(consultar, prolog)).

test(interprete_consultar_ml_sinonimo) :-
    interpretar([que, es, ml], intencion(consultar, ml)).

test(interprete_aprender_es_un) :-
    interpretar([aprender, que, un, gato, es, un, animal],
                intencion(aprender_es_un, gato, animal)).

test(interprete_aprender_relacion) :-
    interpretar([aprender, que, ia, utiliza, red_neuronal],
                intencion(aprender_relacion, ia, utiliza, red_neuronal)).

test(interprete_consultar_relacion) :-
    interpretar([que, utiliza, ia],
                intencion(consultar_relacion, ia, utiliza)).

test(explicar_inferencia_perro_vida) :-
    explicar_inferencia(perro, vida, Explicacion),
    sub_atom(Explicacion, _, _, _, 'vida'),
    !.

test(relacion_desde_ia) :-
    relacion_desde(ia, utiliza, red_neuronal), !.

test(responder_relacion_verbo) :-
    responder_relacion_verbo(ia, utiliza).

:- end_tests(-).
