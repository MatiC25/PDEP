%%------------------------------------------------%%
%%                     Parte 1                    %%
%%------------------------------------------------%%

%%---------%%
%% Punto 1 %%
%%---------%%

% jugador(Nombre, Rating, Civilizacion).
jugador(juli, 2200, jemeres).
jugador(aleP, 1600, mongoles).
jugador(feli, 500000, persas).
jugador(aleC, 1723, otomanos).
jugador(ger, 1729, ramanujanos).
jugador(juan, 1515, britones).
jugador(marti, 1342, argentinos).

% tiene(Nombre, QueTiene)
tiene(aleP, unidad(samurai, 199)).
tiene(aleP, unidad(espadachin, 10)).
tiene(aleP, unidad(granjero, 10)).
tiene(aleP, recurso(800, 300, 100)).
tiene(aleP, edificio(casa, 40)).
tiene(aleP, edificio(castillo, 1)).
tiene(juan, unidad(carreta, 10)).
tiene(mati, unidad(espadachin, 1000)).
% militar(Tipo, costo(Madera, Alimento, Oro), Categoria).
militar(espadachin, costo(0, 60, 20), infanteria).
militar(arquero, costo(25, 0, 45), arqueria).
militar(mangudai, costo(55, 0, 65), caballeria).
militar(samurai, costo(0, 60, 30), unica).
militar(keshik, costo(0, 80, 50), unica).
militar(tarcanos, costo(0, 60, 60), unica).
militar(alabardero, costo(25, 35, 0), piquero).

% aldeano(Tipo, produce(Madera, Alimento, Oro)).
aldeano(lenador, produce(23, 0, 0)).
aldeano(granjero, produce(0, 32, 0)).
aldeano(minero, produce(0, 0, 23)).
aldeano(cazador, produce(0, 25, 0)).
aldeano(pescador, produce(0, 23, 0)).
aldeano(alquimista, produce(0, 0, 25)).

% edificio(Edificio, costo(Madera, Alimento, Oro))
edificio(casa, costo(30, 0, 0)).
edificio(granja, costo(0, 60, 0)).
edificio(herreria, costo(175, 0, 0)).
edificio(castillo, costo(650, 0, 300)).
edificio(maravillaMartinez, costo(10000, 10000, 10000)).

%%---------%%
%% Punto 1 %%
%%---------%%

esUnAfano(PrimerJugador, SegundoJugador):-
    jugador(PrimerJugador, PrimerRating, _),
    jugador(SegundoJugador, SegundoRating, _),
    abs(PrimerRating - SegundoRating) > 500.

%%---------%%
%% Punto 2 %%
%%---------%%

tieneVentaja(caballeria, arqueria).
tieneVentaja(arqueria, infanteria).
tieneVentaja(infanteria, piquero).
tieneVentaja(piquero, caballeria).

categoria(Unidad, Categoria):-
    militar(Unidad, _, Categoria).

categoria(aldeano(Categoria, _), Categoria).

esEfectivo(PrimeraUnidad, SegundaUnidad):-
    leGana(PrimeraUnidad, SegundaUnidad).

leGana(PrimeraUnidad, SegundaUnidad):-
    categoria(PrimeraUnidad, PrimeraCategoria),
    categoria(SegundaUnidad, SegundaCategoria),
    tieneVentaja(PrimeraCategoria, SegundaCategoria).

leGana(samurai, SegundaUnidad):-
    categoria(SegundaUnidad, unica).

%%---------%%
%% Punto 3 %%
%%---------%%

esJugador(Jugador):-
    jugador(Jugador, _, _).

alarico(Jugador):-
    soloCosasDeTipo(Jugador, infanteria).

soloCosasDeTipo(Jugador, Tipo):-
    tiene(Jugador, _),
    forall(tiene(Jugador, Unidad), esDeCategoria(Unidad, Tipo)).

esDeCategoria(unidad(Tipo, _), Categoria):-
    categoria(Tipo, Categoria).

% esDeCategoria(edificio(Categoria, _), Categoria).

%%---------%%
%% Punto 4 %%
%%---------%%

leonidas(Jugador):-
    soloCosasDeTipo(Jugador, piquero).

%%---------%%
%% Punto 5 %%
%%---------%%

nomada(Jugador):-
    tiene(Jugador, _),
    not(tieneAlgunEdificio(Jugador, casa)).

tieneAlgunEdificio(Jugador, TipoDeEdificio):-
    tiene(Jugador, edificio(TipoDeEdificio, _)).

%%---------%%
%% Punto 6 %%
%%---------%%

cuantoCuesta(Tipo, Costo):-
    esMilitar(Tipo, Costo, _).

cuantoCuesta(Tipo, Costo):-
    esEdificio(Tipo, Costo).

cuantoCuesta(Tipo, costo(0, 50, 0)):-
    esAldeano(Tipo, _).

cuantoCuesta(Tipo, costo(100, 0, 50)):-
    esCarretaOUrna(Tipo).

esCarretaOUrna(carreta).
esCarretaOUrna(urnaMercante).

esMilitar(Tipo, Costo, Categoria):-
    militar(Tipo, Costo, Categoria).

esEdificio(Tipo, Costo):-
    edificio(Tipo, Costo).

esAldeano(Tipo, Produccion):-
    aldeano(Tipo, Produccion).

%%---------%%
%% Punto 7 %%
%%---------%%
