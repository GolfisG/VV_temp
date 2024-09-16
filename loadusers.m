%This function draws data concerning the users from the database
%
%Author:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

function [incoming] = loadusers(userid)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
q=sprintf('SELECT * FROM `loads` WHERE `userid`=%d',userid);
incoming = fetch(conn,q);
close(conn)

