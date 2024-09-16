function unamechange(id , uname)
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

q = sprintf("UPDATE `users` SET `user`='%s' WHERE `users`.`userid` = %d", uname, id);
exec(conn , q)

end