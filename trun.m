%This method runs under Admin's button Turncate and its responsible to
%empty all tables and then call the method case0() to setup the default
%case.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.


function trun(fname)

disp("fname:")
fprintf("%s",fname)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
tables = ["gen_hist" , "gencost_hist", "bus_hist" , "branch_hist","gen" , "gencost" , "bus" , "branch" , "rounds_info","actualcost", "actualcost_hist","mails","logs","loads","limits"];

for i=1:size(tables,2)
query = sprintf('TRUNCATE `%s`', tables(1,i));
exec(conn , query);
end

case0(fname)
end