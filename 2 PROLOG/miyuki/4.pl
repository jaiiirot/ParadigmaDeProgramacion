% trabajaCon(P1,P2) :-
%   P1 \= P2,
%   trabajaEn(S,P1),
%   trabajaEn(S,P2).


% grupoA(colombia).
% grupoA(camerun).
% grupoA(jamaica).
% grupoA(italia).

% grupoB(argentina).
% grupoB(nigeria).
% grupoB(japon).
% grupoB(escocia).

% rival(P1, P2) :-
% 	grupoA(P1),
% 	grupoA(P2),
% 	P1 \= P2.

% rival(P1, P2) :-
% 	grupoB(P1),
% 	grupoB(P2),
% 	P1 \= P2.

% alumno(luisa,daniel).
% alumno(juan,daniel).
% alumno(ana,luisa).
% alumno(diana,nico).
% alumno(nahuel,nico).
% alumno(tamara,nahuel).
% alumno(claudio,ruben).
% alumno(jose,ruben).
% alumno(alvaro,jose).
% alumno(alvaro,luisa).

% carilindo(brad).
% carilindo(leo).
% carilindo(johnny).

% simpatico(luciano).
% simpatico(lautaro).

% puedeIr(nico).
% puedeIr(daniel).
% puedeIr(Persona) :-
%     carilindo(Persona).
% puedeIr(Persona) :-
%     alumno(Persona, daniel),
%     not(alumno(_, Persona)).

% reunion(viernes,mabel).
% reunion(viernes,ana).
% reunion(viernes,adrian).
% reunion(viernes,pablo).

% reunion(sabado,mara).
% reunion(sabado,mabel).
% reunion(sabado,adrian).
% reunion(sabado,juan).

% reunion(domingo,juan).
% reunion(domingo, Persona) :-
%     esMayor(Persona).

% puedeIluminarseCon(Dia, Color) :-
%     reunion(Dia, Persona1),
%     reunion(Dia, Persona2),
%     atraeA(Persona1, Color),
%     atraeA(Persona2, Color).

ocupa(argentina, magenta, 5).
ocupa(chile, negro, 3).
ocupa(brasil, amarillo, 8).
ocupa(uruguay, magenta, 5).
ocupa(alaska, amarillo, 7).
ocupa(yukon, amarillo, 1).
ocupa(canada, amarillo, 10).
ocupa(oregon, amarillo, 5).
ocupa(kamtchatka, negro, 6).
ocupa(china, amarillo, 2).
ocupa(siberia, amarillo, 5).    
ocupa(japon, amarillo, 7).
ocupa(australia, negro, 8).
ocupa(sumatra, negro, 3).
ocupa(java, negro, 4).
ocupa(borneo, negro, 1).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(asia, kamtchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(oceania,australia).
estaEn(oceania,sumatra).
estaEn(oceania,java).
estaEn(oceania,borneo).

ocupaContinente(J,C) :-
    forall(estaEn(C,P),ocupa(P,J,_)).
  
estaPeleado(C):-
    forall(ocupa(_,J,_),(estaEn(C,P),ocupa(P,J,_))).

seAtrinchero(J) :-
    ocupa(P,J,_),
    estaEn(C,P),
    forall(ocupa(P2,J,_),estaEn(C,P2)).