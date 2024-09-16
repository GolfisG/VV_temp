%This function takes as input's arguments userid and also roundind and then
%calls another functions, which returns each user's generator cost
%function.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function [pg pr by ay min max] = profit(k,r)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query = sprintf("SELECT * FROM `rounds_info` WHERE `rounds_info`.`roundid` =  %d ",r);
su = fetch(conn,query);
if(isempty(su))
disp("WAIT... for round clearing")
pg=0;pr=0;
else
 [by ay min max] = plPol(k,r);
    query = sprintf("SELECT * FROM `gen_hist` WHERE( `gen_hist`.`roundid` = %d AND `gen_hist`.`userid` = %d )" , r,k);
    res  = fetch(conn,query);
    p = res(1,4);
    pg= table2array(p);
    pr = by(pg) - ay(pg);
end

end