?-consult('tdaChatbot_21337525_ZunigaJofre.pl').

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

%....................Constructor....................
% system/4
% Descripci�n: Predicado que crea un System
% Dominio: Name X InicialChatbotCodeLink X Chatbots X System
% Meta primaria: system/4
% Metas secuandarias: appendChatbotById/4, getStartFlowCodeLink/3
/*system(Name, InicialChatbotCodeLink,Chatbots,[Name,InicialChatbotCodeLink, SFCL,0,[],[],[],[],NewChatbots]):-
        appendChatbotById(Chatbots,[],[],NewChatbots),
        getStartFlowCodeLink(InicialChatbotCodeLink,NewChatbots,SFCL).*/
%....................Pertenencia....................

%....................Selectores....................
% getSystemName/2
% Descripci�n: Predicado que entrega el Name de un System
% Dominio: System X Name
% Meta primaria: getSystemName/2
% Metas secundarias: Ninguna
getSystemName([Name,_,_,_,_,_,_,_,_],Name).

% getSystemICbCl/2
% Descripci�n: Predicado que entrega el InicialChatbotCodeLink de un
% System
% Dominio: System X InicialChatbot
% Meta primaria: getSystemICbCL/2
% Metas secundarias: Ninguna
getSystemICbCL([_,InicialChatbotCodeLink,_,_,_,_,_,_,_],InicialChatbotCodeLink).

% getSystemRegisterUsers/2
% Descripci�n: Predicado que entrega el StartFlowCode de un System
% Dominio: System X StartFlowCode
% Meta primaria: getSystemRegisterUsers/2
% Metas secundarias: Ninguna

getSystemSFCL([_,_,SFCL,_,_,_,_,_,_],SFCL).

% getSystemSimulateOn/2
% Descripci�n: Predicado que entrega el SimulateOn de un System
% Dominio: System X SimulateOn
% Meta primaria: getSystemSimulateOn/2
% Metas secundarias: Ninguna
getSystemSimulateOn([_,_,_,SimulateOn,_,_,_,_,_],SimulateOn).

% getSystemRegistersUsers/2
% Descripci�n: Predicado que entrega el RegistersUsers de un System
% Dominio: System X RegistersUsers
% Meta primaria: getSystemRegisterUsers/2
% Metas secundarias: Ninguna
getSystemRegisterUsers([_,_,_,_,RegisterUsers,_,_,_,_],RegisterUsers).


% getSystemLoginUser/2
% Descripci�n: Predicado que entrega el LoginUser de un System
% Dominio: System X LoginUser
% Meta primaria: getSystemLoginUser/2
% Metas secundarias: Ninguna
getSystemLoginUser([_,_,_,_,_,LoginUser,_,_,_],LoginUser).

% getSysteChatHistory/2
% Descripci�n: Predicado que entrega el ChatHistory de un System
% Dominio: System X ChatHistory
% Meta primaria: getSystemChatHistory/2
% Metas secundarias: Ninguna
getSystemChatHistory([_,_,_,_,_,_,ChatHistories,_,_],ChatHistories).

% getSystemActualOptions/2
% Descripci�n: Predicado que emtrega el ActualOptions de un System
% Dominio: System X ActualOptions
% Meta primaria: getSystemActualOptions/2
% Metas secundarias: Ninguna
getSystemActualOptions([_,_,_,_,_,_,_,ActualOptions,_],ActualOptions).

% getSystemChatbots/2
% Descripci�n: Predicado que entrega el Chatbots de un System
% Dominio: System X Chatbots
% Meta primaria: getSystemChatbots/2
% Metas secundarias: Ninguna
getSystemChatbots([_,_,_,_,_,_,_,_,Chatbots],Chatbots).


%....................Modificadores....................
% systemAddChatbot/3
% Descripci�n: Predicado que agrega un Chatbot a un System solo si su Id
% no esta repetido en alg�n Chatbot del Chatbots del System
% Dominio: System X Chatbot X NewSystem
% Meta primaria: systemAddChatbot/3
% Metas secundarias: getAllChatbotsIds/3, getChatbotId/2, member/2

% Caso 1: Si el id del Chatbot est� repetido se regresa el System sin
% modificaciones
/*systemAddChatbot([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots] ,Chatbot,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots]):-
    getAllChatbotsIds(Chatbots,[],AllIds),
    getChatbotId(Chatbot,Id),
    member(Id,AllIds).*/

