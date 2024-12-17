% PUNTO 1 

jugador(ana, romanos).
jugador(beto, incas).
jugador(carola, romanos).
jugador(dimitri, romanos).

tecnologia(herreria).
tecnologia(forja).
tecnologia(fundicion).
tecnologia(laminas).
tecnologia(emplumado).
tecnologia(punzon).
tecnologia(malla).
tecnologia(horno).
tecnologia(placas).
tecnologia(collera).
tecnologia(arado).

desarrollo(ana, forja).
desarrollo(ana, emplumado).
desarrollo(ana, laminas).
desarrollo(ana, herreria).
desarrollo(beto, herreria).
desarrollo(beto, forja).
desarrollo(beto, fundicion).
desarrollo(carola, herreria).
desarrollo(dimitri, herreria).
desarrollo(dimitri, fundicion).

%%PUNTO 2

expertoMetales(Jugador):-
    desarrollo(Jugador, herreria),
    desarrollo(Jugador, forja), 
    desarrollo(Jugador, fundicion).

expertoMetales(Jugador):-
    desarrollo(Jugador, herreria),
    desarrollo(Jugador, forja),
    jugador(Jugador, romanos).

%%PUNTO 3

esPopular(Civilizacion):-
    jugador(Jugador1, Civilizacion),
    jugador(Jugador2, Civilizacion),
    Jugador1 \= Jugador2.

%% PUNTO 4 

alcanceGlobal(Tecnologia):-
    tecnologia(Tecnologia),
    forall(jugador(Jugador, _), desarrollo(Jugador, Tecnologia)). 

%% PUNTO 5 

desarrolloCivilizacion(Civilizacion, Tecnologia):-
    jugador(Jugador, Civilizacion),
    desarrollo(Jugador, Tecnologia). 

esLider(Civilizacion):-
    jugador(_, Civilizacion), 
    forall((jugador(_, OtraCivilizacion), OtraCivilizacion \= Civilizacion, desarrolloCivilizacion(OtraCivilizacion, Tecnologia)), (desarrolloCivilizacion(Civilizacion, Tecnologia))).

%% UNIDADES!!

%% PUNTO 6 
unidades(ana, piquero(1, conEscudo)). 
unidades(ana, piquero(2, sinEscudo)).
unidades(ana, jinete(caballo)).  
unidades(beto, campeon(100)).
unidades(beto, campeon(80)).
unidades(beto, piquero(1, conEscudo)).
unidades(beto, jinete(camello)). 
unidades(carola, piquero(3, sinEscudo)).
unidades(carola, piquero(2, conEscudo)).

%% PUNTO 7

% jinete(Animal).

vida(jinete(caballo), 90).

vida(jinete(camello), 80).

vida(campeon(Vida), Vida).

vida(piquero(1, sinEscudo), 50).
vida(piquero(2, sinEscudo), 65).
vida(piquero(3, sinEscudo), 70).

vida(piquero(Nivel, conEscudo), Vida):-
    vida(piquero(Nivel, sinEscudo), VidaSinEscudo),
    Vida is VidaSinEscudo * 1.1.

unidadVida(Jugador, UnidadMayor):-
    unidades(Jugador, UnidadMayor),
    vida(UnidadMayor, VidaMayor),
    forall((unidades(Jugador, OtraUnidad), vida(OtraUnidad, OtraVida), OtraUnidad \= UnidadMayor), OtraVida =< VidaMayor).
    
%% PUNTO 8 

ventajaSobre(jinete(Animal), campeon(Vida)).
ventajaSobre(campeon(Vida), piquero(Nivel, Escudo)). 
ventajaSobre(piquero(Nivel, Escudo), jinete(Animal)).
ventajaSobre(jinete(camello), jinete(caballo)). 

unaGanaOtra(Unidades1, Unidades2):-
    ventajaSobre(Unidades1, Unidades2).

unaGanaOtra(Unidades1, Unidades2):-
    not(ventajaSobre(Unidades2, Unidades1)),
    vida(Unidades1, Vida1),
    vida(Unidades2, Vida2),
    Vida1 > Vida2.

%% PUNTO 9  
    
generarJugador(Jugador):- jugador(Jugador,_).

cantidadUnidad(Jugador, Unidad, TotalDeUnidades):-
    findall(Unidad, unidades(Jugador, Unidad), Unidades),
    length(Unidades, TotalDeUnidades).

puedeSobrevivir(Jugador):-
    generarJugador(Jugador),
    cantidadUnidad(Jugador, piquetero(sinEscudo, _), CantidadSinEscudo),
    cantidadUnidad(Jugador, piquetero(conEscudo, _), CantidadConEscudo),
    CantidadConEscudo > CantidadSinEscudo.

%% PUNTO 10 

%% a) 

dependencia(emplumado, herreria). 
dependencia(forja, herreria).
dependencia(laminas, herreria).
dependencia(punzon, emplumado).
dependencia(fundicion, forja).
dependencia(horno,fundicion).
dependencia(malla,laminas).
dependencia(placas, malla). 
dependencia(collera, molino).
dependencia(arado, collera). 

%% b)

puedeDesarrollar(Tecnologia, Jugador):-
    generarJugador(Jugador),
    tecnologia(Tecnologia),
    not(desarrollo(Jugador, Tecnologia)),
    forall(requisito(Tecnologia, Requisito), desarrollo(Jugador, Requisito)).

requisito(Tecnologia, Requisito):-
    dependencia(Tecnologia, Requisito).
requisito(Tecnologia, Requisito):-
    dependencia(Tecnologia, Antecesor),
    requisito(Antecesor, Requisito).
    

%% PUNTO 11 

ordenDesarrollo(Jugador, Orden):-
    generarJugador(Jugador),
    tecnologiasDesarrolladas(Jugador, TecnologiasDesarrolladas),
    ordenarTecnologias(TecnologiasDesarrolladas, Orden, []).

%% armo una lista con todas las tecnologias que tiene ese jugador
tecnologiasDesarrolladas(Jugador, TecnologiasDesarrolladas) :- 
    findall(Tecnologia, desarrollo(Jugador, Tecnologia), TecnologiasDesarrolladas).


    
    