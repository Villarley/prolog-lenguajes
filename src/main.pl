% main: carga y arranca

:- set_prolog_flag(encoding, utf8).

cargar_todas(Dir) :-
    cargar(Dir, 'kb/kb_core.pl'),
    cargar(Dir, 'kb/kb_santiago.pl'),
    cargar(Dir, 'kb/kb_randy.pl'),
    cargar(Dir, 'kb/kb_integrante3.pl'),
    cargar(Dir, 'sinonimos.pl'),
    cargar(Dir, 'nlp.pl'),
    cargar(Dir, 'interprete.pl'),
    cargar(Dir, 'inferencia.pl'),
    cargar(Dir, 'aprendizaje.pl'),
    cargar(Dir, 'respuestas.pl'),
    cargar(Dir, 'chatbot.pl').

cargar(Dir, Archivo) :-
    directory_file_path(Dir, Archivo, Ruta),
    load_files(Ruta, [if(not_loaded)]).

:- initialization(cargar_fuentes, program).
:- initialization(main, program).

cargar_fuentes :-
    directorio_fuentes(Dir),
    cargar_todas(Dir).

% src/ via kb_core.pl
directorio_fuentes(Dir) :-
    absolute_file_name('src/kb/kb_core.pl', RutaKb,
        [ file_type(prolog), access(read), file_errors(fail)
        ]),
    file_directory_name(RutaKb, DirKb),
    file_directory_name(DirKb, Dir).

main :-
    nl,
    write('=== Chatbot Inteligente - Paradigma Logico ==='), nl,
    write('Iniciando conversacion... (escribe salir para terminar)'), nl,
    iniciar.

% consola: [src/main], main
