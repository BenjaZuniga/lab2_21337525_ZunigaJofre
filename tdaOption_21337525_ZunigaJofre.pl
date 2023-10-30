%....................Constructor....................
% option/6
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
option(Code, Message, ChatbotCodeLink, InicialFlowCodeLink, Keyword, [Code, Message, ChatbotCodeLink, InicialFlowCodeLink, Keyword]).

%....................Pertenencia....................

%....................Selectores....................
% getOptionCode/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getOptionCode(Option, Code) :-
    option(Code, _, _, _, _, Option).

% getOptionMessage/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getOptionMessage(Option, Message) :-
    option(_, Message, _, _, _, Option).

% getOptionCbCL/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getOptionCbCL(Option, ChatbotCodeLink) :-
    option(_, _, ChatbotCodeLink, _, _, Option).

% getOptionIFCL/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getOptionIFCL(Option, InicialFlowCodeLink) :-
    option(_, _, _, InicialFlowCodeLink, _, Option).

% getOptionKeyword/2
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getOptionKeyword(Option, Keyword) :-
    option(_, _, _, _, Keyword, Option).

%....................Otros....................
