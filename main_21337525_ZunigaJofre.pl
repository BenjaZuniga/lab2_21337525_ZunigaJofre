?-consult('tdaSystem_21337525_ZunigaJofre.pl').
?-consult('tdaChatHistory_21337525_ZunigaJofre.pl').

%..............................RF1..............................

%....................TDA Option.....................
% Option = Code X Message X ChatbotCodeLink X InicialFlowCodeLink X
% Keyword
%
% Code = Int
% Message = String
% ChatbotCodeLink = Int
% InicialFlowCodeLink = Int
% Keyword = List

%....................TDA Flow.......................
% Flow = Id X NameMsg X Option
%
% Id = Int
% NameMsg = String
% Opion = List (Lista de TDA Option)

%....................TDA Chatbot....................
% Chatbot = ChatbotId X Name X WelcomeMessage X StartFlowId X Flows
%
% ChatbotId = Int
% Name = String
% WelcomeMessage = String
% StartFlowId = Int
% Flows = List(Lista compuesta de TDA Flow)

%....................TDA System....................
% System = Name X InicialChatbotCodeLink X StartFlowCodeLink X
% RegisterUsers X LoginUser X ActualOptions X Chatbots
%
% Name = String
% InicialChatbotCodeLink = Int
% StartFlowCodeLink = Int
% SimulateOn: Int
% RegisterUsers = List
% LoginUser = List
% ActuaOptions = List
% Chatbots = List

%....................TDA ChatHistory.....................
% ChatHistory = User X ChatString
%
% User = String
% ChatString = String

%..............................RF2..............................
% option/6
% Descripción: Pridicado que crea un TDA option
% Dominio: Code X Message X ChatbotCodeLink X InicialFlowCodeLink X
% Keyword X Option
% Meta primaria: option/6
% Metas secundarias: number_string/2, keywordDowncase/3
option(Code, Message, ChatbotCodeLink, InicialFlowCodeLink, Keyword, [Code, Message, ChatbotCodeLink, InicialFlowCodeLink, [Id |NewKeyword]]):-
    number_string(Code,Id),
    keywordDowncase(Keyword,[],NewKeyword).

%..............................RF3..............................
% flow/4
% Descripción: Predicado que crea el TDA Flow
% Dominio: Id X NameMsg X Options X Flow
% Meta primaria: flow/4
% Metas secundarias: appendById/4
flow(Id, NameMsg, Options, [Id, NameMsg, NewOption]):-
    appendById(Options, [], [],AuxOption),
    reverse(AuxOption,NewOption).

%..............................RF4..............................
% flowAddOption/3
% Descripción: Predicado de agrega un Option al Option de un Flow, solo
% si su Id no está repetido
% Dominnio: Flow X Option X NewFlow
% Meta primaria: flowAddOption/3
% Metas secundarias: getAllOptionsIds/3, getOptionCode/2, member/2
flowAddOption([Id,Name,Options],Option,[Id,Name,NewOptions]):-
    getAllOptionIds(Options,[],AllIds),
    getOptionCode(Option,Code),
    \+ member(Code,AllIds),
    reverse(Options,AuxOptions),
    reverse([Option|AuxOptions],NewOptions).

%..............................RF5..............................
% chatbot/6
% Descripción: Predicado que crea un TDA Chatbot
% Dominio: ChatbotId X Name X WelcomeMessage X StartFlowId X Flows X
% Flow
% Meta primaria: chatbot/6
% Metas secundarias: appendFlowById/4
chatbot(ChatbotId, Name, WelcomeMessage,StartFlowId, Flows, [ChatbotId, Name, WelcomeMessage,StartFlowId, NewFlows]):-
    appendFlowById(Flows,[], [], AuxFlows),
    reverse(AuxFlows, NewFlows).

%..............................RF6..............................
% chatbotAddFlow/3
% Descripción: Predicado que agrega un Flow a un Flows en base al Id, si
% el Id del Flow ya existe en el Flows del Chatbot, no agrega y
% retorna el Flows como estaba, sino lo está el Id lo agrega
% Dominio: Chatbot X Flow X NewChatbot
% Meta primaria: chatbotAddFlow/3
% Metas secundarias: getAllFlowIds/3, getFlowId/2, member/2
% appendFlow/3
chatbotAddFlow([ChatbotId, Name, WelcomeMessage,StartFlowId, Flows],Flow,[ChatbotId, Name, WelcomeMessage,StartFlowId, NewFlows]):-
    getAllFlowIds(Flows,[],AllIds),
    getFlowId(Flow,Id),
    \+ member(Id,AllIds),
    appendFlow(Flows, Flow, NewFlows).

