%%-----------%%
%%  Parte 1  %%
%%-----------%%

%&--- Base de Conocimientos ---%%

% Se empieza 13.28pm

% miembro(Nombre, Rol)
miembro(juani, desarrollador(senior)).
miembro(emi, devOps).
miembro(lucas, desarrollador(junior)).
miembro(tomi, desarrollador(semiSenior)).
miembro(dante, desarrollador(semiSenior)).
miembro(manu, administrador).
miembro(gus, administrador).

% tarea(Nombre, Estado, Tipo) Tipo -> functor
tarea(haskelPies, enProgreso, historiaDeUsuario(5)).
tarea(actualizarWollok, terminada, historiaDeUsuario(3)).
tarea(charGPTParcial, paraHacer, bug).
tarea(reescribirLinux, paraHacer, spike(infraestructura)).
tarea(parciales, enProgreso, epica).
tarea(rendirParcialFuncional, terminada, historiaDeUsuario(4)).
tarea(parcialLogico, enProgreso, historiaDeUsuario(3)).
tarea(parcialObjetos, paraHacer, historiaDeUsuario(6)).
tarea(dominioParcialObjetos, paraHacer, spike(bibliotecas)).
tarea(estudiarLibroGamma, paraHacer, spike(bibliotecas)).
tarea(cambiarTP4, enProgreso, historiaDeUsuario(2)).
tarea(pensarConsigna, enProgreso, spike(bibliotecas)).
tarea(tenerRepoDesafios, paraHacer, historiaDeUsuario(1)).

% queHacer(asignado, Tarea)
queHacer(lucas, haskelPies).
queHacer(juani, actualizarWollok).
queHacer(emi, reescribirLinux).
queHacer(gus, parciales).
queHacer(tomi, rendirParcialFuncional).
queHacer(lucas, parcialLogico).
queHacer(dante, cambiarTP4).
queHacer(juani, pensarConsigna).
queHacer(emi, tenerRepoDesafios).

%%-----------%%
%%  Punto a  %%
%%-----------%%

tareaDisponible(Tarea):-
    tarea(Tarea, paraHacer, _),
    not(queHacer(_, Tarea)).

%%-----------%%
%%  Punto b  %%
%%-----------%%

tipoTarea(Tarea, Tipo):-
    tarea(Tarea, _, Tipo).

parteDelEquipo(Miembro):-
    miembro(Miembro, _).

dificultad(Tarea, Miembro, Dificultad):-
    tipoTarea(Tarea, Tipo),
    parteDelEquipo(Miembro),
    tieneDificultad(Tipo, Miembro, Dificultad).

tieneDificultad(historiaDeUsuario(Tardanza), _, Dificultad):-
    tiempoEstimado(Tardanza, Dificultad).

tieneDificultad(bug, Miembro, normal):- 
    esSenior(Miembro).

tieneDificultad(bug, Miembro, dificil):-
    not(esSenior(Miembro)).

tieneDificultad(spike(TipoDeSpike), Miembro, facil):-
    miembro(Miembro, TipoDeDesarrollador),
    seTeHaceFacilLaSpike(TipoDeDesarrollador, TipoDeSpike).

tieneDificultad(spike(TipoDeSpike), Miembro, dificil):-
    miembro(Miembro, TipoDeDesarrollador),
    not(seTeHaceFacilLaSpike(TipoDeDesarrollador, TipoDeSpike)).

tieneDificultad(epica, _, dificil).
% Saber entre que rando se encuentra la tardanza de la tarea

tiempoEstimado(Tardanza, facil):-
    between(1, 3, Tardanza).

tiempoEstimado(4, normal).

tiempoEstimado(Tardanza, dificil):- Tardanza >= 5.

% Saber si es un desarrolador senior o no
esSenior(Miembro):-
    miembro(Miembro, desarrollador(senior)).

% seTeHaceFacilLaSpike(TipoDeDesarrollador, TipoDeSpike)
seTeHaceFacilLaSpike(devOps, infraestructura).
seTeHaceFacilLaSpike(desarrollador(_), bibliotecas).
seTeHaceFacilLaSpike(administrador, triggers).

%%-----------%%
%%  Punto c  %%
%%-----------%%

puedeRealizarTarea(Tarea, Miembro):-
    tareaDisponible(Tarea),
    parteDelEquipo(Miembro),
    not(tieneDificultad(Tarea, Miembro, dificil)).

%%-----------------------%%
%%  Parte 2  --- SQUADS  %%
%%-----------------------%%