% Caso 2: Si el Id del Chatbot no est� repetido se retorna un System con
% el Chatbot agregado
/*systemAddChatbot([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots] ,Chatbot,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions,[Chatbot | Chatbots]]):-
    getAllChatbotsIds(Chatbots,[],AllIds),
    getChatbotId(Chatbot,Id),
    \+ member(Id,AllIds).*/

% systemAddUser/3
% Descripci�n: Predicado que agrega un Usuario al System si este no
% existe en el RegisterUsers del System
% Dominio: System X User X New System
% Meta primaria: systemAddUser/3
% Metas secundarias: member/2

% Caso 1:
/*systemAddUser([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots] ,User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots]):-
    member(User,RegisterUsers).*/


% Caso 2:
/*systemAddUser([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,[User | RegisterUsers],LoginUser,[[User, ""]|ChatHistory],ActualOptions, Chatbots]):-
    \+ member(User,RegisterUsers).*/


% systemLogin/3
% Descripci�n: Predicado que Logea un usuario si no existe otro usuario
% logeado en el System y existe en el RegisterUsers del System
% Dominio: System X User X NewSystem
% Meta primaria: systemLogin
% Metas secundarias:

% Caso 1: Si el usuario est� en RegisterUsers y no hay un usuario
% logeado, se logea e usuario
/*systemLogin([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],User,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,[User],ChatHistory,ActualOptions, Chatbots]):-
    member(User,RegisterUsers),
    length(LoginUser,0).*/

% CAso 2: Sino devuelve el un system igual al ingresado
/*systemLogin([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],_,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots]).*/

% systemLogout/2
% Descripci�n: Se deslogea el usuario logeado si es que hay, sino
% devuelve un SYstem igual al ingresado
% Dominio: System X NewSystem
% Meta primaria: systemLogout/2
% Metas secundarias: Ninguna
/*systemLogout([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,_,ChatHistory,ActualOptions, Chatbots],[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,[],ChatHistory,ActualOptions, Chatbots]).*/


%....................Otros....................
% appendChatbotById/4
% Descripci�n: Predicado que genera un Chatbots en base a los Ids de los
% Chatbot, sin Ids repetido
% Dominio: Chatbots X AuxChatbots X Ids X NewChatbots
% Meta primaria: appendChatbotById/4
% Metas secundarias: getChatbotId/2, appendChatbotById/4

% Caso base: Si Chatbots es vacio retorna el acumulador de los Chatbot
appendChatbotById([],Chatbots,_,Chatbots).


% Caso 1:Si el Id del primer Chatbot no ha sido agregado, se acumula
% y se sigue con el resto de Chatbots
appendChatbotById([Chatbot | RestChatbots],Chatbots,Ids, NewChatbots):-
    getChatbotId(Chatbot, Id),
    \+ member(Id,Ids),
    appendChatbotById(RestChatbots,[Chatbot | Chatbots],[Id | Ids],NewChatbots).

% getAllChatbotsIds/3
% Descripci�n: Predicado que entrega una lista con todos los Ids de los
% Chatbot que componen un Chatbots
% Dominio: Chatbots X Ids X AllIds
% Meta primaria: getAllChatbotsIds/3
% Metas secundarias: getChatbotId/2, getAllChatbotsIds/3

% Caso base: Si el Chatbots es vacio, se retorna el acumulador de Ids
getAllChatbotsIds([],Ids,Ids).

% Caso 1: Se toma el Id del primer Chatbot, se guarda en el acumulador y
% se sigue con el resto de Chatbots
getAllChatbotsIds([Chatbot | RestChatbots], Ids, AllIds):-
    getChatbotId(Chatbot,Code),
    getAllChatbotsIds(RestChatbots,[Code|Ids],AllIds).

% getStartFlowCodeLink/3
% Descripci�n: Predicado que busca el StartFlowId del Chatbot inicial,
% es decir, que su Id es el InicialChatbotCodeLink de un System
% Dominio: InicialChatbotCodeLink X Chatbots X StartFlowId
% Meta primaria: getStartFlowCodeLink/3
% Metas secundarias: getChatbotId/2, getChatbotStartFlowId/2,
% getStartFlowCodeLink/3

% Caso 1: Si el Id primer Chatbot de un Chatbots es igual al
% InicialChatbotCodeLink de un System, retorna su StartFlowId
getStartFlowCodeLink(IdCb,[FirstCb | _],IdFlow):-
    getChatbotId(FirstCb,Id),
    Id = IdCb,
    getChatbotStartFlowId(FirstCb,IdFlow).