%..............................RF7..............................
% system/4
% Descripción: Predicado que crea un System
% Dominio: Name X InicialChatbotCodeLink X Chatbots X System
% Meta primaria: system/4
% Metas secuandarias: appendChatbotById/4, getStartFlowCodeLink/3
system(Name, InicialChatbotCodeLink,Chatbots,[Name,InicialChatbotCodeLink, SFCL,0,[],[],[],[],NewChatbots]):-
        appendChatbotById(Chatbots,[],[],NewChatbots),
        getStartFlowCodeLink(InicialChatbotCodeLink,NewChatbots,SFCL).

%..............................RF8..............................
% systemAddChatbot/3
% Descripción: Predicado que agrega un Chatbot a un System solo si su Id
% no esta repetido en algún Chatbot del Chatbots del System
% Dominio: System X Chatbot X NewSystem
% Meta primaria: systemAddChatbot/3
% Metas secundarias: getAllChatbotsIds/3, getChatbotId/2, member/2
systemAddChatbot([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots] ,Chatbot,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions,[Chatbot | Chatbots]]):-
    getAllChatbotsIds(Chatbots,[],AllIds),
    getChatbotId(Chatbot,Id),
    \+ member(Id,AllIds).

%..............................RF9..............................
% systemAddUser/3
% Descripción: Predicado que agrega un Usuario al System si este no
% existe en el RegisterUsers del System
% Dominio: System X User X New System
% Meta primaria: systemAddUser/3
% Metas secundarias: member/2
systemAddUser([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,[User | RegisterUsers],LoginUser,[NewChatHistory|ChatHistory],ActualOptions, Chatbots]):-
    \+ member(User,RegisterUsers),
    chatHistory(User,NewChatHistory).

%..............................RF10..............................
% systemLogin/3
% Descripción: Predicado que Logea un usuario si no existe otro usuario
% logeado en el System y existe en el RegisterUsers del System
% Dominio: System X User X NewSystem
% Meta primaria: systemLogin
% Metas secundarias:

% Caso 1: Si el usuario está en RegisterUsers y no hay un usuario
% logeado, se logea e usuario
systemLogin([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,[User],ChatHistory,ActualOptions, Chatbots]):-
    member(User,RegisterUsers),
    length(LoginUser,0).

%..............................RF11..............................
% systemLogout/2
% Descripción: Se deslogea el usuario logeado si es que hay, sino
% devuelve un SYstem igual al ingresado
% Dominio: System X NewSystem
% Meta primaria: systemLogout/2
% Metas secundarias: Ninguna
systemLogout([Name, InicialChatbotCodeLink,StartFlowCodeLink,_,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],[Name, InicialChatbotCodeLink,StartFlowCodeLink,0,RegisterUsers,[],ChatHistory,ActualOptions, Chatbots]):-
    length(LoginUser, 1).

%..............................RF12..............................
% systemTalkRec/3
% Descripción: Predicado que permite conversar con el sistem de Chatbots
% Dominio: System X Message X NewSystem
% Meta primaria: systemTalkRec/3
% Metas secundarias: getChatAndSystem/4, searchRec/6, finOption/4

% Caso 1: Si hay un usuario logeado pero no hay ActualOptions se busca
% las opciones en base al InicialChatbotCodeLink y StartFlowCodeLink del
% System
systemTalkRec([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser |_],ChatHistory,ActualOptions, Chatbots],Message,NewSystem):-
    length(ActualOptions,0),
    getChatAndSystem([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser],ChatHistory,ActualOptions, Chatbots],[],AuxString,AuxSystem),
    string_lower(Message,DowncaseMessage),
    get_time(Time),
    number_string(Time,STime),
    string_concat(AuxString,STime,AuxString1),
    string_concat(AuxString1," - ",AuxString2),
    string_concat(AuxString2,LoginUser,AuxString3),
    string_concat(AuxString3,": ",AuxString4),
    string_concat(AuxString4,DowncaseMessage,AuxString5),
    string_concat(AuxString5,"\n",NewString),
    searchRec(InicialChatbotCodeLink,StartFlowCodeLink,Chatbots,NewString,AuxSystem,NewSystem).


% Caso 2:  Si hay un usuario logeado y hay ActualOptions se buscan
% las opciones en base al InicialChatbotCodeLink y StartFlowCodeLink del
% Option que contien en su Keyword el Message
systemTalkRec([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser |_],ChatHistory,ActualOptions, Chatbots],Message,NewSystem):-
    \+ length(ActualOptions,0),
    getChatAndSystem([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser],ChatHistory,ActualOptions, Chatbots],[],AuxString,AuxSystem),
    string_lower(Message,DowncaseMessage),
    findOption([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser],ChatHistory,ActualOptions, Chatbots],DowncaseMessage,ICbCL,SFCL),
    get_time(Time),
    number_string(Time,STime),
    string_concat(AuxString,STime,AuxString1),
    string_concat(AuxString1," - ",AuxString2),
    string_concat(AuxString2,LoginUser,AuxString3),
    string_concat(AuxString3,": ",AuxString4),
    string_concat(AuxString4,DowncaseMessage,AuxString5),
    string_concat(AuxString5,"\n",NewString),
    searchRec(ICbCL,SFCL,Chatbots,NewString,AuxSystem,NewSystem).

