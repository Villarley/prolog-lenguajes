% nlp: string a tokens

normalizar_entrada(StringEntrada, ListaAtomosTokens) :-
    string_lower(StringEntrada, Minusculas),
    quitar_signos_string(Minusculas, SinSignos),
    quitar_tildes_string(SinSignos, Normalizado),
    split_string(Normalizado, " ", "", Partes),
    partes_a_atomos(Partes, ListaAtomosTokens).

quitar_stopwords(Tokens, TokensFiltrados) :-
    exclude(es_stopword, Tokens, TokensFiltrados).

tokens_clave(Tokens, Keywords) :-
    quitar_stopwords(Tokens, Keywords).

palabras_clave(StringEntrada, Keywords) :-
    trim_string(StringEntrada, Limpia),
    normalizar_entrada(Limpia, Tokens),
    quitar_stopwords(Tokens, Keywords).

trim_string(String, Trimmed) :-
    string_codes(String, Codigos),
    trim_codes_izq(Codigos, SinIzq),
    trim_codes_der(SinIzq, TrimCodigos),
    string_codes(Trimmed, TrimCodigos).

trim_codes_izq([C|Resto], Trim) :-
    char_type(C, space),
    !,
    trim_codes_izq(Resto, Trim).
trim_codes_izq(Codigos, Codigos).

trim_codes_der(Codigos, Trim) :-
    reverse(Codigos, Rev),
    trim_codes_izq(Rev, RevTrim),
    reverse(RevTrim, Trim).

stopword(el).
stopword(la).
stopword(los).
stopword(las).
stopword(un).
stopword(una).
stopword(de).
stopword(que).
stopword(es).
stopword(son).
stopword(para).
stopword(con).
stopword(y).
stopword(o).
stopword(se).
stopword(en).
stopword(lo).
stopword(al).
stopword(del).
stopword(me).
stopword(te).
stopword(le).
stopword(su).
stopword(mi).
stopword(tu).
stopword(describe).
stopword(definicion).

es_stopword(Palabra) :-
    stopword(Palabra).

quitar_signos_string(StringEntrada, StringSalida) :-
    string_codes(StringEntrada, Codigos),
    filtrar_signos(Codigos, CodigosFiltrados),
    string_codes(StringSalida, CodigosFiltrados).

filtrar_signos([], []).
filtrar_signos([C|Resto], Filtrado) :-
    (   es_signo(C)
    ->  filtrar_signos(Resto, Filtrado)
    ;   filtrar_signos(Resto, RestoFiltrado),
        Filtrado = [C|RestoFiltrado]
    ).

es_signo(0'¿).
es_signo(0'¡).
es_signo(0'?).
es_signo(0'!).
es_signo(0'.).
es_signo(0',).
es_signo(0';).
es_signo(0':).
es_signo(0'").
es_signo(0'().
es_signo(0')).

% tildes y ene a ascii
quitar_tildes_string(StringEntrada, StringSalida) :-
    string_codes(StringEntrada, Codigos),
    sustituir_tildes(Codigos, CodigosSinTilde),
    string_codes(StringSalida, CodigosSinTilde).

sustituir_tildes([], []).
sustituir_tildes([C|Resto], [Nuevo|RestoNuevo]) :-
    reemplazar_tilde(C, Nuevo),
    sustituir_tildes(Resto, RestoNuevo).

reemplazar_tilde(0'á, 0'a) :- !.
reemplazar_tilde(0'é, 0'e) :- !.
reemplazar_tilde(0'í, 0'i) :- !.
reemplazar_tilde(0'ó, 0'o) :- !.
reemplazar_tilde(0'ú, 0'u) :- !.
reemplazar_tilde(0'ñ, 0'n) :- !.
reemplazar_tilde(0'Á, 0'a) :- !.
reemplazar_tilde(0'É, 0'e) :- !.
reemplazar_tilde(0'Í, 0'i) :- !.
reemplazar_tilde(0'Ó, 0'o) :- !.
reemplazar_tilde(0'Ú, 0'u) :- !.
reemplazar_tilde(0'Ñ, 0'n) :- !.
reemplazar_tilde(C, C).

partes_a_atomos([], []).
partes_a_atomos([Parte|Resto], Tokens) :-
    (   Parte == ""
    ->  partes_a_atomos(Resto, Tokens)
    ;   atom_string(Atomo, Parte),
        partes_a_atomos(Resto, RestoTokens),
        Tokens = [Atomo|RestoTokens]
    ).
