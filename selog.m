%This function is responsible for logging user's actions on the database into the logs table
%
%Author: Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

function selog(user , action )
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
action = strcat('"' , action , '"');
action = string(action);
date = datestr(now, 'mmmm dd, yyyy HH:MM:SS AM');
date = strcat('"' , date , '"');
date = string(date);
query = "Select COUNT(*) From `logs`";
t = fetch(exec(conn,query));
count = cell2mat(t.Data);
q = sprintf('INSERT INTO logs(`count`,`user`,`action`,`date`) VALUES(%d,%d,%s,%s);',count+1,user,action,date);
try
fetch(exec(conn,q))
catch ME
    rethrow(ME)
end
close(conn)
end