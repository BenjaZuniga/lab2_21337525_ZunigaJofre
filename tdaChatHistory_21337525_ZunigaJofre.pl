%....................TDA ChatHistory.....................
% ChatHistory = User X ChatString
%
% User = String
% ChatString = String
%
%....................Constructor....................
% chatHistory/2
% Descripci�n: Predicado que crea un ChatHistory
% Dominio: User X ChatHistory
% Meta primaria: chatHistory/2
% Metas secundarias: Ninguna
chatHistory(User,[User,""]).