squad(juani, hooligans).
squad(emi, hooligans).
squad(tomi, hooligans).
squad(dante, isotopos).
squad(manu, isotopos).
squad(lucas, cools).
squad(gus, cools).

% puntosEntregados(NombreSquad, Puntos):-
%     squad(_, NombreSquad),
%     forall((squad(Miembro, NombreSquad), queHacer(Miembro, Tarea)), sumaHistoriasDeUsuario(Tarea, Puntos)).

% sumaHistoriasDeUsuario(Tarea, Puntos):-
%     tarea(Tarea, _, historiaDeUsuario(Puntos)).

% a.

puntosEntregados(NombreSquad, PuntosTotales):-
    squad(_, NombreSquad),
    findall(Puntos, squadTieneHistoria(NombreSquad, Puntos), PuntosAcumulados),
    sumlist(PuntosAcumulados, PuntosTotales).

squadTieneHistoria(NombreSquad, Puntos):-
    squad(Miembro, NombreSquad), 
    queHacer(Miembro, Tarea), 
    tarea(Tarea, terminada, historiaDeUsuario(Puntos)).

% b.

squadTieneLaburo(NombreSquad):-
    squad(_, NombreSquad),
    forall(squad(Miembro, NombreSquad), estaOcupado(Miembro)).

estaOcupado(Miembro):-
    queHacer(Miembro, Tarea),
    estaEnEso(Tarea).

estaOcupado(Miembro):-
    puedeRealizarTarea(_, Miembro).

estaEnEso(Tarea):-
    tarea(Tarea, Estado, _),
    Estado \= terminada.

% c.

esElMasLaburador(NombreSquadTrabajador):-
    squadTieneLaburo(NombreSquadTrabajador),
    forall(squadTieneLaburo(NombreSquad), tieneMasHistoriaQue(NombreSquadTrabajador, NombreSquad)).

tieneMasHistoriaQue(NombreSquadTrabajador, NombreSquad):-
    puntosEntregados(NombreSquadTrabajador, Ganador),
    puntosEntregados(NombreSquad, Perdedor),
    Ganador > Perdedor.

%%-------------------------%%
%%  Parte 2  --- Subtarea  %%
%%-------------------------%%
% esSubtarea(subtarea, tarea)
subtarea(rendirParcialFuncional, parciales).
subtarea(parcialLogico, parciales).
subtarea(parcialObjetos, parciales).
subtarea(dominioParcialObjetos, parcialObjetos).
subtarea(estudiarLibroGamma, parcialObjetos).
subtarea(tenerRepoDesafios, pensarConsigna).

esSubtareaExplicitaOImplicita(Subtarea, Tarea):- 
    subtarea(Subtarea, Tarea).

esSubtareaExplicitaOImplicita(Subtarea, Tarea):- 
    subtarea(Subtarea, OtraTarea), 
    esSubtareaExplicitaOImplicita(OtraTarea, Tarea).

cantidadDeSubTareas(Tarea, Cantidad):-
    findall(SubTarea, esSubtareaExplicitaOImplicita(SubTarea, Tarea), SubTareas),
    length(SubTareas, Cantidad).

% cantidadDeSubtareasDirectasOIndirectas(Tarea, Cantidad):-
%     subtarea(SubTarea, Tarea)
%     cantidadDeSubTareas(Tarea, Cantidad).

% cantidadDeSubtareasDirectasOIndirectas(Tarea, Cantidad):-
%     subtarea(SubTarea, Tarea),
%     cantidadDeSubTareas(SubTarea, CantidadSub),
%     cantidadDeSubtareasDirectasOIndirectas(SubTarea, CantidadSub).

% cantidadDeSubtareasDirectasOIndirectas(Tarea, 0):-
%     not(subtarea(_, Tarea)).


% b.

estaBienCatalogada(Tarea):-
    cantidadDeSubTareas(Tarea, Cantidad),
    Cantidad >= 5,
    tipoTarea(Tarea, epica).

estaBienCatalogada(Tarea):-
    subtarea(_, Tarea),
    esHistoriaOEpica(Tarea).

esHistoriaOEpica(Tarea):-
    cantidadDeSubTareas(Tarea, Cantidad),
    Cantidad < 5, 
    tipoTarea(Tarea, historiaDeUsuario(_)).

esHistoriaOEpica(Tarea):-
    tipoTarea(Tarea, epica).

% Se termino 15.48
% Tiempo Total -> 2horas y 20minutos
% Se que el punto a de las "Subtareas" está mal o le faltan retoques