%..............................RF13..............................
% systemSynthesis/3
% Descripción: Predicado que busca y retorna el string del ChatHistory
% del usuario que se pide, que es su conversación con el sistema
% Dominio: System X User X ChatString
% Meta primaria: systemSynthesis/3
% Metas secundarias: Ninguna

% Caso base: Si el primer ChatHistory es del usuario pedido, se retorna
% su ChatString
systemSynthesis([_, _,_,_,_,_,[[User,ChatString]|_],_, _],User,ChatString).

% Caso 1:Si el primer ChatHistory no es del usuario pedido, se busca en
% el siguiente ChatHistory
systemSynthesis([_, _,_,_,_,_,[[UserChat,_]|Remaining],_, _],User,String):-
    \+ User = UserChat,
    systemSynthesis([_, _,_,_,_,_,[Remaining],_, _],User,String).

%..............................RF14..............................

% systemSimulate/4
% Descripción: Predicado que permite simular una conversacion con el
% sistema en base a una semilla y un numero de interacciones maximo
% Dominio: System X MaxInteractions X Seed X NewSystem
% Meta primaria: systemSimulate/4
% Metas secundarias: myRandom/2, getSystemActualOptions/2,
% systemTalkRec/3, systemLogout/2, systemAddUser/3, systemLogin/3,
% systemSimulate/4, getSystemActualOptions/2

% Caso 1:
systemSimulate(System,0,_,NewSystem):-
    systemLogout(System,NewSystem).

% Caso 2: Si el sistema no está simulando y hay un usuario logeado,
% primero lo desloguea, regstra y logea al usuario de la semilla y
% comienza a simular
systemSimulate(System,MaxInteractions,Seed,NewSystem):-
    getSystemSimulateOn(System,SO),
    SO = 0,
    getSystemLoginUser(System, LoginUser),
    length(LoginUser, 1),
    systemLogout(System,AuxSystem1),
    number_string(Seed,SSeed),
    string_concat("user",SSeed,NewUser),
    systemAddUser(AuxSystem1,NewUser,AuxSystem2),
    systemLogin(AuxSystem2,NewUser,AuxSystem3),
    systemTalkRec(AuxSystem3,"hola",[Name, InicialChatbotCodeLink,StartFlowCodeLink,_,RegisterUsers,LoginUser,ChatHistory,Options, Chatbots]),
    MI is MaxInteractions - 1,
    systemSimulate([Name, InicialChatbotCodeLink,StartFlowCodeLink,1,RegisterUsers,LoginUser,ChatHistory,Options, Chatbots],MI,Seed,NewSystem).

% Caso 3: Si el sistema no está simulando y no hay un usuario logeado,
% solo registra y logea al usuario de la semilla y comienza a
% simular
systemSimulate(System,MaxInteractions,Seed,NewSystem):-
    getSystemSimulateOn(System,SO),
    SO = 0,
    number_string(Seed,SSeed),
    string_concat("user",SSeed,NewUser),
    systemAddUser(System,NewUser,AuxSystem2),
    systemLogin(AuxSystem2,NewUser,AuxSystem3),
    systemTalkRec(AuxSystem3,"hola",[Name, InicialChatbotCodeLink,StartFlowCodeLink,_,RegisterUsers,LoginUser,ChatHistory,Options, Chatbots]),
    MI is MaxInteractions - 1,
    systemSimulate([Name, InicialChatbotCodeLink,StartFlowCodeLink,1,RegisterUsers,LoginUser,ChatHistory,Options, Chatbots],MI,Seed,NewSystem).


% Caso 4: Si ya se inicio una simulación se genera un nuevo numero
% aleatorio para encontrar un número de opcion aleatorio y se simula
% hasta que quede una interaccion por hacer
systemSimulate(System,MaxInteractions,Seed,NewSystem):-
    getSystemSimulateOn(System,SO),
    SO = 1,
    getSystemActualOptions(System,AO),
    myRandom(Seed,NewSeed),
    length(AO,L),
    L2 is L - 1,
    Option is NewSeed mod L2,
    Option1 is Option + 1,
    number_string(Option1,OptionMessage),
    systemTalkRec(System,OptionMessage,[Name, InicialChatbotCodeLink,StartFlowCodeLink,_,RegisterUsers,LoginUser,ChatHistory,Options, Chatbots]),
    MI is MaxInteractions - 1,
    systemSimulate([Name, InicialChatbotCodeLink,StartFlowCodeLink,1,RegisterUsers,LoginUser,ChatHistory,Options, Chatbots],MI,NewSeed,NewSystem).
