?-consult('main_21337525_ZunigaJofre').

% Script Enunciado
/*
option(1, "1) Viajar", 1, 1, ["viajar", "turistear", "conocer"], OP1),
option(2, "2) Estudiar", 2, 1, ["estudiar", "aprender", "perfeccionarme"], OP2),
flow(1, "flujo1", [OP1], F10),
flowAddOption(F10, OP2, F11),
%flowAddOption(F10, OP1, F12), %si esto se descomenta, debe dar false, porque es opción con id duplicada.
chatbot(0, "Inicial", "Bienvenido\n¿Qué te gustaría hacer?", 1, [F11], CB0), %solo añade una ocurrencia de F11
%Chatbot1
option(1, "1) New York, USA", 1, 2, ["USA", "Estados Unidos", "New York"], OP3),
option(2, "2) París, Francia", 1, 1, ["Paris", "Eiffel"], OP4),
option(3, "3) Torres del Paine, Chile", 1, 1, ["Chile", "Torres", "Paine", "Torres Paine", "Torres del Paine"], OP5),
option(4, "4) Volver", 0, 1, ["Regresar", "Salir", "Volver"], OP6),
%Opciones segundo flujo Chatbot1
option(1, "1) Central Park", 1, 2, ["Central", "Park", "Central Park"], OP7),
option(2, "2) Museos", 1, 2, ["Museo"], OP8),
option(3, "3) Ningún otro atractivo", 1, 3, ["Museo"], OP9),
option(4, "4) Cambiar destino", 1, 1, ["Cambiar", "Volver", "Salir"], OP10),
option(1, "1) Solo", 1, 3, ["Solo"], OP11),
option(2, "2) En pareja", 1, 3, ["Pareja"], OP12),
option(3, "3) En familia", 1, 3, ["Familia"], OP13),
option(4, "4) Agregar más atractivos", 1, 2, ["Volver", "Atractivos"], OP14),
option(5, "5) En realidad quiero otro destino", 1, 1, ["Cambiar destino"], OP15),
flow(1, "Flujo 1 Chatbot1\n¿Dónde te Gustaría ir?", [OP3, OP4, OP5, OP6], F20),
flow(2, "Flujo 2 Chatbot1\n¿Qué atractivos te gustaría visitar?", [OP7, OP8, OP9, OP10], F21),
flow(3, "Flujo 3 Chatbot1\n¿Vas solo o acompañado?", [OP11, OP12, OP13, OP14, OP15], F22),
chatbot(1, "Agencia Viajes",  "Bienvenido\n¿Dónde quieres viajar?", 1, [F20, F21, F22], CB1),
%Chatbot2
option(1, "1) Carrera Técnica", 2, 1, ["Técnica"], OP16),
option(2, "2) Postgrado", 2, 1, ["Doctorado", "Magister", "Postgrado"], OP17),
option(3, "3) Volver", 0, 1, ["Volver", "Salir", "Regresar"], OP18),
flow(1, "Flujo 1 Chatbot2\n¿Qué te gustaría estudiar?", [OP16, OP17, OP18], F30),
chatbot(2, "Orientador Académico",  "Bienvenido\n¿Qué te gustaría estudiar?", 1, [F30], CB2),
system("Chatbots Paradigmas", 0, [CB0], S0),
% systemAddChatbot(S0, CB0, S1), %si esto se descomenta, debe dar false, porque es chatbot id duplicado.
systemAddChatbot(S0, CB1, S01),
systemAddChatbot(S01, CB2, S02),
systemAddUser(S02, "user1", S2),
systemAddUser(S2, "user2", S3),
% systemAddUser(S3, "user2", S4), %si esto se descomenta, debe dar false, porque es username duplicado
systemAddUser(S3, "user3", S5),
% systemLogin(S5, "user8", S6), %si esto se descomenta, debe dar false ;user8 no existe.
systemLogin(S5, "user1", S7),
% systemLogin(S7, "user2", S8), %si esto se descomenta, debe dar false, ya hay usuario con login
systemLogout(S7, S9),
systemLogin(S9, "user2", S10),
systemTalkRec(S10, "hola", S11),
systemTalkRec(S11, "1", S12),
systemTalkRec(S12, "1", S13),
systemTalkRec(S13, "Museo", S14),
systemTalkRec(S14, "1", S15),
systemTalkRec(S15, "3", S16),
systemTalkRec(S16, "5", S17),
systemSynthesis(S17, "user2", Str1),
write(Str1),
systemSimulate(S02, 5, 32131, S99),
systemSynthesis(S99, "user32131", Str2),
write(Str2).
*/

