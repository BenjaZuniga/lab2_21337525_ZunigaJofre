%....................TDA Option.....................
% Option = Code X Message X ChatbotCodeLink X InicialFlowCodeLink X
% Keyword
%
% Code = Int
% Message = String
% ChatbotCodeLink = Int
% InicialFlowCodeLink = Int
% Keyword = List

%....................Constructor....................
% option/6
% Descripción: Pridicado que crea un TDA option
% Dominio: Code X Message X ChatbotCodeLink X InicialFlowCodeLink X
% Keyword X Option
% Meta primaria: option/6
% Metas secundarias: number_string/2, keywordDowncase/3
/*option(Code, Message, ChatbotCodeLink, InicialFlowCodeLink, Keyword, [Code, Message, ChatbotCodeLink, InicialFlowCodeLink, [Id |NewKeyword]]):-
    number_string(Code,Id),
    keywordDowncase(Keyword,[],NewKeyword).*/

%....................Pertenencia....................
% isOption/1
% Descripción: Predicado que verifica si una lista es un TDA option
% Dominio: List
% Meta primaria: isOption/1
% Metas secundarias: integer/1, string/1, is_list/1
isOption([Code,Message,ChatbotCodeLink,InicialFlowCodeLink,Keyword]):-
    integer(Code),
    string(Message),
    integer(ChatbotCodeLink),
    integer(InicialFlowCodeLink),
    is_list(Keyword).

%....................Selectores....................
% getOptionCode/2
% Descripción: Predicado que entrega el Code de un Option
% Dominio: Option X Code
% Meta primaria: getOptionCode/2
% Metas secundarias: Ninguna
% Clausulas:
getOptionCode([Code, _, _, _, _], Code).

% getOptionMessage/2
% Descripción: Predicado que entrega el Message de un Option
% Dominio: Option X Message
% Meta primaria: getOptionMessage/2
% Metas secundarias: Ninguna
getOptionMessage([_, Message, _, _, _], Message).

% getOptionCbCL/2
% Descripción: Predicado que entrega el ChatbotCodeLink de un Option
% Dominio: Option X ChatbotCodeLink
% Meta primaria: getOptionCbCl/2
% Metas secundarias: Ninguna
% Clausulas:
getOptionCbCL([_, _, ChatbotCodeLink, _, _], ChatbotCodeLink).

% getOptionIFCL/2
% Descripción: Predicado que entrega el InicialFlowCodeLink de un Option
% Dominio: Option X InicialFlowCodeLink
% Meta primaria: getOptionIFCL/2
% Metas secundarias: Ninguna
getOptionIFCL([_, _, _, InicialFlowCodeLink , _], InicialFlowCodeLink).

% getOptionKeyword/2
% Descripción: Predicado que entrega el Keyword de un Option
% Dominio: Option X Keyword
% Meta primaria: getOptionKeyword/2
% Metas secundarias: Ninguna
getOptionKeyword([_, _, _, _, Keyword], Keyword).


%....................Otros....................

% keywordDowncase/3
% Descripción: Predicado que entrega un NewKeyword
% con las palabras claves de otro Keyword en minusculas Dominio: Keyword
% X List X NewKeyword
% Meta primaria: keywordDowncase/3
% Metas secundarias: string_lower/2, keywordDowncase/3

%Caso Base: Si el Keyword es vacio devuelve el acumulador
keywordDowncase([],Aux,Aux).

% Caso 1: Convierte la primera palabra clave a minusculas, se guarda en
% un acumulador y se llama al predicado con la cola del Keyword
keywordDowncase([First | Remaining],Aux,NewKeyword):-
    string_lower(First,Lower),
    keywordDowncase(Remaining,[Lower|Aux],NewKeyword).
