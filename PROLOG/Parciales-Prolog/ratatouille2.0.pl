%%-------------------%%
%%      Parte 1      %%
%%-------------------%%

%%-----------%%
%%  Punto 1  %%
%%-----------%%

% rata(Nombre, LugarDondeVive)
rata(remy, gusteaus).a
rata(emile, bar).
rata(django, pizzeria).

% cocina(Cocinero, Plato, Exp)
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

% trabaja(Restaurant, Cocinero)
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).

%%-----------%%
%%  Punto 1  %%
%%-----------%%

restaurante(Restaurante):-
    trabajaEn(Restaurante, _).

inspeccionSatisfactoria(Restaurante):-
    trabajaEn(Restaurante),
    not(rata(_, Restaurante)).

%%-----------%%
%%  Punto 2  %%
%%-----------%%

chef(Cocinero, Restaurante):-
    trabajaEn(Restaurante, Cocinero),
    cocina(Cocinero, _, _).

%%-----------%%
%%  Punto 3  %%
%%-----------%%

chefcito(Rata):-
    rata(Rata, Restaurante),
    trabajaEn(Restaurante, linguini).

%%-----------%%
%%  Punto 4  %%
%%-----------%%

cocinaBien(Cocinero, Plato):-
    cocina(Cocinero, Plato, Experiencia),
    Experiencia > 7.

cocinaBien(remy, _).

%%-----------%%
%%  Punto 5  %%
%%-----------%%

encargado(CocineroEncargado, Plato, Restaurante):-
    cocinaEn(CocineroEncargado, Restaurante, Plato, ExperienciaMayor),
    forall(cocinaEn(_, Restaurante, Plato, ExperienciaMenor), ExperienciaMayor >= ExperienciaMenor).

cocinaEn(Cocinero, Restaurante, Plato, Experiencia):-
    trabajaEn(Cocinero, Restaurante), 
    cocina(Cocinero, Plato, Experiencia).

%%-----------%%
%%  Punto 6  %%
%%-----------%%

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

grupo(hablenPorAca, bifeDeChorizo).
grupo(lomenses, frutillasConCrema).

esSaludable(Plato):-
    plato(Plato, _),
    sumaCalorias(Plato, Calorias),
    Calorias < 75.

esSaludable(Plato):-
    grupo(_, Plato).

sumaCalorias(Plato, Calorias):-
    plato(Plato, entrada(Ingredientes)),
    length(Ingredientes, CantidadDeIngre),
    Calorias is CantidadDeIngre * 15.

sumaCaloria(Plato, Calorias):-
    plato(Plato, principal(Guarnicion, Minutos)),
    caloriasGuarnicion(Guarnicion, CaloriasGuarni),
    Calorias is 5 * Minutos + CaloriasGuarni.

sumaCaloria(Plato, Calorias):-
    plato(Plato, postre(Calorias)).

caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(pure, 20).
caloriasGuarnicion(ensalada, 0).

%%-----------%%
%%  Punto 7  %%
%%-----------%%

platosDeUnRestaurante(Restaurante, Plato):-
    trabajaEn(Restaurante, Cocinero),
    cocina(Cocinero, Plato, _).

criticaPositiva(Restaurante, Critico):-
    restaurante(Restaurante),
    tieneCriticaPositiva(Restaurante, Critico).

tieneCriticaPositiva(Restaurante, antonEgo):-
    sonEspecialistas(Restaurante, ratatouille).

tieneCriticaPositiva(Restaurante, christophe):-
    cantidadDeChefs(Restaurante, Cantidad),
    Cantidad > 3.

sonEspecialistas(Restaurante, Plato):-
    forall(trabajaEn(Restaurante, Cocinero), cocinaBien(Cocinero, Plato)).

cantidadDeChefs(Restaurante, Cantidad):-
    findall(Cocinero, trabajaEn(Restaurante, Cocinero), Cocineros),
    length(Cocineros, Cantidad).

tieneCriticaPositiva(Restaurante, cormillot):-
    todosPlatosSaludables(Restaurante),
    todosLasEntradasZanahoria(Restaurante).

todosPlatosSaludables(Restaurante):-
    restaurante(Restaurante),
    forall(plato(Plato, _), esSaludable(Plato)).

todasEntradasTienenZanahorias(Restaurante):-
    restaurante(Restaurante),
    forall(entradaDe(Restaurante, Ingredientes), tieneZanahoria(Ingredientes)).

entradaDe(Restaurante, Ingredientes):-
    trabajaEn(Cocinero, Restaurante),
    cocina(Cocinero, Plato, _),
    plato(Plato, entrada(Ingredientes)).

tieneZanahoria(Ingredientes):-
    member(zanahoria, Ingredientes).
