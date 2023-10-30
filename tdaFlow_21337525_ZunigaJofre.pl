%....................Constructor....................
% flow/4
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
flow(Id, NameMsg, Options, [Id, NameMsg, NewOption]):-
    appendById(Options, [], [],NewOption).
%....................Pertenencia....................


%....................Selectores....................
% getFlowId/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getFlowId([Id, _, _], Id).

% getFlowName/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getFlowName([_, Name, _], Name).

% getFlowOption/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getFlowOption([_, _, Option], Option).

%....................Modificadores....................
% flowAddOption/3
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
flowAddOption([Id,Name,Options],Option,[Id,Name,Options]):-
    getAllOptionIds(Options,[],AllIds),
    getOptionCode(Option,Code),
    member(Code,AllIds).

flowAddOption([Id,Name,Options],Option,[Id,Name,[Option | Options]]):-
    getAllOptionIds(Options,[],AllIds),
    getOptionCode(Option,Code),
    \+ member(Code,AllIds).



%....................Otros......................
% appendById/4
% dom:
% Meta primaria:
% Meta Secundaria:
% Clausulas:

% Caso base:
appendById([],A,_,A).

% Caso 1:
appendById([Option | Rest],Options,Ids,NewOption):-
    getOptionCode(Option, Code),
    member(Code, Ids),
    appendById(Rest,Options,Ids,NewOption).

% Caso 2:
appendById([Option | Rest],Options,Ids, NewOption):-
    getOptionCode(Option, Code),
    \+ member(Code,Ids),
    appendById(Rest,[Option | Options],[Code | Ids],NewOption).

% getAllOptionIds/3
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getAllOptionIds([],Ids,Ids).

getAllOptionIds([Option | Options], Ids, AllIds):-
    getOptionCode(Option,Code),
    getAllOptionIds(Options,[Code|Ids],AllIds).
