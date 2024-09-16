%This function changes the status of the generators on the database

%Authors:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

function shgen(r,s)

conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
switch s
    case 0
        q = sprintf("UPDATE gen SET status = 0 WHERE userid=%d" , r);
        exec(conn , q)
            
    case 1 
         q = sprintf("UPDATE gen SET status = 1 WHERE userid=%d" , r);
        exec(conn , q)
end
end