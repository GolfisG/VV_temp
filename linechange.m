%This function changes the status of lines on the mpc using the data from
%the database

%Author:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

function linechange()


javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

mpc.version = '2';
mpc.baseMVA = 100;
res = sql('SELECT * FROM branch')
mpc.branch = table2array(res(:,2:end))
res = sql('SELECT * FROM bus')
mpc.bus = table2array(res);
res1=sql('SELECT * FROM gen')
mpc.gen = table2array(res1(:,2:end))
res2=sql('SELECT * FROM gencost')
mpc.gencost= table2array(res2(:,2:end))

selectquery = 'SELECT * FROM branch';
data = select(conn,selectquery);
data = table2array(data);
disp(data);

chg_tab = [1 1 3 1 11 1 0
           1 1 3 2 11 1 0
           1 1 3 3 11 1 0
           1 1 3 4 11 1 0
           1 1 3 5 11 1 0
           1 1 3 6 11 1 0
           1 1 3 7 11 1 0
           1 1 3 8 11 1 0
           1 1 3 9 11 1 0
           1 1 3 10 11 1 0
           1 1 3 11 11 1 0
           1 1 3 12 11 1 0
           1 1 3 13 11 1 0
           1 1 3 14 11 1 0
           1 1 3 15 11 1 0
           1 1 3 16 11 1 0
           1 1 3 17 11 1 0
           1 1 3 18 11 1 0
           1 1 3 19 11 1 0
           1 1 3 20 11 1 0
           1 1 3 21 11 1 0
           1 1 3 22 11 1 0
           1 1 3 23 11 1 0
           1 1 3 24 11 1 0
           1 1 3 25 11 1 0
           1 1 3 26 11 1 0
           1 1 3 27 11 1 0
           1 1 3 28 11 1 0
           1 1 3 29 11 1 0
           1 1 3 30 11 1 0
           1 1 3 31 11 1 0
           1 1 3 32 11 1 0
           1 1 3 33 11 1 0
           1 1 3 34 11 1 0
           1 1 3 35 11 1 0
           1 1 3 36 11 1 0
           1 1 3 37 11 1 0
           1 1 3 38 11 1 0
           1 1 3 39 11 1 0
           1 1 3 40 11 1 0
           1 1 3 41 11 1 0
           1 1 3 42 11 1 0
           1 1 3 43 11 1 0
           1 1 3 44 11 1 0
           1 1 3 45 11 1 0
           1 1 3 46 11 1 0];

 for i = 1:46
     chg_tab(i,7) = data(i,12);
 end


mpc_new = apply_changes(1,mpc,chg_tab);
disp(mpc_new.branch)



