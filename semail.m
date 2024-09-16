%This function is responsible of save emails into the mails table.
%As inputs it takes from and to userid and also the text.Date is an input
%also.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.


function semail(from , to , text )
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
text = strcat('"' , text , '"');
text = string(text);
date = datestr(now, 'mmmm dd, yyyy HH:MM:SS AM');
date = strcat('"' , date , '"');
date = string(date);
query = "Select COUNT(*) From `mails`";
t = fetch(exec(conn,query));
count = cell2mat(t.Data);
q = sprintf('INSERT INTO mails(`count`,`from`,`to`,`text`,`date`) VALUES(%d,%d,%d,%s,%s);',count+1,from,to,text,date);
try
fetch(exec(conn,q))
catch ME
    rethrow(ME)
end
close(conn)
end