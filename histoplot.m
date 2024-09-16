%This function changes the values of mpc.gen based on the changes that the
%user selected
%
%Author:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

 function histoplot(handle,userid)
   javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
   conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
   selectquery = 'SELECT * FROM loads';
   data = select(conn,selectquery);
   data = table2array(data);
   close(conn);

 
   
   stem(handle,data(userid-10,2:end));

