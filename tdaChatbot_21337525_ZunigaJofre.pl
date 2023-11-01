%....................Constructor....................
% chatbot/6
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
chatbot(ChatbotId, Name, WelcomeMessage,StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage,StartFlowId, NewFlows]):-
    appendFlowById(Flows,[], [], NewFlows).
%....................Pertenencia....................
% isChatbot/1
% dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
isChatbot([Id,Name,WelcomeMessage,StartFlowId,Flows]):-
    integer(Id),
    string(Name),
    string(WelcomeMessage),
    integer(StartFlowId),
    is_list(Flows).

%....................Selectores....................
% getChatbotId
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getChatbotId([Id,_,_,_,_],Id).

% getChatbotName
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getChatbotName([_,Name,_,_,_],Name).

% getChatbotWelcomeMessage
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getChatbotWelcomeMessage([_,_,WelcomeMessage,_,_],WelcomeMessage).

% getChatbotStartFlowId
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getChatbotStartFlowId([_,_,_,StartFlowId,_],StartFlowId).

% getChatbotFlows
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getChatbotFlows([_,_,_,_,Flows],Flows).

%....................Modificadores....................
% chatbotAddFlow
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
chatbotAddFlow([ChatbotId, Name, WelcomeMessage,StartFlowId, Flows],Flow,[ChatbotId, Name, WelcomeMessage,StartFlowId, Flows]):-
    getAllFlowIds(Flows,[],AllIds),
    getFlowId(Flow,Id),
    member(Id,AllIds).
chatbotAddFlow([ChatbotId, Name, WelcomeMessage,StartFlowId, Flows],Flow,[ChatbotId, Name, WelcomeMessage,StartFlowId, [Flow | Flows]]):-
    getAllFlowIds(Flows,[],AllIds),
    getFlowId(Flow,Id),
    \+ member(Id,AllIds).

%....................Otros....................
% appendFlowById/4
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
appendFlowById([],Flows,_,Flows).

appendFlowById([Flow | RestFlows],Flows,Ids,NewFlows):-
    getFlowId(Flow, Id),
    member(Id, Ids),
    appendFlowById(RestFlows,Flows,Ids,NewFlows).

appendFlowById([Flow | RestFlows],Flows,Ids, NewFlows):-
    getFlowId(Flow, Id),
    \+ member(Id,Ids),
    appendFlowById(RestFlows,[Flow | Flows],[Id | Ids],NewFlows).

% getAllFlowIds/3
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getAllFlowIds([],Ids,Ids).

getAllFlowIds([Flow | RestFlows], Ids, AllIds):-
    getFlowId(Flow,Code),
    getAllFlowIds(RestFlows,[Code|Ids],AllIds).
