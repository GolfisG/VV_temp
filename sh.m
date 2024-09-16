function sh(r , s)
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
switch s
    case 0
        q = sprintf("UPDATE branch SET status = 0 WHERE branchid=%d" , r);
        exec(conn , q)
            
    case 1 
         q = sprintf("UPDATE branch SET status = 1 WHERE branchid=%d" , r);
        exec(conn , q)
end
end