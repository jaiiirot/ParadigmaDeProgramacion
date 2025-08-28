% Punto 1: Pasos al costado (2 puntos)
% jockeys(Nombre,Altura,Peso).
jockeys(valdivieso,155,52).
jockeys(leguisamo,161,49).
jockeys(lezcano,149,50).
jockeys(baratucci,153,55).
jockeys(falero,157,52).

caballo(botafogo).
caballo(oldMan).
caballo(energia).
caballo(matBoy).
caballo(yatasto).

prefiere(botafogo, Jockey) :- 
    jockeys(Jockey,_,Peso),
    Peso < 52.
prefiere(botafogo, baratucci).
prefiere(oldMan, Jockey) :-
    jockeys(Jockey,_,_),
    atom_length(Jockey, Int),
    Int > 7.
prefiere(energia, Jockey) :-
    not(prefiere(botafogo,Jockey)).
prefiere(matBoy, Jockey) :-
    jockeys(Jockey,Altura,_),
    Altura > 170.
prefiere(yatasto, Jockey) :-
    not(jockeys(Jockey,_,_)).

representa(valdivieso, elTute).
representa(falero, elTute).
representa(lezcano, hormigas).
representa(falero, elCharabon).
representa(falero, elCharabon).
    
gano(botafogo, granPremioNacional).
gano(botafogo, granPremiRepublica).
gano(oldMan, granPremiRepublica).
gano(oldMan, campeonatoPalermoOro).
gano(matBoy, granPremioCriadores).

% Punto 2: Para mí, para vos (2 puntos)
masDeUnJockey(Caballo):-
    distinct(Caballo, (
      prefiere(Caballo, Jockey1),
      prefiere(Caballo, Jockey2),
      Jockey1 \= Jockey2
    )).

% Punto 3: No se llama Amor (2 puntos)