% Mi Script
/*
%------option
% Opciones iniciales
option( 1,"1)Noticias nacionales", 1, 1, ["nacional", "Chile", "NACIONALES"], Op01),
option( 2, "2)Noticias internacionales", 2, 1, ["INTER", "internacional", "extranjero"], Op02),
option( 3, "3)Por tema", 3, 1, ["tema", "TOPICO", "otras"], Op03),
% Opciones FLujo 1 Chatbot 1
option( 1, "1)Noticias de Santiago", 1, 2, ["Santiago", "capital", "RM"], Op11),
option( 2, "2)Noticias de Valparaiso", 1, 2, ["Valparaiso", "Quinta region"], Op12),
option( 3, "3)Noticias de Antofagasta", 1, 2, ["NORTE", "Antofagasta"], Op13),
option( 4, "4)Noticias de Chiloe", 1, 2, ["Sur", "chiloe"], Op14),
option( 5, "5)Volver", 0, 1,  ["volver", "ATRAS", "Regresar"], Op15),
% Opciones Flujo 2 Chatbot 1
option( 1, "1)Robo a un banco", 1, 2, ["ROBO", "banco", "Asalto"], Op16),
option( 2, "2)Proximos proyectos para la ciudad", 1, 2, ["proximo", "Proyectos"], Op17),
option( 3, "3)Volver", 1, 1,  ["volver", "ATRAS", "Regresar"], Op18),
% Opciones Flujo 1 Chatbot 2
option( 1, "1)Noticias de USA", 2, 2, ["usa", "Norteamerica", "ESTADOS UNIDOS"], Op21),
option( 2, "2)Noticias de Brasil", 2, 1, ["BRASIL"], Op22),
option( 3, "3)Noticias de Francia", 2, 1, ["Francia", "Europa"], Op23),
option( 4, "4)Volver", 0, 1,  ["volver", "ATRAS", "Regresar"], Op24),
% Opciones Flujo 2 Chatbot 2
option( 1, "1)Elon Musk anuncia nuevo proyecto", 2, 2, ["ELON", "Musk", "nuevo"], Op25),
option( 2, "2)Estados Unidos anuncia nuevos estadios para el proximo mundial de futbol", 2, 2, ["mundial", "Futbol"], Op26),
option( 3, "4)Volver", 2, 1,  ["volver", "ATRAS", "Regresar"], Op27),
% Opciones Flujo 1 Chatbot 3
option( 1, "1)Noticias de Economia", 3, 2, ["Economia", "FINANZAS"], Op31),
option( 2, "2)Noticias de Deporte", 3, 3, ["DEPORTES", "deporte", "Ejercicio"], Op32),
option( 3, "3)Volver", 0, 1,  ["volver", "ATRAS", "Regresar"], Op33),
% Opciones Flujo 2 Chatbot 3
option( 1, "1)Cambia el valor del dolar", 3, 2,  ["cambio", "DOLAR", "Valor"], Op34),
option( 2, "2)Proyecto para reducir la inflación", 3, 2, ["reducir", "INFLACION"], Op35),
option( 3, "3)Volver", 3, 1,  ["volver", "ATRAS", "Regresar"], Op36),
% Opciones Flujo 3 Chatbot 2
option( 1, "1)Mundial de Futbol 2026", 3, 3, ["MUNDIAL", "futbol", "2026"], Op37),
option( 2, "2)Juegos Olimpicos 2024", 3, 3, ["juegos", "OLIMPIADAS", "Olimpicos", "JJOO", "2024"], Op38),
option( 3, "3)Volver", 3, 1,  ["volver", "ATRAS", "Regresar"], Op39),


% Creacion flujos
%--------flow

% flow( 1, "Flujo Inicial Chatbot0\n Bienvenido\n ¿Qué tipo de noticia quieres ver?", [Op01, Op01, Op02, Op01, Op03], Fl01), % Si se descomenta da false poruq hay opciones repetidas

% Se crea uno flow vacio
flow( 1, "Flujo Inicial Chatbot0\n Bienvenido\n ¿Qué tipo de noticia quieres ver?", [], Fl02),

flow( 1, "Flujo 1 Chatbot1\n Bienvenido\n ¿De dónde quieres ver noticias?", [Op11,Op12, Op13,Op14,Op15], Fl11 ),
flow( 2, "Flujo 2 Chatbot1\n Bienvenido\n ¿Que noticia quieres ver?", [Op16, Op17, Op18], Fl12 ),
flow( 1, "Flujo 1 Chatbot2\n Bienvenido\n ¿De dónde quieres ver noticias?", [Op21, Op22, Op23, Op24], Fl21),
flow( 2, "Flujo 2 Chatbot2\n Bienvenido\n ¿Que noticia quieres ver?", [Op25, Op26, Op27],Fl22 ),
flow( 1, "Flujo 1 Chatbot3\n Bienvenido\n ¿Que tema te interesa?", [Op31, Op32, Op33],Fl31 ),
flow( 2, "Flujo 2 Chatbot3\n Bienvenido\n ¿Que noticia quieres ver?", [Op34, Op35, Op36],Fl32 ),
flow( 3, "Flujo 3 Chatbot3\n Bienvenido\n ¿Que noticia quieres ver?", [Op37, Op38, Op39], Fl33 ),

%--------flowAddOption
flowAddOption(Fl02, Op01, Fl03),
flowAddOption(Fl03, Op02, Fl04),
flowAddOption(Fl04, Op03, Fl05),
% flowAddOption(Fl11, Op11, Fl13), %Si se descomenta da false por intentar agregar una opcion repetida

% Creacion Chatbots
%--------chatbot
% chatbot( 0, "Inicial", "Bienvenido\n", 1, [Fl05,Fl05],Cb0), %Si se descomenta da false por intentar agregar un flujo repetido
chatbot( 0, "Inicial", "Bienvenido\n", 1, [Fl05],Cb01),
chatbot( 1, "Noticias Nacionales", "Bienvenido\n", 1, [Fl11, Fl12] , Cb1),
chatbot( 2, "Noticias Internacionales", "Bienvenido\n", 1, [Fl21, Fl22], Cb2 ),
chatbot( 3, "Noticias por tema", "Bienvenido\n", 1,[], Cb3),

%-------chatbotAddFlow
% chatbotAddFlow( Cb01, Fl05, Cb02), % Si se descomenta da false
chatbotAddFlow( Cb3, Fl31, Cb31),
chatbotAddFlow( Cb31, Fl32, Cb32),
chatbotAddFlow( Cb32, Fl33, Cb33),

% Creacion system
%--------system
system("Chatbots Noticias", 0,[Cb01],Sy0 ),
system("Chatbots Noticias", 0, [Cb01, Cb1, Cb2, Cb33], Sy10),
% system("Chatbots Noticias", 0, [Cb01, Cb1, Cb2, Cb33, Cb1, Cb33], Sy1), % Si se descomenta da false
system("Chatbots Noticias", 0, [Cb33, Cb01, Cb1, Cb2],Sy2),

%--------systemAddChatbot
systemAddChatbot( Sy0, Cb1, Sy01),
systemAddChatbot( Sy01, Cb2, Sy02),
systemAddChatbot( Sy02, Cb33, Sy03),
% systemAddChatbot(Sy2, Cb01,Sy21),%Si se descomenta da false

%--------systemAddUser
systemAddUser( Sy03, "user1",Sy05),
% systemAddUser( Sy03, "user1",Sy06), %Si se descomenta da false
systemAddUser( Sy05, "user2", Sy06),
systemAddUser( Sy06, "user5", Sy07),
systemAddUser( Sy2, "user1",Sy21),

%--------systemLogin
systemLogin( Sy07, "user1", Sy08),
systemLogin( Sy21, "user1", Sy22),
% systemLogin( Sy10, "user1",Sy11), % SI se descomenta da false

%--------systemLogout
systemLogout(Sy08,Sy09),
systemLogout(Sy22,Sy23),
% systemLogout(Sy09,Sy010), % Si se descomenta da false


systemLogin(Sy09, "user5", Sy010),

%--------systemTalRec
systemTalkRec( Sy010, "Hola", Sy011),
systemTalkRec( Sy011, "nacional", Sy012),
systemTalkRec( Sy012, "1", Sy013),
%systemTalkRec( Sy23, "1", Sy24), % Si se descomenta da false

%--------systemSynthesis y systemSimulate
systemSynthesis(Sy013, "user5", Str1),
write(Str1),


systemSimulate( Sy10, 4 ,1407, Sy12),
systemSynthesis( Sy12, "user1407",Str2),
write(Str2),

systemSimulate( Sy10, 4, 789, Sy15),
systemSynthesis( Sy15, "user789", Str3),
%write(Str3),

systemSimulate( Sy23, 6, 999999,Sy25),
systemSynthesis( Sy25, "user999999",Str4).
%write(Str4).
*/

