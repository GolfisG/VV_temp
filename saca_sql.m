%This functions receive as inputs the uncleared scenario of our case (mpc)
%as also the cleared scenario of our case(mpc_out)
%In this function we not only save our scenarios, but we also prepare the
%market for next round's offers and bids.In the end of this function we
%also calculate, with help of another function each user's profit.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.
function saca_sql(mpc , mpc_out)
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query = "Select COUNT(*) From `rounds_info`";
t = fetch(exec(conn,query));
roundid = cell2mat(t.Data);
%ROUNDS_INFO ta xaraktiristika tou round
query = sprintf("Insert into `rounds_info` Values('%d' , '0','%f' , '%f' , '%d')" , roundid , mpc_out.f , mpc_out.et , mpc_out.success);
exec(conn,query)

%GEN
t=size(mpc_out.gen,1);
for i=1:t
       
      query = sprintf("INSERT INTO `gen_hist` VALUES('%d','%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%d','%f','%f','%f','%f','%f','%f', '%f', '%f','%f','%f','%f','%f','%f','0');",roundid,i,mpc_out.gen(i,1),mpc_out.gen(i,2),mpc_out.gen(i,3),mpc_out.gen(i,4),mpc_out.gen(i,5),mpc_out.gen(i,6),mpc_out.gen(i,7), mpc_out.gen(i,8), mpc_out.gen(i,9), mpc_out.gen(i,10), mpc.gen(i,11), mpc.gen(i,12) , mpc_out.gen(i,13) , mpc_out.gen(i,14), mpc_out.gen(i,15), mpc_out.gen(i,16), mpc_out.gen(i,17), mpc_out.gen(i,18), mpc_out.gen(i,19), mpc_out.gen(i,20), mpc_out.gen(i,21));
      exec(conn, query);
    
end
%GENCOST
t=size(mpc_out.gencost,1);
for i=1:t
    query = sprintf("INSERT INTO `gencost_hist` VALUES('%d','%d', '%d' ,'%d', '%d' ,'%d','%f','%f','%f','%f','%f','%f','%f','%f','%f', '%f');",roundid,i,mpc_out.gencost(i,1),mpc_out.gencost(i,2),mpc_out.gencost(i,3),mpc_out.gencost(i,4),mpc_out.gencost(i,5),mpc_out.gencost(i,6),mpc_out.gencost(i,7), mpc_out.gencost(i,8), mpc_out.gencost(i,9), mpc_out.gencost(i,10), mpc_out.gencost(i,11), mpc_out.gencost(i,12) , mpc_out.gencost(i,13) , mpc_out.gencost(i,14));
    exec(conn, query);
end
%BUS
t=size(mpc_out.bus,1);
for i=1:t
     query = sprintf("INSERT INTO `bus_hist` VALUES('%d','%d', '%d' ,'%f', '%f' ,'%f','%f','%d','%f','%f','%f','%f','%f','%f','%f');",roundid,mpc_out.bus(i,1),mpc_out.bus(i,2),mpc_out.bus(i,3),mpc_out.bus(i,4),mpc_out.bus(i,5),mpc_out.bus(i,6),mpc_out.bus(i,7),mpc_out.bus(i,8),mpc_out.bus(i,9),mpc_out.bus(i,10),mpc_out.bus(i,11),mpc_out.bus(i,12),mpc_out.bus(i,13),mpc_out.bus(i,14));
     exec(conn, query)
  
end
%BRANCH
t=size(mpc.branch,1);
for i=1:t
     query = sprintf("INSERT INTO `branch_hist` VALUES('%d','%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%f','%f','%d','%f','%f');",roundid,mpc_out.branch(i,1),mpc_out.branch(i,2),mpc_out.branch(i,3),mpc_out.branch(i,4),mpc_out.branch(i,5),mpc_out.branch(i,6),mpc_out.branch(i,7),mpc_out.branch(i,8),mpc_out.branch(i,9),mpc_out.branch(i,10),mpc_out.branch(i,11),mpc_out.branch(i,12),mpc_out.branch(i,13));
 exec(conn, query)
end
t=size(mpc_out.bus,1);
for i=1:t
 query = sprintf("UPDATE `bus` SET `type`='%d',`pd`= '%f' ,`qd`='%f',`gs`= '%f' ,`bs`='%f',`area`='%d',`vm`='%f',`va`='%f',`basekv`='%f',`zone`='%f',`vmax`='%f',`vmin`='%f' WHERE `bus`.`bus` = %d ;",mpc_out.bus(i,2),mpc_out.bus(i,3),mpc_out.bus(i,4),mpc_out.bus(i,5),mpc_out.bus(i,6),mpc_out.bus(i,7),mpc_out.bus(i,8),mpc_out.bus(i,9),mpc_out.bus(i,10),mpc_out.bus(i,11),mpc_out.bus(i,12),mpc_out.bus(i,13),i);
   fetch(exec(conn, query));
   
