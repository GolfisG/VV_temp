%This function saves the load changes in the database
%
%Authors:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.


function loads(id,tble)

javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
tble = cell2mat(tble);
% disp(tble);
tble2 = zeros(24,2);
for i = 1:24
    tble2(i,1) = i;
end
for i = 1:24
    tble2(i,2) = tble2(1,2);
end
for i = 1:size(tble,1)
    for j = 1:24
        if tble(i,1) == tble2(j,1)
            tble2(j,2) = tble(i,2);
        end
    end
end


query = sprintf("UPDATE `loads` SET `h1`='%f',`h2`='%f',`h3`='%f',`h4`='%f',`h5`='%f',`h6`='%f',`h7`='%f',`h8`='%f',`h9`='%f',`h10`='%f',`h11`='%f',`h12`='%f',`h13`='%f',`h14`='%f',`h15`='%f',`h16`='%f',`h17`='%f',`h18`='%f',`h19`='%f',`h20`='%f',`h21`='%f',`h22`='%f',`h23`='%f',`h24`='%f' WHERE `loads`.`userid` = %d",tble2(1,2),tble2(2,2),tble2(3,2),tble2(4,2),tble2(5,2),tble2(6,2),tble2(7,2),tble2(8,2),tble2(9,2),tble2(10,2),tble2(11,2),tble2(12,2),tble2(13,2),tble2(14,2),tble2(15,2),tble2(16,2),tble2(17,2),tble2(18,2),tble2(19,2),tble2(20,2),tble2(21,2),tble2(22,2),tble2(23,2),tble2(24,2),id);
exec(conn,query)

close(conn)
end






% tble = [tble ; mat1];
% mat1 = zeros(24-size(tble,1),2);
% for i = size(tble,1)+1:24
%     mat1(i-size(tble,1),1) = i;
%     mat1(i-size(tble,1),2) = 0;