% Caso 2: Si el Id primer Chatbot de un Chatbots no es igual al
% InicialChatbotCodeLink de un System, se busca el Chatbot que cumpla en
% el resto de Chatbots
getStartFlowCodeLink(IdCb,[FirstCb | RemainingCbs],IdFlow):-
    getChatbotId(FirstCb,Id),
    \+ Id = IdCb,
    getStartFlowCodeLink(IdCb,RemainingCbs ,IdFlow).

% getChatAndSystem/4
% Descripci�n: Predicado que retorna el string del historial del usuario
% logeado de un System y el System con el ChatHistory sin el del usuario
% logeado
% Dominio: System X AuxChats X ChatString X NewSystem
% Meta primaria: getChatAndSystem/4
% Metas secundarias: getChatAndSystem/4

% Caso 1: Si el primer ChatHistory en el contenedor de ChatHistory
% pertenece al usuario logeado, retorna su string de historial y un
% System con el contenedor de ChatHistory sin el del usuario logeado
getChatAndSystem([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,[User|_],[[UserCh , ChatString]| Remaining],ActualOptions, Chatbots],Acc,ChatString,[Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,[User],NewChat,ActualOptions, Chatbots]):-
    User=UserCh,
    append(Remaining, Acc,NewChat).

% Caso 2: Si el primer ChatHistory en el contenedor de ChatHistory no
% pertenece al usuario logeado, guarda el primerChatHistory en un
% acumulador y busca en a cola del contenedor de ChatHistory
getChatAndSystem([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,[User|_],[First| Remaining],ActualOptions, Chatbots],Acc,ChatString,NewSystem):-
    \+ member(User,First),
    getChatAndSystem([Name, InicialChatbotCodeLink,StartFlowCodeLink,SO,RegisterUsers,[User],Remaining,ActualOptions, Chatbots],[First|Acc],ChatString,NewSystem).

% findOption/4
% Descripci�n: Predicado que busca en el Actualoptions de un System el
% Option que contiene un string en especifico en su Keyword y retorna su
% ChatbotCodeLink y FlowCodeLink
% Dominio: System X Message X ChatbotCodeLink X FlowCodeLink
% Meta primaria: finOption/4
% Metas secundarias: getOptionKeyword/2, getOption IFCL/2,
% getOptionCbCL/2, finOption/4

% Caso 1: Si la primera Option del ActualOptions contiene en su Keyword
% el Message retorna el ChatbotCodeLink y FlowCodeLink de la Option
findOption([_, _,_,_,_,_,_,[First | _],_],Message,CbCL,FCL):-
    getOptionKeyword(First,Kw),
    member(Message,Kw),
    getOptionIFCL(First,FCL),
    getOptionCbCL(First,CbCL).

% Caso 2: Si la primera Option del ActualOptions no contiene en su
% Keyword el Message, se busca en la cola del ActualOptions
findOption([_, _,_,_,_,_,_,[First | Remaining],_],Message,CbCL,FCL):-
    getOptionKeyword(First,Kw),
    \+ member(Message,Kw),
    findOption([_, _,_,_,_,_,_,Remaining,_],Message,CbCL,FCL).

% systemTalkRec/3
% Descripci�n: Predicado que permite conversar con el sistem de Chatbots
% Dominio: System X Message X NewSystem
% Meta primaria: systemTalkRec/3
% Metas secundarias: getChatAndSystem/4, searchRec/6, finOption/4

% Caso 1: Si no hay un usuario logeado en el sistema no se hace nada
/*systemTalkRec([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots],_,[Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,LoginUser,ChatHistory,ActualOptions, Chatbots]):-
    length(LoginUser,0).*/


% Caso 2: Si hay un usuario logeado pero no hay ActualOptions se busca
% las opciones en base al InicialChatbotCodeLink y StartFlowCodeLink del
% System
/*systemTalkRec([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser|_],ChatHistory,ActualOptions, Chatbots],Message,NewSystem):-
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
    searchRec(InicialChatbotCodeLink,StartFlowCodeLink,Chatbots,NewString,AuxSystem,NewSystem).*/


% Caso 3:  Si hay un usuario logeado y hay ActualOptions se buscan
% las opciones en base al InicialChatbotCodeLink y StartFlowCodeLink del
% Option que contien en su Keyword el Message
/*systemTalkRec([Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser|_],ChatHistory,ActualOptions, Chatbots],Message,NewSystem):-
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
    searchRec(ICbCL,SFCL,Chatbots,NewString,AuxSystem,NewSystem).*/