end
%---------------Set next case------------
%BRANCH
t=size(mpc_out.branch ,1);
     for i=1:t
    query = sprintf("UPDATE `branch` SET `fbus`='%d',`tbus`= '%d' ,`r`='%f',`x` ='%f' ,`b`='%f',`ratea`='%f',`rateb`='%f',`ratec`='%f',`ratio`='%f',`angle`='%f',`status`='%d',`agmin`='%f',`angmax`='%f' WHERE `branch`.`branchid` = %d;",mpc_out.branch(i,1),mpc_out.branch(i,2),mpc_out.branch(i,3),mpc_out.branch(i,4),mpc_out.branch(i,5),mpc_out.branch(i,6),mpc_out.branch(i,7),mpc_out.branch(i,8),mpc_out.branch(i,9),mpc_out.branch(i,10),mpc_out.branch(i,11),mpc_out.branch(i,12),mpc_out.branch(i,13),i);
    %Prosoxi meta ton orismo twn busid kai branchid na baleis sthn domi mpc
    %ta swsta columns
    
  fetch(exec(conn, query));
     end
     
     %GEN
     t=size(mpc_out.gen,1);
     for i=1:t
       if(i>=1 && i<=10)
     query = sprintf("UPDATE `gen` SET `bus`='%d',`pg`= '%f' ,`qg`='%f',`qmax`= '%f' ,`qmin`='%f',`vg`='%f',`mbase`='%f',`status`='%f',`pmax`='%f',`pmin`='%f',`pc1`='%f',`pc2`='%f',`qc1min`='%f',`qc1max`='%f',`qc2min`='%f',`qc2max`= '%f',`ramp_agc`= '%f',`ramp_10`='%f',`ramp_30`='%f',`ramp_q`='%f',`apf`='%f' WHERE `gen`.`userid` = %d;",mpc_out.gen(i,1),mpc_out.gen(i,2),mpc_out.gen(i,3),mpc_out.gen(i,4),mpc_out.gen(i,5),mpc_out.gen(i,6),mpc_out.gen(i,7), mpc_out.gen(i,8), mpc.gen(i,9), mpc.gen(i,10), mpc_out.gen(i,11), mpc_out.gen(i,12) , mpc_out.gen(i,13) , mpc_out.gen(i,14), mpc_out.gen(i,15), mpc_out.gen(i,16), mpc_out.gen(i,17), mpc_out.gen(i,18), mpc_out.gen(i,19), mpc_out.gen(i,20), mpc_out.gen(i,21),i);
  fetch(exec(conn, query));
       end
     if(i<=15 && i>=11)  
       query = sprintf("UPDATE `gen` SET `bus`='%d',`pg`= '%f' ,`qg`='%f',`qmax`= '%f' ,`qmin`='%f',`vg`='%f',`mbase`='%f',`status`='%f',`pmax`='%f',`pmin`='%f',`pc1`='%f',`pc2`='%f',`qc1min`='%f',`qc1max`='%f',`qc2min`='%f',`qc2max`= '%f',`ramp_agc`= '%f',`ramp_10`='%f',`ramp_30`='%f',`ramp_q`='%f',`apf`='%f' WHERE `gen`.`userid` = %d;",mpc_out.gen(i,1),mpc_out.gen(i,2),mpc_out.gen(i,3),mpc_out.gen(i,4),mpc_out.gen(i,5),mpc_out.gen(i,6),mpc_out.gen(i,7), mpc_out.gen(i,8), mpc_out.gen(i,9), mpc_out.gen(i,10), mpc_out.gen(i,11), mpc_out.gen(i,12) , mpc_out.gen(i,13) , mpc_out.gen(i,14), mpc_out.gen(i,15), mpc_out.gen(i,16), mpc_out.gen(i,17), mpc_out.gen(i,18), mpc_out.gen(i,19), mpc_out.gen(i,20), mpc_out.gen(i,21),i);
  fetch(exec(conn, query));
     end
     end
%GENCOST
     t=size(mpc_out.gencost ,1);
     for i=1:t
       query = sprintf("UPDATE `gencost` SET `func_type='%d',`startup`= '%d' ,`shutdown`='%d', `num`='%d' ,`blk1`='%f',`blk2`='%f',`blk3`='%f',`blk4`='%f',`blk5`='%f',`blk6`='%f',`blk7`='%f',`blk8`='%f',`blk9`='%f',`blk10`='%f' WHERE `gencost`.`userid`= %d ;",mpc_out.gencost(i,1),mpc_out.gencost(i,2),mpc_out.gencost(i,3),mpc_out.gencost(i,4),mpc_out.gencost(i,5),mpc_out.gencost(i,6),mpc_out.gencost(i,7), mpc_out.gencost(i,8), mpc_out.gencost(i,9), mpc_out.gencost(i,10), mpc_out.gencost(i,11), mpc_out.gencost(i,12) , mpc_out.gencost(i,13) , mpc_out.gencost(i,14),i);
   fetch(exec(conn, query));
     end
      table1 = fetch(conn,"SELECT * FROM `actualcost`");
     table = table2array(table1);
     t=size(table, 1);
     for i=1:t
       query = sprintf("INSERT INTO `actualcost_hist` VALUES('%d','%d', '%d' ,'%d', '%d' ,'%d','%f','%f','%f','%f','%f','%f','%f','%f','%f', '%f' );",roundid,i,table(i,2),table(i,3),table(i,4),table(i,5),table(i,6),table(i,7),table(i,8), table(i,9),table(i,10), table(i,11), table(i,12), table(i,13) , table(i,14) , table(i,15));
     exec(conn, query);
     end
     disp("WAITING FOR PROFIT CALCULATION")   
     pr_sql(roundid);
end