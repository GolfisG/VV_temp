
%This functions takes data from users panel and continuesly updates
%actual_cost table.As inputs it takes either polynomial and linear data and depends on
%userid to save these data into actual_cost.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function actualcost_entry(blk1,blk2,blk3,blk4,blk5,blk6,blk7,blk8,blk9,blk10,c,i)
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
if(c==0)
if(i>=1 && i<=10)
query = sprintf("UPDATE `actualcost` SET `func_type`='1', `num` = '5', `blk1`='%f',`blk2`='%f',`blk3`='%f',`blk4`='%f',`blk5`='%f',`blk6`='%f',`blk7`='%f',`blk8`='%f',`blk9`='%f',`blk10`='%f' WHERE `actualcost`.`userid` = %d",blk1,blk2,blk3,blk4,blk5,blk6,blk7,blk8,blk9,blk10,i)
exec(conn,query)
end
if(i>=11 && i<=15)
    query = sprintf("UPDATE `actualcost` SET `func_type`='1', `num` = '5', `blk1`='%f',`blk2`='%f',`blk3`='%f',`blk4`='%f',`blk5`='%f',`blk6`='%f',`blk7`='%f',`blk8`='%f',`blk9`='%f',`blk10`='%f' WHERE `actualcost`.`userid` = %d",-blk1,-blk2,-blk3,-blk4,-blk5,-blk6,-blk7,-blk8,blk9,-blk10,i)
    exec(conn,query)
end
end
if(c==1)
  if(i>=1 && i<=10)
    query = sprintf("UPDATE `actualcost` SET `func_type`='2', `num` = '10', `blk1`='%f',`blk2`='%f',`blk3`='%f',`blk4`='%f',`blk5`='%f',`blk6`='%f',`blk7`='%f',`blk8`='%f',`blk9`='%f',`blk10`='%f' WHERE `actualcost`.`userid` = %d",blk1,blk2,blk3,blk4,blk5,blk6,blk7,blk8,blk9,blk10,i)
    exec(conn,query)
  end
  if(i>=11 && i<=15)    
      query = sprintf("UPDATE `actualcost` SET `func_type`='2', `num` = '10', `blk1`='%f',`blk2`='%f',`blk3`='%f',`blk4`='%f',`blk5`='%f',`blk6`='%f',`blk7`='%f',`blk8`='%f',`blk9`='%f',`blk10`='%f' WHERE `actualcost`.`userid` = %d",-blk1,-blk2,-blk3,-blk4,-blk5,-blk6,-blk7,-blk8,-blk9,-blk10,i)
    exec(conn,query)
  end
end
close(conn)
end