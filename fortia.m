k=11;  
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query = sprintf("SELECT * FROM `gen` WHERE `gen`.`userid`= %d " , k )
res1=fetch(conn,query)
res= table2array(res1)
min = res(1,11);max=res(1,10);
disp(min)
disp(max)
