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

/* 1) */
puedenCombinarse(Linea,Linea2) :-
    recorrido(Linea,Zona,Lugar),
    recorrido(Linea2,Zona,Lugar),
    Linea \= Linea2.

/* 2) */
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

/* 3) */
calleMasTransitada(Zona, Calle) :-
    cuantasVecesPasa(Zona, Calle, Cantidad),
    forall((cuantasVecesPasa(Zona, Calle2, Cantidad2),Calle \= Calle2), Cantidad > Cantidad2).

cuantasVecesPasa(Zona,Calle,Cantidad) :-
    recorrido(_,Zona,Calle),
    findall(Linea,recorrido(Linea,Zona,Calle),Lineas),
    length(Lineas, Cantidad).

/* 4) */
calleDeTransbordo(Zona, Calle) :-
    recorrido(_,Zona,Calle),
    findall(Linea, 
            (recorrido(Linea, Zona, Calle),
             jurisdiccion(Linea, nacional)), 
            Lineas),
    length(Lineas, Cantidad),
    Cantidad >= 3.

/* 5) */
tiene(juanita,estudiantil).
tiene(tito,_).
tiene(marta,jubilado).
tiene(marta,casasParticulares(caba)).
tiene(marta,casasParticulares(gba(sur))).
tiene(pepito,casasParticulares(gba(norte))).

costo(nacional,500).
costo(provincial(caba),350).
costo(provincial(buenosAires),25).

cuestaViajar(Persona,Linea,MinimoCosto) :-
    findall(Costo,descuento(Persona,Linea,Costo),Costos),
    min_member(MinimoCosto, Costos).

descuento(Persona,Linea, CostoBase) :-
    tiene(Persona,_),
    costoBase(Linea, CostoBase).

descuento(Persona,_, 50) :-
    tiene(Persona,estudiantil).

descuento(Persona,Linea,0) :-
    tiene(Persona,casasParticulares(Zona)),
    recorrido(Linea, Zona, _).

descuento(Persona,Linea, Costo) :-
    tiene(Persona,jubilado),
    costoBase(Linea,CostoBase),
    Costo is CostoBase/2.

costoBase(Linea, CostoBase) :-
    jurisdiccion(Linea, Tipo),
    costo(Tipo, CostoBase).

    