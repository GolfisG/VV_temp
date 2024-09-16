function passchange(id , pass)
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

q = sprintf("UPDATE `users` SET `pass`='%s' WHERE `users`.`userid` = %d", pass, id);
exec(conn , q)

end