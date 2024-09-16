% This function exports data on an excel sheet
% Authors: Kleitos Karampasis Panagiotis Gkolfinopoulos
% This code is intented for educational reasons.

function exportdata(fname,fixpct)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query5 = "SELECT * FROM rounds_info";
result = fetch(conn, query5);
result = table2array(result);
[rownum,colnum] = size(result);
round = result(rownum,1);

for r= 1:round
filename = strcat(fname,'.xlsx');
disp(filename)
writematrix('Round',filename,'Sheet',r,'Range','A1');
writematrix(r,filename,'Sheet',r,'Range','B1');
writematrix("Bus",filename,'Sheet',r,'Range','C2');
writematrix("Pg",filename,'Sheet',r,'Range','D2');
writematrix("Price",filename,'Sheet',r,'Range','E2');
writematrix("Price Diff",filename,'Sheet',r,'Range','F2');
writematrix("Profit",filename,'Sheet',r,'Range','G2');
writematrix("Round",filename,'Sheet',r,'Range','C19');
writematrix("Success",filename,'Sheet',r,'Range','D19');
writematrix("OBJ Function",filename,'Sheet',r,'Range','E19');

tab2 = zeros(15:5);
query = sprintf("SELECT * FROM `gen_hist` WHERE `gen_hist`.`roundid` = %d", r );
res = fetch(conn, query);
res = table2array(res);
for i=1:15
query = sprintf("SELECT * FROM `bus_hist` WHERE (`bus_hist`.`bus` = %d AND `bus_hist`.`roundid` = %d);",res(i,3),r);
res1 = fetch(conn,query);
res1 = table2array(res1);
tab2(i,1:2) = res(i,3:4);
tab2(i,3) = res1(1,15);
tab2(i,4) = res1(1,15);
tab2(i,5) = res(i,24);
end
dum = tab2(:,3);
mean = dum(1,1)+dum(2,1)+dum(3,1)+dum(4,1)+dum(5,1)+dum(6,1)+dum(7,1)+dum(8,1)+dum(9,1)+dum(10,1)+dum(11,1)+dum(12,1)+dum(13,1)+dum(14,1)+dum(15,1);
mean = mean/15;
for i=1:15
    dum(i,1) = -100*(1-(dum(i,1)/mean));
end
for i=1:15
    tab2(i,4) = dum(i,1);
end

selectquery2 = sprintf("SELECT * FROM `rounds_info` WHERE `rounds_info`.`roundid`= %d " , r );
table2 = select(conn,selectquery2);
table2 = table2array(table2);


writematrix(tab2,filename,'Sheet',r,'Range','C3')
writematrix(table2,filename,'Sheet',r,'Range','C20')



javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query = sprintf("SELECT bus,status FROM `gen_hist` WHERE `gen_hist`.`roundid`= %d " , r );
data = select(conn,query);
data = table2array(data);
i = 0;
k = 0;
for i = 1:10
    data(i,1) = data(i,1) - 29;
    if data(i,2) == 0
        k = data(i,1);
    end
end
writematrix("Generator off",filename,'Sheet',r,'Range','I3');
writematrix(k,filename,'Sheet',r,'Range','J3');



selectquery = sprintf("SELECT status FROM `branch_hist` WHERE `branch_hist`.`roundid`= %d " , r );
data1 = select(conn,selectquery);
data1 = table2array(data1);
i = 0;
k = 0;
for i = 1:46
    if data1(i,1) == 0
       k = k+1;
    end
end
data2 = zeros(1,k);
i = 0;
k = 1;
for i = 1:46
    if data1(i,1) == 0
       data2(1,k) = i;
       k = k+1;
    end
end
writematrix("Lines off",filename,'Sheet',r,'Range','I4');
writematrix(data2,filename,'Sheet',r,'Range','J4');



writematrix("Fixed Load Percentage",filename,'Sheet',r,'Range','I5');
writematrix(fixpct,filename,'Sheet',r,'Range','J5');



selectquery1 = 'SELECT * FROM loads';
data3 = select(conn,selectquery1);
data3 = table2array(data3);
data4 = zeros(1,5);
i=0;
for i = 1:5
    data4(1,i) = 1+(data3(i,r+1)/100);
end
writematrix("Dispatchable Load Percentage",filename,'Sheet',r,'Range','I6');
writematrix(data4,filename,'Sheet',r,'Range','J6');



selectquery1 = 'SELECT * FROM limits';
data5 = select(conn,selectquery1);
data5 = table2array(data5);
i = 0;
k = 0;
for i = 1:46
    if data5(i,2) ~= 0
       k = k+1;
    end
end
data6 = zeros(2,k);
i = 0;
k = 1;
for i = 1:46
    if data5(i,2) ~= 0
       data6(1,k) = i;
       data6(2,k) = 1+ (data5(i,2)/100);
       k = k+1;
    end
end



writematrix("Branch ID ",filename,'Sheet',r,'Range','I8');
writematrix(data6(1,:),filename,'Sheet',r,'Range','J8');
writematrix("Percentage of Thermal Limit Change ",filename,'Sheet',r,'Range','I9');
writematrix(data6(2,:),filename,'Sheet',r,'Range','J9');
end

close(conn);



