%This function takes as input's arguments userid value and then returns two
% tables.The firt table is the incoming mails and the second one about
% outcoming mails.These data are contained in mails SQL table.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function [incoming,outcoming] = mailspreview(userid)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
q=sprintf('SELECT `from`,`text`,`date` FROM `mails` WHERE `to`=%d',userid);
incoming =fetch(conn,q);
q = sprintf('SELECT `to`,`text`,`date` FROM `mails` WHERE `from`=%d',userid);
outcoming = fetch(conn,q);

close(conn)
end