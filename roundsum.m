%This function takes as input roundid and then it returns all the
%appropriate data that represented in Admin's Panel about rounds.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function[pd qd Pg Qg DL oDL obj et pct] = roundsum(r)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

query = sprintf("SELECT * FROM `rounds_info` WHERE `rounds_info`.`roundid` =  %d ",r);
su = fetch(conn,query);

if(isempty(su)==1)
disp("No round Summary Yet...")
pd =0,  qd =0, Pg =0 , Qg =0,  DL =0,  oDL =0, obj =0, et =0, pct = 0;
else if(isempty(su)==0)

    query=sprintf("Select * from `bus_hist` Where `bus_hist`.`roundid` = %d" , r);
    res1=fetch(conn , query);
    bus = table2array(res1);
    query = sprintf("SELECT * FROM `gen_hist` WHERE `gen_hist`.`roundid` = %d " , r);
    res = fetch(conn , query);
    gen = table2array(res);
    query = sprintf("SELECT * FROM `gen_hist` WHERE `gen_hist`.`roundid` = %d " , r);
    res2 = fetch(conn , query);
    gen1 = table2array(res2);
    query = sprintf("SELECT * FROM `rounds_info` WHERE `rounds_info`.`roundid` = %d" , r);
    res3 = fetch(conn , query);
    DL = abs(sum(gen(11:15,4)));
    if(r==0)
      oDL= DL;
    else
    query = sprintf("SELECT * FROM `gen_hist` WHERE `gen_hist`.`roundid` = %d " , r);
    res11 = fetch(conn , query);
    gen2 = table2array(res11);
      oDL= abs(sum(gen2(11:15 ,12)));
    end
    pd = sum(bus(1:end,4));
    qd = sum(bus(1:end,5));
    Pg = sum(gen(1:10,4));
    Qg = sum(gen(1:10,5));
    pct = (DL/oDL)*100;
   
 
  
   
    obj = table2array( res3(1,3));
    et = table2array( res3(1,4) );
    
    
end
    









end
close(conn)
end