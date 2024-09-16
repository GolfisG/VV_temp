%This method is responsible to setup the default case in our market.
%As default case is a modified scenario of case39, a ready scenario of
%Matpower.In this scenatio I have added 5 users as dispatchable loads 
%and so case39mod has emerged.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.
function case0(fname)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

mpc = loadcase(fname);
load('actualcost' ,'table')

for i=11:15
    query = sprintf("INSERT INTO `loads` VALUES('%d', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0', '0' ,'0');" ,i);
    exec(conn, query);
end

for i=1:46
      query = sprintf("INSERT INTO `limits` VALUES('%d', '0');",i);
      exec(conn, query)

end

t=size(mpc.gen,1);
for i=1:t
      query = sprintf("INSERT INTO `gen` VALUES('%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%d','%f','%f','%f','%f','%f','%f', '%f', '%f','%f','%f','%f','%f','%f');",i,mpc.gen(i,1),mpc.gen(i,2),mpc.gen(i,3),mpc.gen(i,4),mpc.gen(i,5),mpc.gen(i,6),mpc.gen(i,7), mpc.gen(i,8), mpc.gen(i,9), mpc.gen(i,10), mpc.gen(i,11), mpc.gen(i,12) , mpc.gen(i,13) , mpc.gen(i,14), mpc.gen(i,15), mpc.gen(i,16), mpc.gen(i,17), mpc.gen(i,18), mpc.gen(i,19), mpc.gen(i,20), mpc.gen(i,21));
      exec(conn, query)
    
end
t=size(mpc.gencost,1);
for i=1:t
    query = sprintf("INSERT INTO `gencost`(`userid`, `func_type`, `startup`, `shutdown`, `num`, `blk1`, `blk2`, `blk3`, `blk4`, `blk5`, `blk6`, `blk7`, `blk8`, `blk9`, `blk10`) VALUES('%d', '%d' ,'%d', '%d' ,'%d','%f','%f','%f','%f','%f','%f','%f','%f','%f', '%f' );",i,mpc.gencost(i,1),mpc.gencost(i,2),mpc.gencost(i,3),mpc.gencost(i,4),mpc.gencost(i,5),mpc.gencost(i,6),mpc.gencost(i,7), mpc.gencost(i,8), mpc.gencost(i,9), mpc.gencost(i,10), mpc.gencost(i,11), mpc.gencost(i,12) , mpc.gencost(i,13) , mpc.gencost(i,14));
    exec(conn, query)
end
t=size(mpc.bus,1);
for i=1:t
     query = sprintf("INSERT INTO `bus` VALUES('%d', '%d' ,'%f', '%f' ,'%f','%f','%d','%f','%f','%f','%f','%f','%f');",mpc.bus(i,1),mpc.bus(i,2),mpc.bus(i,3),mpc.bus(i,4),mpc.bus(i,5),mpc.bus(i,6),mpc.bus(i,7),mpc.bus(i,8),mpc.bus(i,9),mpc.bus(i,10),mpc.bus(i,11),mpc.bus(i,12),mpc.bus(i,13));
     exec(conn, query)
  
end
t=size(mpc.branch,1);
for i=1:t
     query = sprintf("INSERT INTO `branch` VALUES('%d','%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%f','%f','%d','%f','%f');",i,mpc.branch(i,1),mpc.branch(i,2),mpc.branch(i,3),mpc.branch(i,4),mpc.branch(i,5),mpc.branch(i,6),mpc.branch(i,7),mpc.branch(i,8),mpc.branch(i,9),mpc.branch(i,10),mpc.branch(i,11),mpc.branch(i,12),mpc.branch(i,13));
  exec(conn, query)
