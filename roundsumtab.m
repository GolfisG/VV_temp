%This function takes as input roundid and the it returns a table that
%contains Admin's data about each round.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.
function tab =  roundsumtab(r)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query = sprintf("SELECT * FROM `rounds_info` WHERE `rounds_info`.`roundid` =  %d ",r);
su = fetch(conn,query);
if(isempty(su)==1)
disp("No round Summary Yet...")
tab = zeros(15,6) ;
else if(isempty(su)==0)
%----------
query = sprintf("SELECT * FROM `gen_hist` WHERE `gen_hist`.`roundid` = %d", r  );
res = fetch(conn, query);
for i=1:15
query = sprintf("SELECT * FROM `bus_hist` WHERE (`bus_hist`.`bus` = %d AND `bus_hist`.`roundid` = %d);",table2array(res(i,3)),r);
res1 = fetch(conn,query);
tab(i,1:4) = res(i,2:5);
tab(i,5) = res1(1,15);
tab(i,6) = res1(1,15);
tab(i,7) = res(i,24);

end
end
dum = table2array(tab(:,5));
mean = dum(1,1)+dum(2,1)+dum(3,1)+dum(4,1)+dum(5,1)+dum(6,1)+dum(7,1)+dum(8,1)+dum(9,1)+dum(10,1)+dum(11,1)+dum(12,1)+dum(13,1)+dum(14,1)+dum(15,1);
mean = mean/15;
for i=1:15
    dum(i,1) = -100*(1-(dum(i,1)/mean));
end
dum = array2table(dum);
for i=1:15
    tab(i,6) = dum(i,1);
end
close(conn)
end