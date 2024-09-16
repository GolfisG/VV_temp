%This functions establish a connection between Energy Exchange Application
%and the database , through Internet and also it sends the appropriate credentials into our server.
%As inputs it takes an SQL query and send it in our database.The result of
%each query is returned in res for further manipulation.
%It is also used exceptions handling techniques in case of server failure.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.


function res = sql(query)
try
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
res = fetch(conn , query);
catch ME
   rethrow(ME)
end
close(conn)
end