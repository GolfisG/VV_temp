%This function changes the values of mpc.gen based on the changes that the
%user selected
%
%Author:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

 function loadchange(handle , k)
  javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
  conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
  selectquery = 'SELECT * FROM loads';
  data = select(conn,selectquery);
  data = table2array(data);
  close(conn);


  plot(handle,data(k-10,2:end));
  hold on;
  stem(handle,data(k-10,2:end));

  