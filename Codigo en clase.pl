%entrenador(Entrenador).
entrenador(ash).
entrenador(misty).
entrenador(brock).
entrenador(guido).
entrenador(diana).
entrenador(alf).
entrenador(nala).

% tieneA(Entrenador, Pokemon)
tieneA(ash, pikachu).
tieneA(ash, pidgeot).
tieneA(ash, charizard).
tieneA(brock, gyarados).
tieneA(misty, charizard).
tieneA(guido, carpincho).
tieneA(diana, meowth).
tieneA(rasta, mewtwo).

quiereSerElMejor(Alguien):-
	entrenador(Alguien).

%esGroso/1 -> si es rasta O tiene un pikachu y un charizard

esGroso(rasta).

% , -> es nuestro Y lógico
esGroso(Entrenador):-
	tieneA(Entrenador, pikachu),
	tieneA(Entrenador, charizard).

% el o lógico lo hacemos con una nueva clausula
esGroso(Entrenador):-
	tieneA(Entrenador, pikachu).

esGroso(Entrenador):-
	tieneA(Entrenador, charizard).

%negacion

estaSolo(Entrenador):-
	not(tieneA(Entrenador, _)).

% Queremos saber cuando alguien es ilegal, que será cuando tiene pokemones pero 
% no es entrenador

esIlegal(Persona):-
	tieneA(Persona, _),
	not(entrenador(Persona)).


% EJERCITACIÓN: AVATAR
%
% 1) Cuando alguien tiene el control de uno de ellos, le llamamos "maestro".
% Queremos que nuestra base de conocimientos nos permita saber quién es maestro de qué.
% Tenemos algunos ejemplos:
% Toph es una maestra de Tierra.
% Katara es una maestra de Agua.
% Zuko es un maestro de Fuego.
% Sokka no puede controlar ningún elemento.

%esMaestroDe(Personaje, Elemento).




% 2)¿Y los maestros de aire? Desafortunadamente, saber controlar
% el elemento nos nos alcanza para ser un maestro de aire,
% debemos tener en cuenta algunas cositas antes:

% a) Los maestros de aire pueden aprender diferentes tecnicas a las que
% llamaremos movimientos, al día de hoy sabemos que:
% Jinora sabe 39 movimientos.
% Aang es reee pro y sabe 123.
% Meelo tiene mucho por aprender y recién sabe 15.

%cantidadMovimientos(Nombre, Cantidad) -> cantidadMovimientos/2
esCantidadMovimientos(jinora, 39).
esCantidadMovimientos(aang, 123).
esCantidadMovimientos(meelo, 15).
esCantidadMovimientos(ikki,23).
esCantidadMovimientos(tenzin,70).
esCantidadMovimientos(korra,46).

% b) También pueden crear movimientos propios, por ejemplo:

creoElMovimiento(patinetaDeAire,aang).
creoElMovimiento(volar,zaheer).
creoElMovimiento(embudoDeAire,carpincho).


% A partir de esto, podemos decir que un maestro aire será
% aquel que haya creado al menos un movimiento,
% o bien sepa sepa mínimamente 36 movimientos
esMaestroDe(agua,katara).
esMaestroDe(fuego,zuko).
esMaestroDe(tierra,toph).
esMaestroDe(fuego,azula).
esMaestroDe(lodo,toph).
esMaestroDe(rayo,azula).
esMaestroDe(fuego,roku).
esMaestroDe(fuego,jeongJeong).
esMaestroDe(fuego,guido).
esMaestroDe(rayo,guido).
esMaestroDe(tierra,diana).
esMaestroDe(lava,diana).
esMaestroDe(tierra,bolin).
esMaestroDe(tierra,lin).
esMaestroDe(metal,lin).

esMaestroDe(aire, Nombre):-
	creoElMovimiento(_, Nombre).

esMaestroDe(aire, Nombre):-
	esCantidadMovimientos(Nombre, Cantidad),
	Cantidad >= 36.




% 3) Existen algunas personas que van más allá
% que solamente controlar el elemento, si no que también
% desarrollan técnicas para controlar subelementos, como por ejemplo
% un maestro Tierra que pueda controlar Lava.
% Queremos tener entonces un predicado tieneDobleMaestria/1 que nos diga
% quienes son capaces de lograr esto.

tieneDobleMaestria(Persona):-
	esMaestroDe(Elemento, Persona), %¿existe un elemento para esa persona?
	esMaestroDe(SubElemento, Persona), %¿existe un subelemento para esa persona?
	Elemento \= SubElemento. %¿el elemento es distinto de el subelemento?





% 4) Debido a que las naciones se encuentran en guerra,
% nuestro Equipo Avatar no confía en cualquier persona.
% Sabemos que Aang por ejemplo, confía en los siguientes:

%confiaEn(personaAConfiar, personaQueConfia)
%confiaEn/2
confiaEn(zuko, aang).
confiaEn(sokka, aang).
confiaEn(toph, aang).
confiaEn(appa, aang).
confiaEn(momo, aang).
confiaEn(jeongJeong, aang).

%estan casados juan con pedro -> estanCasados/2 -> simetrica ¿cómo lo hacemos?

% Katara, por otro lado, confía en cualquiera que confíe Aang,
% siempre y cuando no sea un maestro fuego.
% Queremos poder consultar en quién confía Katara.

%¿regla o hecho? -> queremos inferir el resultado según nuestra base de conocimientos -> regla
confiaEn(Alguien, katara):-
	confiaEn(Alguien, aang),
	not(esMaestroDe(fuego, Alguien)).






% 5) Del lado de la nación del fuego, no solo tenemos enemistades con otras naciones,
% también tenemos por dentro de la misma. Por ejemplo el comandante Zhao es enemigo 
% de todo maestro cuyo elemento no sea el fuego, y además es enemigo de Zuko.
% Queremos poder consultar quienes son enemigos de Zhao.

esEnemigoDe(zhao, zuko).

esEnemigoDe(zhao, Alguien):-
	esMaestroDe(Elemento, Alguien),
	Elemento \= fuego.
	%not(esMaestroDe(fuego, Alguien)). -> solito no es inversible :c