end
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
mpc = loadcase(fname);
t=size(mpc.gen,1);
for i=1:t
      query = sprintf("INSERT INTO `gen_hist` VALUES('0','%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%d','%f','%f','%f','%f','%f','%f', '%f', '%f','%f','%f','%f','%f','%f','0');",i,mpc.gen(i,1),mpc.gen(i,2),mpc.gen(i,3),mpc.gen(i,4),mpc.gen(i,5),mpc.gen(i,6),mpc.gen(i,7), mpc.gen(i,8), mpc.gen(i,9), mpc.gen(i,10), mpc.gen(i,11), mpc.gen(i,12) , mpc.gen(i,13) , mpc.gen(i,14), mpc.gen(i,15), mpc.gen(i,16), mpc.gen(i,17), mpc.gen(i,18), mpc.gen(i,19), mpc.gen(i,20), mpc.gen(i,21));
      exec(conn, query)
    
end
t=0;
t=size(mpc.gencost,1);
for i=1:t
    query = sprintf("INSERT INTO `gencost_hist`(`roundid`,`userid`, `func_type`, `startup`, `shutdown`, `num`, `blk1`, `blk2`, `blk3`, `blk4`, `blk5`, `blk6`, `blk7`, `blk8`, `blk9`, `blk10`) VALUES('0','%d', '%d' ,'%d', '%d' ,'%d','%f','%f','%f','%f','%f','%f','%f','%f','%f', '%f' );",i,mpc.gencost(i,1),mpc.gencost(i,2),mpc.gencost(i,3),mpc.gencost(i,4),mpc.gencost(i,5),mpc.gencost(i,6),mpc.gencost(i,7), mpc.gencost(i,8), mpc.gencost(i,9), mpc.gencost(i,10), mpc.gencost(i,11), mpc.gencost(i,12) , mpc.gencost(i,13) , mpc.gencost(i,14));
    exec(conn, query)
end
t=0;
t=size(mpc.bus,1);
for i=1:t
     query = sprintf("INSERT INTO `bus_hist` VALUES('0','%d', '%d' ,'%f', '%f' ,'%f','%f','%d','%f','%f','%f','%f','%f','%f',0);",mpc.bus(i,1),mpc.bus(i,2),mpc.bus(i,3),mpc.bus(i,4),mpc.bus(i,5),mpc.bus(i,6),mpc.bus(i,7),mpc.bus(i,8),mpc.bus(i,9),mpc.bus(i,10),mpc.bus(i,11),mpc.bus(i,12),mpc.bus(i,13));
     exec(conn, query)
  
end
t=0;
t=size(mpc.branch,1);
for i=1:t
     query = sprintf("INSERT INTO `branch_hist` VALUES('0','%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%f','%f','%d','%f','%f');",mpc.branch(i,1),mpc.branch(i,2),mpc.branch(i,3),mpc.branch(i,4),mpc.branch(i,5),mpc.branch(i,6),mpc.branch(i,7),mpc.branch(i,8),mpc.branch(i,9),mpc.branch(i,10),mpc.branch(i,11),mpc.branch(i,12),mpc.branch(i,13));
 exec(conn, query)
end
pause(2)
p = size(table , 1);
disp(table)
for i=1:p 
query = sprintf("INSERT INTO `actualcost_hist` VALUES('0','%d', '%d' ,'%d', '%d' ,'%d','%f','%f','%f','%f','%f','%f','%f','%f','%f', '%f' );",i,table(i,2),table(i,3),table(i,4),table(i,5),table(i,6),table(i,7), table(i,8),table(i,9), table(i,10),table(i,11), table(i,12) , table(i,13) , table(i,14) , table(i,15));
exec(conn,query)

query1 = sprintf("INSERT INTO `actualcost` VALUES('%d', '%d' ,'%d', '%d' ,'%d','%f','%f','%f','%f','%f','%f','%f','%f','%f', '%f' );",i,table(i,2),table(i,3),table(i,4),table(i,5),table(i,6),table(i,7), table(i,8),table(i,9), table(i,10),table(i,11), table(i,12) , table(i,13) , table(i,14) , table(i,15));
exec(conn,query1)
end
pause(0.4)
exec(conn , "Insert into `rounds_info`(`roundid`,`date` , `ofv`,`et` , `success`) Values('0','0','0','0','0')")
exec(conn , "Update `rounds_info` Set `roundid`='0' where `rounds_info`.`roundid`='1' ")

close(conn)
fprintf("\n%s SETUP READY \n",fname)
end