% searchRec/6
% Descripci�n: Predicado que busca el Chatob y Flow que tienen el Id
% correspondiente a buscar y retorna un System con las Opciones del Flow
% correcto en ActualOptions y en el contenedor de ChatHistory retorna el
% del usuario logeado acualizado
% Dominio: InicialChatbotCodeLink X StartFlowCodeLink X TDAsContainer X
% ChatString X System X NewSystem
% Meta primaria: searchRec/6
% Metas secundarias: isChatbot/1, getChatbotId/2, getChatbotFlows/2,
% getChatbotName/2, searchRec/6, isFlow/1, getFlowId/2, getFlowOption/2,
% getFlowName/2, getAllOptionMessages/3

% Caso 1: Si el primer elemento del contenedor de TDAs es un chatbot y
% su Id coincide con el que se est� buscando se a�ade al string lo que
% corresponde y se busca en los flows de ese Chatbot
searchRec(ICbCL,SFCL,[FirstCb|_],ChatString,AuxSystem,NewSystem):-
    isChatbot(FirstCb),
    getChatbotId(FirstCb,Id),
    Id = ICbCL,
    getChatbotFlows(FirstCb,Flows),
    getChatbotName(FirstCb,Name),
    get_time(Time),
    number_string(Time,STime),
    string_concat(ChatString,STime,AuxString1),
    string_concat(AuxString1,"-",AuxString2),
    string_concat(AuxString2,Name,AuxString3),
    string_concat(AuxString3,": ",NewString),
    searchRec(_,SFCL,Flows,NewString,AuxSystem,NewSystem).


% Caso 2: Si el primer elemento del contenedor de TDAs es un Chatbot y
% no coincide su Id con el que se est� buscando se sigue buscando con el
% resto de chatbots
searchRec(ICbCL,SFCL,[FirstCb|Remaining],ChatString,AuxSystem,NewSystem):-
    isChatbot(FirstCb),
    getChatbotId(FirstCb,Id),
    \+ Id = ICbCL,
    searchRec(ICbCL,SFCL,Remaining,ChatString,AuxSystem,NewSystem).

% Caso 3: Si el primer elemento del contenedor de TDAs es un chatbot y
% su Id coincide con el que se est� buscando se a�ade al string lo que
% corresponde y se genera el nuevo sistema con las opciones de ese flow
% y el ChatHistory actualizado
searchRec(_,SFCL,[FirstFlow|_],ChatString,[Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser|_],ChatHistory,_, Chatbots],[Name, InicialChatbotCodeLink,StartFlowCodeLink,So,RegisterUsers,[LoginUser],[[LoginUser,NewString]|ChatHistory],Options, Chatbots]):-
    isFlow(FirstFlow),
    getFlowId(FirstFlow,Id),
    Id = SFCL,
    getFlowOption(FirstFlow,Options),
    getFlowName(FirstFlow,FlowName),
    string_concat(ChatString,FlowName,AuxString1),
    string_concat(AuxString1,"\n",AuxString2),
    getAllOptionMessages(Options,AuxString2,NewString).

% Caso 4: Si el primer elemento del contenedor de TDAs es un Flow y
% no coincide su Id con el que se est� buscando se sigue buscando con el
% resto de flows
searchRec(_,SFCL,[FirstFlow|Remaining],ChatString,AuxSystem,NewSystem):-
    isFlow(FirstFlow),
    getFlowId(FirstFlow,Id),
    \+ Id = SFCL,
    searchRec(_,SFCL,Remaining,ChatString,AuxSystem,NewSystem).

% systemSynthesis/3
% Descripci�n: Predicado que busca y retorna el string del ChatHistory
% del usuario que se pide, que es su conversaci�n con el sistema
% Dominio: System X User X ChatString
% Meta primaria: systemSynthesis/3
% Metas secundarias: Ninguna

% Caso base: Si el primer ChatHistory es del usuario pedido, se retorna
% su ChatString
/*systemSynthesis([_, _,_,_,_,_,[[User,ChatString]|_],_, _],User,ChatString).*/

% Caso 1:Si el primer ChatHistory no es del usuario pedido, se busca en
% el siguiente ChatHistory
/*systemSynthesis([_, _,_,_,_,_,[[UserChat,_]|Remaining],_, _],User,String):-
    \+ User = UserChat,
    systemSynthesis([_, _,_,_,_,_,[Remaining],_, _],User,String).*/

% myRandom/2
% Descripci�n: Predicado que genera un n�mero pseudo-aleatorio
% respetando el principio de transparencia referencial
% Dominio: Int X Int
% Meta primaria: myRandom/2
% Metas secundarias: Ninguna
myRandom(Xn, Xn1):-
	MulTemp is 1103515245 * Xn,
	SumTemp is  12345 + MulTemp,
	Xn1 is SumTemp mod 2147483648.
