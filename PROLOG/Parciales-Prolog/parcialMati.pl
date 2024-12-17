%%-----------%%
%%  Punto 1  %%
%%-----------%%


%------Base de Conocimientos------%

%%---------------------%%
%%  Punto 1- Registro  %%
%%---------------------%%

% persona(Nombre, Edad, Genero).
persona(mati, 19, masculino).
persona(nico, 19, masculino).
persona(leo, 19, masculino).
persona(facu, 19, masculino).

% pretendientes(Persona, Genero/s, EdadMin, EdadMax, Gustos, Disgustos)
pretendientes(mati, femenino, rangoEdad(18, 25)).
pretendientes(nico, femenino, rangoEdad(18, 30)).

% gustos(Nombre, Gusto)
gusto(mati, gusto).
gusto(mati, gusto2).
gusto(mati, gusto3).
gusto(mati, gusto4).
gusto(mati, gusto5).

% disgusto(Nombre, Disgusto)
disgusto(mati, disgusto).
disgusto(mati, disgusto2).
disgusto(mati, disgusto3).
disgusto(mati, disgusto4).
disgusto(mati, disgusto5).


%%-----------%%
%%  Punto 1  %%
%%-----------%%

nombrePersona(Persona):-
    persona(Persona, _, _).

generosDeInteres(Persona, Genero):-
    pretendientes(Persona, Genero, _).

rangoDeInteres(Persona, Rango):-
    pretendientes(Persona, _ , Rango).

perfilIncompleto(Persona):-
    nombrePersona(Persona),
    tieneDatosFaltantes(Persona).

tieneDatosFaltantes(Persona):-
    not(pretendientes(Persona, _, _)).

tieneDatosFaltantes(Persona):-
    not(tieneAlMenosXDatos(Persona, 5)).

tieneDatosFaltantes(Persona):-
    edadPersona(Persona, Edad),
    Edad < 18.

cantidadGustos(Persona, CantidadGusto):-
    nombrePersona(Persona),
    findall(Gusto, gusto(Persona, Gusto), Gustos),
    length(Gustos, CantidadGusto).

cantidadDisgusto(Persona, CantidadDisgusto):-
    nombrePersona(Persona),
    findall(Disgusto, disgusto(Persona, Disgusto), Disgustos),
    length(Disgustos, CantidadDisgusto).

tieneAlMenosXDatos(Persona, Cantidad):-
    cantidadGustos(Persona, CantidadGusto),
    cantidadDisgusto(Persona, CantidadDisgusto),
    alMenos(CantidadGusto, Cantidad),
    alMenos(CantidadDisgusto, Cantidad).

alMenos(UnaCantidad, OtraCantidad):-
    UnaCantidad >= OtraCantidad.


%%------------------------%%
%%  Punto 2  -- Analisis  %%
%%------------------------%%

genero(Genero):-
    persona(_, Genero, _).

almaLibre(Persona):-
    nombrePersona(Persona),
    sienteInteresOAcepta(Persona).

sienteInteresOAcepta(Persona):-
    forall(genero(Genero), generosDeInteres(Persona, Genero)).

sienteInteresOAcepta(Persona):-
    pretendientes(Persona, _, rango(EdadMin, EdadMax)),
    diferenciaDeEdades(EdadMin, EdadMax, Diferencia),
    Diferencia > 30.

diferenciaDeEdades(EdadMin, EdadMax, Diferencia):-
    Diferencia is EdadMax - EdadMin.

%%-----------%%
%%  Punto 3  %%
%%-----------%%

edadPersona(Persona, Edad):-
    persona(Persona, Edad, _).

quiereLaHerencia(Persona):-
    edadPersona(Persona, Edad),
    pretendientes(Persona, _, rango(EdadMin, _)),
    diferenciaDeEdades(EdadMin, Edad, Diferencia),
    Diferencia >= 30.

%%-----------%%
%%  Punto 4  %%
%%-----------%%

indeseable(Persona):-
    nombrePersona(Persona),
    not(esPretendiente(_, Persona)).

%%-----------------------%%
%%  Punto 5  -- Matches  %%
%%-----------------------%%

generoPersona(Persona, Genero):-
    persona(Persona, Genero, _).

edadMinimaInteres(Persona, EdadMin):-
    pretendientes(Persona, _, rango(EdadMin, _)).

esPretendiente(UnaPersona, OtraPersona):-
    generoYEdadCoinciden(UnaPersona, OtraPersona),
    gustoEnComun(UnaPersona, OtraPersona).

generoYEdadCoinciden(UnaPersona, OtraPersona):-
    generoPersona(OtraPersona, Genero),
    generosDeInteres(UnaPersona, Genero),
    edadPersona(OtraPersona, Edad),
    edadMinimaInteres(UnaPersona, Edad).

gustoEnComun(UnaPersona, OtraPersona):-
    gusto(UnaPersona, Gusto),
    gusto(OtraPersona, Gusto).

%%-----------%%
%%  Punto 6  %%
%%-----------%%

hayMatch(UnaPersona, OtraPersona):-
    esPretendiente(UnaPersona, OtraPersona),
    esPretendiente(OtraPersona, UnaPersona).

%%-----------%%
%%  Punto 7  %%
%%-----------%%

trianguloAmoroso(UnaPersona, OtraPersona):-
    esPretendiente(UnaPersona, OtraPersona),
    not(hayMatch(UnaPersona, OtraPersona)),
    esPretendiente(TercerPersona, OtraPersona),
    not(hayMatch(TercerPersona, OtraPersona)),
    esPretendiente(UnaPersona, TercerPersona),
    not(hayMatch(UnaPersona, TercerPersona)).

%%-----------%%
%%  Punto 8  %%
%%-----------%%

unoParaElOtro(UnaPersona, OtraPersona):-
    nombrePersona(UnaPersona),
    nombrePersona(OtraPersona),
    coincidenGustos(UnaPersona, OtraPersona),
    coincidenGustos(OtraPersona, UnaPersona).

coincidenGustos(UnaPersona, OtraPersona):-
    forall(gusto(UnaPersona, Gusto), not(disgusto(OtraPersona, Gusto))).

%%-----------------------%%
%%  Punto 9 -- Mensajes  %%
%%-----------------------%%

% indiceDeAmor(Emisor, Receptor, IndiceMensaje)
indiceDeAmor(mati, nico, 10).

desbalance(UnaPersona, OtraPersona):-
    mensajesDesbalanceados(UnaPersona, OtraPersona).

indiceDeAmorPromedio(UnaPersona, OtraPersona, IndicePromMensaje):-
    findall(IndiceMensaje, indiceDeAmor(UnaPersona, OtraPersona, IndiceMensaje), Mensajes),
    length(Mensajes, CantidadDeMensajes),
    sumlist(Mensajes, IndiceTotal),
    IndicePromMensaje is IndiceTotal / CantidadDeMensajes.

mensajesDesbalanceados(UnaPersona, OtraPersona):-
    indiceDeAmorPromedio(UnaPersona, OtraPersona, UnIndiceProm),
    indiceDeAmorPromedio(OtraPersona, UnaPersona, OtroIndiceProm),
    UnIndiceProm > 2 * OtroIndiceProm.

%%------------%%
%%  Punto 10  %%
%%------------%%

ghostea(UnaPersona, OtraPersona):-
    indiceDeAmor(UnaPersona, OtraPersona, _),
    not(indiceDeAmor(OtraPersona, UnaPersona, _)).