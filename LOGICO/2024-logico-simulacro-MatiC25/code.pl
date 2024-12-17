
%%-------------%%
%%   Parte 1   %%
%%-------------%%
%% Probando
=======
% Acá va el código
%%-------------%%
%%   Parte 1   %%
%%-------------%%

% juego(Nombre, Tipo, Precio)

esJuego(pistolitas, accion, 1000).
% rol(CantiddaDeUsuarios)
esJuego(juegoDeRol, rol(100000), 300).
% puzzle(cantNiveles, Dificultad)
esJuego(juegoDePuzzle, puzzle(25, facil), 500).
esJuego(rompeCabezas, puzzle(2, facil), 200).
esJuego(niIdea, puzzle(2, dificil), 300).
esJuego(valorant, accion, 100).
esJuego(conter, accion, 1500).


% descuento(Nombre, PorcentajeDeDescuento)
descuento(valorant, 20).
descuento(deadlock, 10).
descuento(juegoDeRol, 50).
descuento(conter, 55).
descuento(ark, 60).

%%---------%%
%% Punto 1 %%
%%---------%%

juego(Juego):-
    esJuego(Juego, _, _).

cuantoSale(Juego, Costo):-
    juego(Juego),
    precioConOSinDescuento(Juego, Costo).

precioConOSinDescuento(Juego, Costo):-
    descuento(Juego, Porcentaje),
    esJuego(Juego, _, Precio),
    Costo is Precio * (1 - (Porcentaje / 100)).

precioConOSinDescuento(Juego, Costo):-
    not(descuento(Juego, _)),
    esJuego(Juego, _, Costo).

%%---------%%
%% Punto 2 %%
%%---------%%

tieneBuenDescuento(Juego):-
    descuento(Juego, Porcentaje),
    Porcentaje >= 50.

%%---------%%
%% Punto 3 %%
%%---------%%

tipoDeJuego(Juego, Tipo):-
    esJuego(Juego, Tipo, _).

esPopular(conter).
esPopular(minecraft).
esPopular(Juego):-
    tipoDeJuego(Juego, accion).

esPopular(Juego):-
    tipoDeJuego(Juego, rol(UsuarioActivos)),
    UsuarioActivos > 1000000.

esPopular(Juego):-
    tipoDeJuego(Juego, puzzle(CantNiveles, Dificultad)),
    esFacilOTiene25Niveles(CantNiveles, Dificultad).

esFacilOTiene25Niveles(25, _).
esFacilOTiene25Niveles(_, facil).

%%---------%%
%% Punto 4 %%
%%---------%%

usuario(mati).
usuario(nico).
usuario(leo).
usuario(facu).

% juegoDeUsuario(Usuario, Juego)
juegoDeUsuario(mati, conter).
juegoDeUsuario(nico, bindingOfIsaac).
juegoDeUsuario(leo, albion).
juegoDeUsuario(facu, shakeAndFidgets).

futuraAdquisicion(mati, conter, regalo(nico)).
futuraAdquisicion(mati, juegoDeRol, regalo(nico)).
futuraAdquisicion(mati, juegoDePuzzle, regalo(leo)).
futuraAdquisicion(mati, ark, paraSiMismo).
futuraAdquisicion(nico, juegoDeRol, regalo(mati)).

%%----b----%%

susJuegos(Usuario, Juego):-
    juegoDeUsuario(Usuario, Juego).

susJuegos(Usuario, Juego):-
    futuraAdquisicion(Usuario, Juego, _).

adictoDescuentos(Usuario):-
    usuario(Usuario),
    forall(susJuegos(Usuario, Juego), tieneBuenDescuento(Juego)).

esFanatico(Usuario, Genero):-
    usuario(Usuario),
    findall(Genero, losDelMismoGenero(Usuario, Genero), CantidadDeJuegos),
    length(CantidadDeJuegos, Total),
    Total >= 2.

losDelMismoGenero(Usuario, Genero):-
    susJuegos(Usuario, UnJuego),
    susJuegos(Usuario, OtroJuego),
    UnJuego \= OtroJuego,
    esJuego(UnJuego, Genero, _),
    esJuego(OtroJuego, Genero, _).

esMonotematico(Usuario, Genero):-
<<<<<<< HEAD
    usuario(Usuario), esJuego(_, Genero, _),
=======
    usuario(Usuario),
>>>>>>> ea5a86338e97ccfb2a914f63bf52e83cdb1d9865
    forall(susJuegos(Usuario, Juego), esDelGenero(Juego, Genero)).

esDelGenero(Juego, Genero):-
    esJuego(Juego, Genero, _).

%%----c----%%

buenosAmigos(UnUsuario, OtroUsuario):-
    tieneRegaloPara(UnUsuario, OtroUsuario),
    tieneRegaloPara(OtroUsuario, UnUsuario).

tieneRegaloPara(UnUsuario, OtroUsuario):-
    futuraAdquisicion(UnUsuario, Juego, regalo(OtroUsuario)),
    esPopular(Juego).

    futuraAdquisicion(UnUsuario, _, regalo(OtroUsuario)).

%%----d----%%

% cuantoGastara(Usuario, Funcion)

sumaPorFuncion(Usuario, Funcion, Total):-
    findall(Precio, (futuraAdquisicion(Usuario, Juego, Funcion), cuantoSale(Juego, Precio)), Costos),
    sumlist(Costos, Total).

% cuantoGastara(Usuario, Funcion, Total):-
%     usuario(Usuario),
%     futuraAdquisicion(Usuario, _ , Funcion),
%     sumaPorFuncion(Usuario, Funcion, Total).

cuantoGastara(Usuario, ambas, Total):-
    sumaPorFuncion(Usuario, paraSiMismo, UnCosto),
    sumaPorFuncion(Usuario, regalo(_), OtroCosto),
    Total is UnCosto + OtroCosto.

cuantoGastara(Usuario, regalos, Total):-
    sumaPorFuncion(Usuario, regalo(_), Total).

cuantoGastara(Usuario, futuraCompra, Total):-
    sumaPorFuncion(Usuario, paraSiMismo, Total).
