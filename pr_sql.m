%This function takes as input roundsid and then calculates profits for the
%defined users.Firstly it downloads gen's data about the Pg after market
%clearing and then with help of profit() function calculates wach user's
%profit.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.
function pr_sql(r)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query = "SELECT * FROM gen";
res = fetch(conn, query);
t = size(res,1);
for i=1:10
[pg pr] = profit(i,r);
query = sprintf("UPDATE `gen_hist` SET `profit` = '%f' WHERE (`gen_hist`.`userid` = %d AND `gen_hist`.`roundid` = %d)",pr ,i , r);
res = fetch(exec(conn,query));
end
disp("Market Clearing DONE.....") 
%close(conn)
end