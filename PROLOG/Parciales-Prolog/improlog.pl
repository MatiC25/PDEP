%%---------------%%
%%    Parte 1    %%
%%---------------%%

% integrante/3 relaciona a un grupo, con una persona 
% que toca en ese grupo y el instrumento que toca en ese grupo.
integrante(sophieTrio, sophie, violin).
integrante(sophieTrio, santi, guitarra).
integrante(vientosDelEste, lisa, saxo).
integrante(vientosDelEste, santi, voz).
integrante(vientosDelEste, santi, guitarra).
integrante(jazzmin, santi, bateria).

% nivelQueTiene/3 relaciona a una persona con un instrumento que toca y 
% qué tan bien puede improvisar con dicho instrumento 
% (que representaremos con un número del 1 al 5).
nivelQueTiene(sophie, violin, 5).
nivelQueTiene(santi, guitarra, 2).
nivelQueTiene(santi, voz, 3).
nivelQueTiene(santi, bateria, 4).
nivelQueTiene(lisa, saxo, 4).
nivelQueTiene(lore, violin, 4).
nivelQueTiene(luis, trompeta, 1).
nivelQueTiene(luis, contrabajo, 4).

% instrumento/2 que relaciona el nombre de un instrumento 
%con el rol que cumple el mismo al tocar en un grupo. Todos los instrumentos se considerarán rítmicos, armónicos o melódicos. Para los melódicos se incluye información adicional 
%del tipo de instrumento (si es de cuerdas, viento, etc).
instrumento(violin, melodico(cuerdas)).
instrumento(guitarra, armonico).
instrumento(bateria, ritmico).
instrumento(saxo, melodico(viento)).
instrumento(trompeta, melodico(viento)).
instrumento(contrabajo, armonico).
instrumento(bajo, armonico).
instrumento(piano, armonico).
instrumento(pandereta, ritmico).
instrumento(voz, melodico(vocal)).

%%-----------%%
%%  Punto 1  %%
%%-----------%%

tieneUnaBase(Grupo):-
    integrante(Grupo, UnIntegrante, Instrumento),
    instrumento(Instrumento, ritmico),
    integrante(Grupo, OtroIntegrante, OtroInstrumento),
    instrumento(OtroInstrumento, armonico),
    UnIntegrante \= OtroIntegrante.

%%-----------%%
%%  Punto 2  %%
%%-----------%%

seDestaca(Integrante, Grupo):-
    integrante(Grupo, Integrante, _),
    forall((integrante(Grupo, OtroIntegrante, _), Integrante \= OtroIntegrante), esMayorNivel(Integrante, OtroIntegrante, Grupo)).

esMayorNivel(Integrante, OtroIntegrante, Grupo):-
    integrante(Grupo, Integrante, UnInstrumento),
    integrante(Grupo, OtroIntegrante, OtroInstrumento),
    nivelQueTiene(Integrante, UnInstrumento, UnNivel),
    nivelQueTiene(OtroIntegrante, OtroInstrumento, OtroNivel),
    UnNivel > OtroNivel + 2.

%%-----------%%
%%  Punto 3  %%
%%-----------%%

% grupo(Grupo, TipoGrupo)
grupo(vientosDelEste, bigBand()).
grupo(sophieTrio, formacionParticular([contrabajo, guitarra, violin])).
grupo(jazzmin, formacionParticular([bateria, bajo, trompeta, piano, guitarra]))

%%-----------%%
%%  Punto 4  %%
%%-----------%%

hayCupo(Instrumento, Grupo):-
    grupo(Grupo, bigBand()),
    instrumento(Instrumento, melodico(_)).

hayCupo(Instrumento, Grupo):-
    estaDisponible(Instrumento, Grupo),
    grupo(Grupo, TipoGrupo),
    sirveParaElTipo(Instrumento, TipoGrupo).

estaDisponible(UnInstrumento, Grupo):-
    integrante(Grupo, _, UnInstrumento),
    forall(instrumento(OtroInstrumento, _), ((UnInstrumento \= OtroInstrumento), not(integrante(Grupo, _, UnInstrumento)))).

sirveParaElTipo(Instrumento, bigBand()):-
    instrumento(Instrumento, viento).

sirveParaElTipo(bateria, bigBand()).
sirveParaElTipo(bajo, bigBand()).
sirveParaElTipo(piano, bigBand()).

sirveParaElTipo(Instrumento, formacionParticular(Instrumentos)):-
    member(Instrumento, Instrumentos).

%%-----------%%
%%  Punto 5  %%
%%-----------%%

puedeIncorporarse(Integrante, Grupo, Instrumento):-
    not(integrante(Grupo, Integrante, _)),
    hayCupo(Instrumento, Grupo),
    nivelEsperado(Integrante, Grupo, Instrumento).

nivelEsperado(Integrante, Grupo, Instrumento):-
    grupo(Grupo, bigBand()),
    nivelQueTiene(Integrante, Instrumento, Nivel),
    Nivel > 1.

nivelEsperado(Integrante, Grupo, Instrumento):-
    grupo(Grupo, formacionParticular(Instrumentos)),
    nivelQueTiene(Integrante, Instrumento, Nivel),
    length(Instrumentos, Largo),
    Nivel > 7 - Largo.

%%-----------%%
%%  Punto 6  %%
%%-----------%%

quedoEnBanda(Integrante):-
    integrante(_, Integrante, _),
    not(integrante(_, Integrante, _)),
    forall(integrante(Grupo, _, _), not(puedeIncorporarse(Integrante, Grupo, _))).

%%-----------%%
%%  Punto 7  %%
%%-----------%%

puedeTocar(Grupo):-
    integrante(Grupo, _, _),
    forall(integrante(Grupo, Integrante, _), condicion(Grupo, Integrante)).

condicion(Grupo, Integrante):-
    grupo(Grupo, bigBand()),
    tieneUnaBase(Grupo),
    findall(Integrante, (integrante(Grupo, Integrante, Instrumento), instrumento(Instrumento, viento)), Instrumentos),
    length(Instrumentos, Cantidad),
    Cantidad >= 5.

condicion(Grupo, Integrante):-
    grupo(Grupo, formacionParticular(_)),
    forall((grupo(Grupo, formacionParticular(Instrumentos)), member(Instrumentos, Instrumento)), integrante(Grupo, _, Instrumento)).



