%....................TDA Flow.......................
% Flow = Id X NameMsg X Option
%
% Id = Int
% NameMsg = String
% Opion = List (Lista de TDA Option)
%....................Constructor....................
% flow/4
% Descripción: Predicado que crea el TDA Flow
% Dominio: Id X NameMsg X Options X Flow
% Meta primaria: flow/4
% Metas secundarias: appendById/4
% Clausulas:
flow(Id, NameMsg, Options, [Id, NameMsg, NewOption]):-
    appendById(Options, [], [],NewOption).
%....................Pertenencia....................
% isFlow/1
% Descripción: Predicado que verifica si una lista es un TDA Flow
% Dominio: List
% Meta primaria: isFlow/1
% Metas secundarias: integer/1, string/1, is_list/1
% Clausulas:
isFlow([Id,NameMsg,Options]):-
    integer(Id),
    string(NameMsg),
    is_list(Options).

%....................Selectores....................
% getFlowId/2
% Descripción: Predicado que entrega el Id de un Flow
% Dominio: Flow X Id
% Meta primaria: getFlowId/2
% Metas secundarias: Ninguna
% Clausulas:
getFlowId([Id, _, _], Id).

% getFlowName/2
% Descripción: Predicado que entrega el Name de un Flow
% Dominio: Flow X Name
% Meta primaria: getFlowName/2
% Metas secundarias: Ninguna
% Clausulas:
getFlowName([_, Name, _], Name).

% getFlowOption/2
% Descripción: Predicado que entrega el Option de un Flow
% Dominio: Flow X Option
% Meta primaria: getFlowOption/2
% Metas secundarias: Ninguna
% Clausulas:
getFlowOption([_, _, Option], Option).

%....................Modificadores....................
% flowAddOption/3
% Descripción: Predicado de agrega un Option al Option de un Flow, solo
% si su Id no está repetido
% Dominnio: Flow X Option X NewFlow
% Meta primaria: flowAddOption/3
% Metas secundarias: getAllOptionsIds/3, getOptionCode/2, member/2
% Clausulas:

% Caso 1: Si el Id del Option que se intenta agregar está repetido se
% retorna el mismo flow
flowAddOption([Id,Name,Options],Option,[Id,Name,Options]):-
    getAllOptionIds(Options,[],AllIds),
    getOptionCode(Option,Code),
    member(Code,AllIds).

% Caso 2: Si el Ide del Option que se intenta agregar no está repetido
% se retorna un NewFlow donde su Option contiene el Option que se quería
% agregar
flowAddOption([Id,Name,Options],Option,[Id,Name,[Option | Options]]):-
    getAllOptionIds(Options,[],AllIds),
    getOptionCode(Option,Code),
    \+ member(Code,AllIds).



%....................Otros......................
% appendById/4
% Descripción: Predicado que a partir de un Option de un Flow lo
% reconstruye con Options que no tienen Codes/Ids repetidos
% Dominio: Option X AuxOption X Ids X NewOption
% Meta primaria: appendById/4
% Metas secundarias: getOptionCode/2, member/2, appendById/4
% Clausulas:

% Caso base: Si el Option es vacio retorna el acumulador
appendById([],A,_,A).

% Caso 1: Si el Code de primer TDA Option del Option de un Flow tiene un
% id repetido no se agrega la cabeza al acumulador, y se sige con la
% cola del Option
appendById([Option | Rest],Options,Ids,NewOption):-
    getOptionCode(Option, Code),
    member(Code, Ids),
    appendById(Rest,Options,Ids,NewOption).

% Caso 2: Si el Id del primer TDA Option del Option de un Flow tiene un
% Code no repetido se agrega el Option al acumulador
appendById([Option | Rest],Options,Ids, NewOption):-
    getOptionCode(Option, Code),
    \+ member(Code,Ids),
    appendById(Rest,[Option | Options],[Code | Ids],NewOption).

% getAllOptionIds/3
% Descripción: Predicado que retorna una lista con los code de cada
% Option que compone el Option de un Flow
% Dominio: Option X Ids X AllIds
% Meta primaria: getAllOptionIds/3
% Metas secundarias: getOptionCode/2, getAllOptionIds/3
% Clausulas:

% Caso base: Si el Option es vacio retorna todos los ids
getAllOptionIds([],Ids,Ids).

% Caso 1: Si el Option no es vacio, toma el id del primer Option, lo
% agrega a un acumulador y sigue con la cola del Option
getAllOptionIds([Option | Options], Ids, AllIds):-
    getOptionCode(Option,Code),
    getAllOptionIds(Options,[Code|Ids],AllIds).

% getAllOptionMessages/3
% Descripción: Predicado que retorna un string con los mensages de todos
% los options de un Option de un Flow
% Dominio: Option X String X NewString
% Meta primaria: getAllOptionMessages/3
% Metas secundarias: getOptionMessage/2, string_concat/2,
% getAllOptionMessages/3
% Clausulas:
%
% Caso base: Si Option es vacio retorna el string acumulador
getAllOptionMessages([],String,String).

% Caso 1: Toma el Message del primer del Option de un Option de un Flow
% y lo guarda en un acumulador, y sigue con la cola del Option del Flow
getAllOptionMessages([First | Options],String,NewString):-
    getOptionMessage(First,Message),
    string_concat(Message,"\n",NewMessage),
    string_concat(String,NewMessage,AuxString),
    getAllOptionMessages(Options,AuxString,NewString).
