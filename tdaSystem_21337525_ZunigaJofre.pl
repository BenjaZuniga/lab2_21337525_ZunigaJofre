
% system/
% Dom:
% Meta primaria:
% Metas secuandarias:
% Clausulas:
system(Name, InicialChatbotCodeLink,Chatbots,[Name,InicialChatbotCodeLink, SFCL,[],[],[],[],NewChatbots]):-
        appendChatbotById(Chatbots,[],[],NewChatbots),
        getStartFlowCodeLink(InicialChatbotCodeLink,NewChatbots,SFCL).
%....................Pertenencia....................

%....................Selectores....................
% getSystemName/2
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSystemName([Name,_,_,_,_,_,_,_],Name).

% getSystemICbCl/2
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSystemICbCL([_,InicialChatbotCodeLink,_,_,_,_,_,_],InicialChatbotCodeLink).

% getSystemRegisterUsers
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSystemSFCL([_,_,IFCL,_,_,_,_,_],IFCL).

% getSystemLoginUser
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSystemRegisterUsers([_,_,_,RegisterUsers,_,_,_,_],RegisterUsers).


% getSystemChatHistory
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSysteLoginUser([_,_,_,_,LoginUser,_,_,_],LoginUser).

% getSystemOptionsCbCL
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSystemChatHistories([_,_,_,_,_,ChatHistories,_,_],ChatHistories).

% getSystemOptionsIFCL
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSystemActualOptions([_,_,_,_,_,_,ActualOptions,_],ActualOptions).

% getSystemChatbots
% Dom:
% Meta primaria:
% Meta secundaria:
% Clausulas:
getSystemChatbots([_,_,_,_,_,_,_,Chatbots],Chatbots).


%....................Modificadores....................
% systemAddChatbot
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
systemAddChatbot([Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots] ,Chatbot,[Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots]):-
    getAllChatbotsIds(Chatbots,[],AllIds),
    getChatbotId(Chatbot,Id),
    member(Id,AllIds).

systemAddChatbot([Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots] ,Chatbot,[Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions,[Chatbot | Chatbots]]):-
    getAllChatbotsIds(Chatbots,[],AllIds),
    getChatbotId(Chatbot,Id),
    \+ member(Id,AllIds).

% systemAddUser
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
systemAddUser([Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots] ,User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots]):-
    member(User,RegisterUsers).

systemAddUser([Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,[User | RegisterUsers],LoginUser,[[User, ""]|ChatHistory],ActualOptions, Chatbots]):-
    \+ member(User,RegisterUsers).

% systemLogin
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
systemLogin([Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,[User],ChatHistory,ActualOptions, Chatbots]):-
    member(User,RegisterUsers),
    length(LoginUser,0).


systemLogin([Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],_,[Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots]).

% systemLogout
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
systemLogout([Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,_,ChatHistory,ActualOptions, Chatbots],[Name, InicialChatbotCodeLink,StartFlowCodeLink,RegisterUsers,[],ChatHistory,ActualOptions, Chatbots]).


%....................Otros....................
% appendChatbotById/4
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
appendChatbotById([],Chatbots,_,Chatbots).

appendChatbotById([Chatbot | RestChatbots],Chatbots,Ids,NewChatbots):-
    getChatbotId(Chatbot, Id),
    member(Id, Ids),
    appendChatbotById(RestChatbots,Chatbots,Ids,NewChatbots).

appendChatbotById([Chatbot | RestChatbots],Chatbots,Ids, NewChatbots):-
    getChatbotId(Chatbot, Id),
    \+ member(Id,Ids),
    appendChatbotById(RestChatbots,[Chatbot | Chatbots],[Id | Ids],NewChatbots).

% getAllFlowIds/3
% Dom:
% Meta primaria:
% Metas secundarias:
% Clausulas:
getAllChatbotsIds([],Ids,Ids).

getAllChatbotsIds([Chatbot | RestChatbots], Ids, AllIds):-
    getChatbotId(Chatbot,Code),
    getAllChatbotsIds(RestChatbots,[Code|Ids],AllIds).

%getStartFlowCodeLink
%
%
%
%
getStartFlowCodeLink(IdCb,[FirstCb | _],IdFlow):-
    getChatbotId(FirstCb,Id),
    Id = IdCb,
    getChatbotStartFlowId(FirstCb,IdFlow).

getStartFlowCodeLink(IdCb,[FirstCb | RemainingCbs],IdFlow):-
    getChatbotId(FirstCb,Id),
    \+ Id = IdCb,
    getStartFlowCodeLink(IdCb,RemainingCbs ,IdFlow).
