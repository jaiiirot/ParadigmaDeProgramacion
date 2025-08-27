destino(pepe, alejandria).
destino(pepe, jartum).
destino(pepe, roma).
destino(juancho, roma).
destino(juancho, belgrado).
destino(lucy, roma).
destino(lucy, belgrado).

idioma(alejandria, arabe).
idioma(jartum, arabe).
idioma(belgrado, serbio).
idioma(roma, italiano).

habla(pepe, bulgaro).
habla(pepe, italiano).
habla(juancho, arabe).
habla(juancho, italiano).
habla(juancho, espaniol).
habla(lucy, griego).

%tiene al menos un destino en comun
%habla los idiomas de todos los destinos del primero
%primero no habla el idioma destino.

granCompanieroDeViaje(Persona1, Persona2):-
    tienenUnDestinoComun(Persona1, Persona2).
    noHablaIdiomasDelPais(Persona1,Idioma),
    hablaLosIdiomasDePaisDelPrimero(Persona2,Idioma).
    
tienenUnDestinoComun(Persona1,Persona2) :-
    destino(Persona1,Destino),
    destino(Persona2,Destino).

noHablaIdiomasDelPais(Persona1, Idioma) :-
    idioma(P,Idioma),
    destino(Persona1,P),
    not(habla(Persona1,Idioma)).

hablaLosIdiomasDePaisDelPrimero(Persona2,Idioma) :-
    habla(Persona2,Idioma).
