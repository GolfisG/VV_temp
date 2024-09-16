%This function changes the status of generators on the mpc using the data from
%the database

%Author:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

function genchange()
clc;clear all;

javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');


selectquery = 'SELECT * FROM gen';
data3 = select(conn,selectquery);
data3 = table2array(data3);

chgtab = [3 1 2 1 8 1 0
           3 1 2 2 8 1 0
           3 1 2 3 8 1 0
           3 1 2 4 8 1 0
           3 1 2 5 8 1 0
           3 1 2 6 8 1 0
           3 1 2 7 8 1 0
           3 1 2 8 8 1 0
           3 1 2 9 8 1 0
           3 1 2 10 8 1 0
           3 1 8 1 2 2 0.5
           3 1 8 2 2 2 0.5
           3 1 8 3 2 2 0.5];



 for i = 1:10
     chgtab(i,7) = data3(i,9);
 end


mpc_new = apply_changes(3,mpc,chgtab);



  


         