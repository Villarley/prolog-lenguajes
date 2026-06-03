% tests plunit chatbot
% swipl -g run_tests tests/test_chatbot.pl

:- set_prolog_flag(encoding, utf8).

:- prolog_load_context(file, TestFile),
   file_directory_name(TestFile, TestDir),
   directory_file_path(TestDir, '../src/kb/kb_core.pl', KbCore),
   directory_file_path(TestDir, '../src/kb/kb_santiago.pl', KbSantiago),
   directory_file_path(TestDir, '../src/kb/kb_integrante2.pl', Kb2),
   directory_file_path(TestDir, '../src/kb/kb_integrante3.pl', Kb3),
   directory_file_path(TestDir, '../src/sinonimos.pl', Sinonimos),
   directory_file_path(TestDir, '../src/nlp.pl', Nlp),
   directory_file_path(TestDir, '../src/interprete.pl', Interprete),
   directory_file_path(TestDir, '../src/inferencia.pl', Inferencia),
   directory_file_path(TestDir, '../src/aprendizaje.pl', Aprendizaje),
   directory_file_path(TestDir, '../src/respuestas.pl', Respuestas),
   consult(KbCore),
   consult(KbSantiago),
   consult(Kb2),
   consult(Kb3),
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

test(es_categoria_transitivo) :-
    es_categoria(prolog, lenguaje_programacion), !.

test(propiedad_de_herencia_perro) :-
    propiedad_de(perro, vida), !.

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

test(interprete_aprender_es_un) :-
    interpretar([aprender, que, un, gato, es, un, animal],
                intencion(aprender_es_un, gato, animal)).

:- end_tests(-).
