function res = test()
clc; clear all;
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

res = fetch(exec(conn , 'select * from gencost'))

% sto apotelesma res 
%mpc.gencost = cell2table(res.Data)  // mias kai to res einai mia domi
%epistrofis apo thn bash dedomenwn
%%
`pmax`='%d',`pmin`='%f',`pc1`='%f',`pc2`='%f',`qc1min`='%f',`qc1max`='%f',`qc2min`='%f',`qc2max`= '%f',`ramp_agc`= '%f',`ramp_10`='%f',`ramp_30`='%f',`ramp_q`='%f',`apf`='%f' 
%%
function db_case()
clear all;clc;
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
mpc = loadcase(case39mod1)
t=size(mpc.bus,1)
for i=1:t
    %query = sprintf("INSERT INTO `gencost`(`userid`, `func_type`, `startup`, `shutdown`, `num`, `blk1`, `blk2`, `blk3`, `blk4`, `blk5`, `blk6`, `blk7`, `blk8`, `blk9`, `blk10`) VALUES('%d', '%d' ,'%d', '%d' ,'%d','%f','%f','%f','%f','%f','%f','%f','%f','%f', '%f' );",i,mpc.gencost(i,1),mpc.gencost(i,2),mpc.gencost(i,3),mpc.gencost(i,4),mpc.gencost(i,5),mpc.gencost(i,6),mpc.gencost(i,7), mpc.gencost(i,8), mpc.gencost(i,9), mpc.gencost(i,10), mpc.gencost(i,11), mpc.gencost(i,12) , mpc.gencost(i,13) , mpc.gencost(i,14))
    %res = fetch(exec(conn, query))
    
     % query = sprintf("INSERT INTO `gen` VALUES('%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%d','%f','%f','%f','%f','%f','%f', '%f', '%f','%f','%f','%f','%f','%f');",i,mpc.gen(i,1),mpc.gen(i,2),mpc.gen(i,3),mpc.gen(i,4),mpc.gen(i,5),mpc.gen(i,6),mpc.gen(i,7), mpc.gen(i,8), mpc.gen(i,9), mpc.gen(i,10), mpc.gen(i,11), mpc.gen(i,12) , mpc.gen(i,13) , mpc.gen(i,14), mpc.gen(i,15), mpc.gen(i,16), mpc.gen(i,17), mpc.gen(i,18), mpc.gen(i,19), mpc.gen(i,20), mpc.gen(i,21))
   % res = fetch(exec(conn, query))
    
  
     %query = sprintf("INSERT INTO `branch` VALUES('%d', '%d' ,'%f', '%f' ,'%f','%f','%f','%f','%f','%f','%d','%f','%f');",mpc.branch(i,1),mpc.branch(i,2),mpc.branch(i,3),mpc.branch(i,4),mpc.branch(i,5),mpc.branch(i,6),mpc.branch(i,7),mpc.branch(i,8),mpc.branch(i,9),mpc.branch(i,10),mpc.branch(i,11),mpc.branch(i,12),mpc.branch(i,13))
  %  res = fetch(exec(conn, query))
    
        
      %query = sprintf("INSERT INTO `bus` VALUES('%d', '%d' ,'%f', '%f' ,'%f','%f','%d','%f','%f','%f','%f','%f','%f');",mpc.bus(i,1),mpc.bus(i,2),mpc.bus(i,3),mpc.bus(i,4),mpc.bus(i,5),mpc.bus(i,6),mpc.bus(i,7),mpc.bus(i,8),mpc.bus(i,9),mpc.bus(i,10),mpc.bus(i,11),mpc.bus(i,12),mpc.bus(i,13))
   % res = fetch(exec(conn, query))
   
   
end


%%
function LinearEntry(blk1,blk2,blk3,blk4,blk5,pr1,pr2,pr3,pr4,pr5,i)
if(i>0 && i<=10)
    try
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
where = strcat('Where userid=',num2str(i))

 update(conn,'ofqty',{'blk1' , 'blk2' , 'blk3', 'blk4' , 'blk5'},table(blk1,blk2,blk3,blk4,blk5,'VariableNames',{'blk1','blk2','blk3','blk4','blk5'}),where)
 update(conn,'ofprice',{'blk1' , 'blk2' , 'blk3', 'blk4' , 'blk5'},table(pr1,pr2,pr3,pr4,pr5,'VariableNames',{'blk1','blk2','blk3','blk4','blk5'}),where)
       
 close(conn)
    catch ME
        rethrow(ME)
    end
end


if(i>10 && i<=14)
 try
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','VEM','VEMpassword123456','com.mysql.jdbc.Driver','jdbc:mysql://150.140.189.20:3306/vem')
where = strcat('Where userid=',num2str(i))

 update(conn,'bidqty',{'blk1' , 'blk2' , 'blk3', 'blk4' , 'blk5'},table(blk1,blk2,blk3,blk4,blk5,'VariableNames',{'blk1','blk2','blk3','blk4','blk5'}),where)
 update(conn,'bidprice',{'blk1' , 'blk2' , 'blk3', 'blk4' , 'blk5'},table(pr1,pr2,pr3,pr4,pr5,'VariableNames',{'blk1','blk2','blk3','blk4','blk5'}),where)
       close(conn)
    catch ME
        rethrow(ME)
    end
end

end

%%
clc;clear all;
mpc = loadcase(case39mod1);
mkt.OPF = 'AC';
mkt.auction_type = 1;
mpc.version = '2';
mpc.baseMVA = 100;

[q , p] = case2off(mpc.gen , mpc.gencost)
if(size(q)~=size(p))
disp('Error inside gen or gencost')
end
for i =1:size(q,1)
   for(j=1:size(q,2))
   if (q(i,j)<0)
   q(i,j)=0;
   end
   end
end

offers.P.qty = q(1:10,:);

offers.P.prc = p(1:10 , :);

bids.P.qty = q(11:15 , :);

bids.P.prc = p(11:15,:);



try 
runmarket(mpc, offers, bids, mkt);
catch me
    rethrow(me)
end



end