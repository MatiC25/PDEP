%%---------------%%
%%    Parte 1    %%
%%---------------%%

%%-----------%%
%%  Punto 1  %%
%%-----------%%

% jockey(Nombre, Medida, Peso)
jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

caballo(botafogo).
caballo(oldMan).
caballo(matBoy).
caballo(energica).
caballo(yatasto).

pesoJockey(Jockey, Peso):-
    jockey(Jockey, _, Peso).

nombreJockey(Jockey):-
    jockey(Jockey, _, _).

alturaJockey(Jockey, Altura):-
    jockey(Jockey, _, Altura).

%%-----------%%
%%  Punto 2  %%
%%-----------%%

% preferenciaPorCaballo(Caballo, Jockey)
preferenciaPorCaballo(botafogo, Jockey):-
    pesoJockey(Jockey, Peso),
    Peso < 52.

preferenciaPorCaballo(botafogo, baratucci).
preferenciaPorCaballo(oldMan, Jockey):-
    nombreJockey(Jockey),
    atom_length(Jockey, Largo),
    Largo > 7.

preferenciaPorCaballo(energica, Jockey):-
    nombreJockey(Jockey),
    forall(nombreJockey(Jockey), not(preferenciaPorCaballo(botafogo, Jockey))).

preferenciaPorCaballo(matBoy, Jockey):-
    alturaJockey(Jockey, Altura),
    Altura > 170.

%%-----------%%
%%  Punto 3  %%
%%-----------%%

loRepresenta(valdivieso, elTute).
loRepresenta(falero, elTute).
loRepresenta(lezcano, lasHormigas).
loRepresenta(baratucci, elCharabon).
loRepresenta(leguisamo, elCharabon).

premio(botafogo, granPremioNacional).
premio(botafogo, granPremioRepublica).
premio(oldMan, granPremioRepublica).
premio(oldMan, campeonatoPalermoOro).
premio(matBoy, granPremioCriadores).

%%-----------%%
%%  Punto 4  %%
%%-----------%%

paraMiParaVos(Caballo):-
    preferenciaPorCaballo(Caballo, UnJockey),
    preferenciaPorCaballo(Caballo, OtroJockey),
    UnJockey \= OtroJockey.

%%-----------%%
%%  Punto 5  %%
%%-----------%%

noSeLlamaAmor(Caballo, Caballeriza):-
    loRepresenta(_, Caballeriza),
    caballo(Caballo),
    forall(loRepresenta(Jockey, Caballeriza), not(preferenciaPorCaballo(Caballo, Jockey))).

%%-----------%%
%%  Punto 6  %%
%%-----------%%

premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

% jockeyPiolin(Jockey):-
%     nombreJockey(Jockey),
%     forall((nombreJockey(Jockey), caballo(Caballo)), sonPiolines(Caballo, Jockey)).

% sonPiolines(Caballo, Jockey):-
%     premioImportante(Premio),
%     premio(Caballo, Premio),
%     preferenciaPorCaballo(Caballo, Jockey).

jockeyPiolin(Jockey):-
    nombreJockey(Jockey),
    forall((premio(Caballo, Premio), premioImportante(Premio)), preferenciaPorCaballo(Caballo, Jockey)).

%%-----------%%
%%  Punto 7  %%
%%-----------%%

