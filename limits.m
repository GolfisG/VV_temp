%This function saves the load changes in the database
%
%Authors:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.


function limits(table)

javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
table = table2array(table);
for i = 1:46
    query = sprintf("UPDATE `limits` SET  `limitchange`= %d WHERE `limits`.`branchid` = %d",table(i,5),i);
    exec(conn,query)
end


close(conn)
end