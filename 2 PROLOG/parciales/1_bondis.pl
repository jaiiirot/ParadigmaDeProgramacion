% Recorridos en GBA: 
recorrido(17, gba(sur), mitre). 
recorrido(24, gba(sur), belgrano). 
recorrido(247, gba(sur), onsari). 
recorrido(60, gba(norte), maipu). 
recorrido(152, gba(norte), olivos).

% Recorridos en CABA: 
recorrido(17, caba, santaFe). 
recorrido(152, caba, santaFe). 
recorrido(10, caba, santaFe). 
recorrido(160, caba, medrano). 
recorrido(24, caba, corrientes).
/* 
Saber si dos líneas pueden combinarse, 
    que se cumple cuando su recorrido pasa por una misma calle 
    dentro de la misma zona 
*/
puedenCombinarse(Linea,Linea2) :-
    recorrido(Linea,Zona,Lugar),
    recorrido(Linea2,Zona,Lugar),
    Linea \= Linea2.

% Me entrega una Lista para L2 con colectivos que se pueden conbinar.
% puedenCombinarse(L, L2) :-
%     findall(L2, (recorrido(L,Z,P),recorrido(L2,Z,P), L \= L2),L2).

/* 
Conocer cuál es la jurisdicción de una línea,que puede ser o 
     bien nacional, que se cumple cuando la misma 
        cruza la General Paz,   
     o bien provincial, 
        cuando no la cruza. 

Cuando la jurisdicción  es  provincial  nos  interesa  conocer  de  qué  provincia  se  trata,  
    si  es  de buenosAires (cualquier parte de GBA se considera de esta provincia) 
    o si es de caba. 
Se considera que una línea cruza la General Paz cuando 
    parte de su recorrido pasa por una calle de CABA 
    y otra parte por una calle del Gran Buenos Aires (sin importar de qué zona se trate). 
*/
jurisdiccion(Linea, nacional) :-
    cruzaGeneralPaz(Linea).

jurisdiccion(Linea, provincial(Provincia)):-
    recorrido(Linea,Zona,_),
    perteneceA(Zona, Provincia),
    not(cruzaGeneralPaz(Linea)).

cruzaGeneralPaz(Linea) :-
    recorrido(Linea,caba,_),
    recorrido(Linea,gba(_),_).

perteneceA(caba, caba).
perteneceA(gba(_), buenosAires).
/* 3)
Saber cuál es la calle más transitada de una zona,
     que es por la que pasen mayor cantidad de líneas. 
*/

calleMasTransitada(Zona, Calle) :-
    cuantasVecesPasa(Zona, Calle, Cantidad),
    forall((cuantasVecesPasa(Zona, Calle2, Cantidad2),Calle \= Calle2), Cantidad > Cantidad2).

cuantasVecesPasa(Zona,Calle,Cantidad) :-
    recorrido(_,Zona,Calle),
    findall(Linea,recorrido(Linea,Zona,Calle),Lineas),
    length(Lineas, Cantidad).

/* 4)
Saber cuáles son las calles de transbordos en una zona, 
    - que son aquellas por las que pasan al menos 3 líneas de colectivos, 
    - y todas son de jurisdicción nacional. 
*/
calleDeTransbordo(Zona, Calle) :-
    recorrido(_,Zona,Calle),
    findall(Linea, 
            (recorrido(Linea, Zona, Calle),
             jurisdiccion(Linea, nacional)), 
            Lineas),
    length(Lineas, Cantidad),
    Cantidad >= 3.

% 5
tiene(juanita,estudiantil,_).
tiene(leidy,jubilado,_).
tiene(tito,_,_).
tiene(marta,jubilado,_).
tiene(marta,particulares, caba).
tiene(marta,particulares,gba(sur)).
tiene(pepito, particular, gba(norte)).

beneficio(estudiantil).
beneficio(jubilado).
beneficio(particular).

costo(nacional,500).
costo(provincial(caba),350).
costo(provincial(buenosAires),25).

descuento(Persona,Linea, CostoBase) :-
    tiene(Persona,_,_),
    costoBase(Linea, CostoBase).

descuento(Persona,_, 50) :-
    tiene(Persona,estudiantil,_).

descuento(Persona,Linea,0) :-
    tiene(Persona,particular,Zona),
    recorrido(Linea, Zona, _).

descuento(Persona,Linea, Costo) :-
    tiene(Persona,jubilado,_),
    costoBase(Linea,CostoBase),
    Costo is CostoBase/2.


cuestaViajar(Persona,Linea,MinimoCosto) :-
    findall(Costo,descuento(Persona,Linea,Costo),Costos),
    min_member(MinimoCosto, Costos).
    

costoBase(Linea, CostoBase) :-
    jurisdiccion(Linea, Tipo),
    costo(Tipo, CostoBase).
