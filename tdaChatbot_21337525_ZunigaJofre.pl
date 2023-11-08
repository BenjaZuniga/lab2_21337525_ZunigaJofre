?-consult('tdaFlow_21337525_ZunigaJofre.pl').
?-consult('tdaOption_21337525_ZunigaJofre.pl').

%....................TDA Chatbot....................
% Chatbot = ChatbotId X Name X WelcomeMessage X StartFlowId X Flows
%
% ChatbotId = Int
% Name = String
% WelcomeMessage = String
% StartFlowId = Int
% Flows = List(Lista compuesta de TDA Flow)

%....................Constructor....................
% chatbot/6
% Descripción: Predicado que crea un TDA Chatbot
% Dominio: ChatbotId X Name X WelcomeMessage X StartFlowId X Flows X
% Flow
% Meta primaria: chatbot/6
% Metas secundarias: appendFlowById/4
/*chatbot(ChatbotId, Name, WelcomeMessage,StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage,StartFlowId, NewFlows]):-
    appendFlowById(Flows,[], [], AuxFlows),
    reverse(AuxFlows, NewFlows).*/

%....................Pertenencia....................
% isChatbot/1
% Descripción: Predicado que verifica si un elemento es un chatbot
% Dominio: List
% Meta primaria: isChatbot/1
% Metas secundarias: integer/1, string/1, is_list/1
isChatbot([Id,Name,WelcomeMessage,StartFlowId,Flows]):-
    integer(Id),
    string(Name),
    string(WelcomeMessage),
    integer(StartFlowId),
    is_list(Flows).

%....................Selectores....................
% getChatbotId/2
% Descripción: Predicado que entrega el Id de un Chatbot
% Dominio: Chatbor X ChatbotId
% Meta primaria: getChatbotId/2
% Metas secundarias: Ninguna
getChatbotId([Id,_,_,_,_],Id).

% getChatbotName/2
% Descripción: Predicado que entrega el Name de un Chatbot
% Dominio: Chatbot X Name
% Meta primaria: getChatbotName/2
% Metas secundarias: Ninguna
% Clausulas:
getChatbotName([_,Name,_,_,_],Name).

% getChatbotWelcomeMessage/2
% Descripción. Predicado que entrega el WelcomeMessage de un Chatbot
% Dominio: Chatbot X WelcomeMessage
% Meta primaria: getChatbotWelcomeMessage/2
% Metas secundarias: Ninguna
% Clausulas:
getChatbotWelcomeMessage([_,_,WelcomeMessage,_,_],WelcomeMessage).

% getChatbotStartFlowId/2
% Descripción: Predicado que entrega el StartFlowId de un Chatbot
% Dominio: Chatbot X StartFlowId
% Meta primaria: getChatbotStartFlowId/2
% Metas secundarias: Ninguna
getChatbotStartFlowId([_,_,_,StartFlowId,_],StartFlowId).

% getChatbotFlows/2
% Descripción: Predicado que entrega el Flows de un Chatbot
% Dominio: Chatobt X Flows
% Meta primaria: getChatbotFlows/2
% Metas secundarias: Ninguna
getChatbotFlows([_,_,_,_,Flows],Flows).

%....................Modificadores....................
% chatbotAddFlow/3
% Descripción: Predicado que agrega un Flow a un Flows en base al Id, si
% el Id del Flow ya existe en el Flows del Chatbot, no agrega y
% retorna el Flows como estaba, sino lo está el Id lo agrega
% Dominio: Chatbot X Flow X NewChatbot
% Meta primaria: chatbotAddFlow/3
% Metas secundarias: getAllFlowIds/3, getFlowId/2, member/2
% appendFlow/3

% Caso 1:
/*chatbotAddFlow([ChatbotId, Name, WelcomeMessage,StartFlowId, Flows],Flow,[ChatbotId, Name, WelcomeMessage,StartFlowId, Flows]):-
    getAllFlowIds(Flows,[],AllIds),
    getFlowId(Flow,Id),
    member(Id,AllIds).*/

% Caso 2:
/*chatbotAddFlow([ChatbotId, Name, WelcomeMessage,StartFlowId, Flows],Flow,[ChatbotId, Name, WelcomeMessage,StartFlowId, NewFlows]):-
    getAllFlowIds(Flows,[],AllIds),
    getFlowId(Flow,Id),
    \+ member(Id,AllIds),
    appendFlow(Flows, Flow, NewFlows).*/

%....................Otros....................
% appendFlowById/4
% Descripción: Predicado que reconstruye un Flows en base a los Ids de
% los Flow que lo componen, sin dejar Flow con Id repetido
% Dominio: Flows X Acc X Ids X NewFlows
% Meta primaria: appendFlowById/4
% Metas secundarias: getFlowId/2, member/2, appendFlowById/4

% Caso base:
appendFlowById([],Flows,_,Flows).

% Caso 1:
appendFlowById([Flow | RestFlows],Flows,Ids,NewFlows):-
    getFlowId(Flow, Id),
    member(Id, Ids),
    appendFlowById(RestFlows,Flows,Ids,NewFlows).

% Caso 2:
appendFlowById([Flow | RestFlows],Flows,Ids, NewFlows):-
    getFlowId(Flow, Id),
    \+ member(Id,Ids),
    appendFlowById(RestFlows,[Flow | Flows],[Id | Ids],NewFlows).

% appendFlow/3
% Descripción: Agrega un Flow al final de un Flows
% Dominio: Flows X Flow X NewFlow
% Meta primaria: appendFlow/3
% Metas secundarias: appendFlow/3

% Caso base:
appendFlow([],Flow,[Flow]).

% Caso 1:
appendFlow([First| Remaining],Flow,[First | NewFlow]):-
    appendFlow(Remaining,Flow,NewFlow).

% getAllFlowIds/3
% Descripción: Predicado que entrega una lista con todos los Ids de los
% Flow que componen un Flow
% Dominio: Flows X Ids X AllIds
% Meta primaria: gerAllFlowsIds/3
% Metas secundarias: getFlowId/2, getAllFlowIds/3

% Caso base: Si Flows es vacio retorna el acumulador de Ids
getAllFlowIds([],Ids,Ids).

% Caso 1: Agrega el Id del primer Flows al acumulador
getAllFlowIds([Flow | RestFlows], Ids, AllIds):-
    getFlowId(Flow,Code),
    getAllFlowIds(RestFlows,[Code|Ids],AllIds).
