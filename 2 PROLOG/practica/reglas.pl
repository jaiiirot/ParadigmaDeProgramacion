%valido, pero muy trivial
argentinaCampeon.

% HECHOS: 
universidadPublica(utn).
universidadPublica(unahur).
universidadPublica(uba).

% HECHOS. RELACIONES: vincula varios elementos
% trabaja(Persona, Trabajo, Sueldo)
trabaja(tito,acme,350000).
trabaja(dani,utn,20000).
trabaja(dani,uba,450000).
trabaja(tito,utn,25000).
trabaja(lalo,inti,5250000).
trabaja(pelu,bit,750000).
trabaja(lola,acme,3531000).

empleo(inti,publico).
empleo(acme,privado).
empleo(garrahan,publico).
empleo(bit,privado).

% REGLAS. "Y"

% BUSCAR LOS TRABAJOS
universitario(Persona) :-
    trabaja(Persona,Trabajo,_),
    universidadPublica(Trabajo).

% filtra Sueldo Total: findall(Sueldo, trabaja(tito, _, Sueldo), ListaDeSueldos), sum_list(ListaDeSueldos, SueldoTotal).
% Filtra todos los trabajos: trabaja(tito, Trabaja, _)

% BUSCAR A LOS DOCENTES QUE TRABAJAN EN ALGUNA UNIVERSIDAD
% docenteEn(Quien?, Donde?)
docenteEn(Persona, Universidad) :-
    trabaja(Persona, Universidad,_),
    universidadPublica(Universidad).

% REGLAS. "O"
% Un trabajo en universidad de ente publico
esPublico(Trabajo) :- universidadPublica(Trabajo).
% Un trabajo de ente publico
esPublico(Trabajo) :- empleo(Trabajo, publico).

trabajadorEstatal(Persona):-
    trabaja(Persona,Trabajo,_),
    esPublico(Trabajo).