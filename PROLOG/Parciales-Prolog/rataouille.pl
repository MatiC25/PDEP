%miau 
%rata(nombre, dondeViven)
rata(remy, gusteau).
rata(emile, skinner).
rata(django, pizzeria).

%cocina(nombre, plato, experiencia)
cocina(linguini, ratatouille, 3).
cocina(colette, ratatouille, 2).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

cocina(juli, mierdaNotCot, 19).

%trabajaEn(restaurante, nombre )
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette).
trabajaEn(gusteaus, skinner).
trabajaEn(gusteaus, horst).
trabajaEn(cafeDes2Moulins, amelie).
trabajaEn(laCasaDeJuli, juli).

%%-----------%%
%%  Punto 1  %%
%%-----------%%

% inspeccionSatisfactoria/1 se cumple para un
% restaurante cuando no viven ratas allí.

restaurante(Restaurante):-
    trabajaEn(Restaurante, _).

inspeccionSatisfactoria(Restaurante):-
    restaurante(Restaurante),
    not(rata(_, Restaurante)).

%%-----------%%
%%  Punto 2  %%
%%-----------%%

% chef/2: relaciona un empleado con un restaurante si el
% empleado trabaja allí y sabe cocinar algún plato.
cocinero(Empleado):-    
    cocina(Empleado, _, _).

chef(Empleado, Restaurante):-
    trabajaEn(Restaurante, Empleado),
    cocinero(Empleado).

%%-----------%%
%%  Punto 3  %%
%%-----------%%

% 3. chefcito/1: se cumple para una rata si vive en el mismo
% restaurante donde trabaja linguini.
chefcito(Rata):- 
    trabajaEn(Restaurante, linguini),
    rata(Rata, Restaurante). 
    %%RE MOGOLICA

%%-----------%%
%%  Punto 4  %%
%%-----------%%

% cocinaBien/2 es verdadero para una persona si su experiencia preparando 
% ese plato es mayor a 7.
% Además, remy cocina bien cualquier plato que exista.
% Una opcion
plato(Plato):-  
    cocina(_, Plato, _).

cocinaBien(Persona, Plato):- 
    tieneExpORemy(Persona, Plato).

tieneExpORemy(remy, Plato):- 
    plato(Plato).

tieneExpORemy(Persona, Plato):- 
    Persona \= remy,
    cocina(Persona, Plato, Exp),
    Exp > 7.

%% Otra opcion 
% cocinaBien(remy, Plato):- 
%     plato(Plato).

% cocinaBien(Persona, Plato):- 
%     Persona \= remy,
%     cocina(Persona, Plato, Exp),
%     Exp > 7.

%%-----------%%
%%  Punto 5  %%
%%-----------%%

% encargadoDe/3: nos dice el encargado de cocinar un plato en un 
% restaurante, que es quien más
% experiencia tiene preparándolo en ese lugar.
encargado(Plato, Restaurante, Encargado):-
    cocina(Encargado, Plato, Experiencia),
    forall((cocina(Empleado, Plato, OtraExperiencia), Empleado \= Encargado, trabajaEn(Empleado, Restaurante)), Experiencia > OtraExperiencia).

plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])).
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)). 
plato(mierdaNotCot, entrada([zanahoria, cacaDeMono, chocolate])).

% 6. saludable/1: un plato es saludable si tiene menos de 75 calorías.
% ● En las entradas, cada ingrediente suma 15 calorías.
% ● Los platos principales suman 5 calorías por cada minuto de cocción. Las guarniciones agregan
% a la cuenta total: las papasFritas 50 y el puré 20, mientras que la ensalada no aporta calorías.
% ● De los postres ya conocemos su cantidad de calorías.
% Pero además, un postre también puede ser saludable si algún grupo del curso tiene ese nombre de
% postre. Usá el predicado grupo/1 como hecho y da un ejemplo con tu nombre de grupo.

grupo(helado).
grupo(frutillasConCrema).

saludable(Plato):-
    plato(Plato, TipoDePlato),
    TipoDePlato \= postre(_),
    calorias(TipoDePlato, Calorias),
    Calorias < 75.

saludable(Plato):-
    plato(Plato, postre(_)),
    grupo(Plato).

calorias(entrada([Ingredientes]), Calorias):-
    length(Ingredientes, Cantidad),
    Calorias is Cantidad * 15.
calorias(principal(Guarnicion, MinutosCoccion), Calorias):- 
    caloriasGuarnicion(Guarnicion, CaloriasGuarni),
    Calorias is MinutosCoccion * 5 + CaloriasGuarni.
calorias(postre(Calorias), Calorias).

caloriasGuarnicion(pure, 20).
caloriasGuarnicion(papasFritas, 50).
caloriasGuarnicion(ensalada, 0).

%%-----------%%
%%  Punto 7  %%
%%-----------%%
% criticaPositiva/2: es verdadero para un restaurante si un crítico le escribe una reseña positiva.
% Cada crítico maneja su propio criterio, pero todos están de acuerdo en lo mismo: el lugar debe tener
% una inspección satisfactoria.
% ● antonEgo espera, además, que en el lugar sean especialistas preparando ratatouille. Un
% restaurante es especialista en aquellos platos que todos sus chefs saben cocinar bien.
% ● christophe, que el restaurante tenga más de 3 chefs.
% ● cormillot requiere que todos los platos que saben cocinar los empleados del restaurante sean
% saludables y que a ninguna entrada le falte zanahoria.
% ● gordonRamsay no le da una crítica positiva a ningún restaurante.

criticaPositiva(Criterio, Restaurante):-
    criterio(Criterio, Restaurante).

criterio(antonEgo, Restaurante):-
    especialista(ratatouille, Restaurante).
criterio(christophe, Restaurante):-
    cantidadEmpleados(Restaurante, CantidadEmpleados),
    CantidadEmpleados > 3.
criterio(cormillot, Restaurante):-
    todosSaludables(Restaurante),
    tieneZanahoria(Restaurante).

%%No hace falta agregar al gordonRamsay a la base de conocimientos por principio de universo cerrado :)

especialista(ratatouille, Restaurante):-
    forall(trabajaEn(Restaurante, Empleado), cocinaBien(Empleado, ratatouille)).

cantidadEmpleados(Restaurante, Cantidad):-
    findall(Empleado, trabajaEn(Empleado, Restaurante), Empleados),
    length(Empleados, Cantidad).

% SE REPITE LOGICA EN EL DOMINIO DEL FORALL 
todosSaludables(Restaurante):-
    restaurante(Restaurante),
    forall((trabajaEn(Empleado, Restaurante), cocina(Empleado, Plato, _)), saludable(Plato)).

tieneZanahoria(Restaurante):-
    restaurante(Restaurante),
    forall((trabajaEn(Empleado, Restaurante), cocina(Empleado, Plato, _), plato(Plato, entrada(Ingredientes))), member(zanahoria, Ingredientes)).
