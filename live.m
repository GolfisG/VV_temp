%This function is responsible for data update in the public live grid
%table.The unique input is the roundid and then return two tables, the
%first one is the rounds_info table and the second one is the table that
%represented with data from bus_hist and gen_hist combined.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function [tab1 tab2] = live(r)

res1 = sql("SELECT * FROM rounds_info");
tab1(:,1)=res1(:,1);
tab1(:,2)=res1(:,5);
tab1(:,3)=res1(:,3);

conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

query = sprintf("SELECT * FROM `rounds_info` WHERE `rounds_info`.`roundid` =  %d ",r);
su = fetch(conn,query);
if(isempty(su)==1)
disp("No round Summary Yet...")
tab2 = zeros(15,5) ;
else if(isempty(su)==0)
%----------
query = sprintf("SELECT * FROM `gen_hist` WHERE `gen_hist`.`roundid` = %d", r  );
res = fetch(conn, query);
for i=1:15
query = sprintf("SELECT * FROM `bus_hist` WHERE (`bus_hist`.`bus` = %d AND `bus_hist`.`roundid` = %d);",table2array(res(i,3)),r);
res1 = fetch(conn,query);
tab2(i,1:2) = res(i,3:4);
tab2(i,3) = res1(1,15);
tab2(i,4) = res1(1,15);
tab2(i,5) = res(i,24);

end
end
dum = table2array(tab2(:,3));
mean = dum(1,1)+dum(2,1)+dum(3,1)+dum(4,1)+dum(5,1)+dum(6,1)+dum(7,1)+dum(8,1)+dum(9,1)+dum(10,1)+dum(11,1)+dum(12,1)+dum(13,1)+dum(14,1)+dum(15,1);
mean = mean/15;
for i=1:15
    dum(i,1) = -100*(1-(dum(i,1)/mean));
end
dum = array2table(dum);
for i=1:15
    tab2(i,4) = dum(i,1);
end
close(conn)

end