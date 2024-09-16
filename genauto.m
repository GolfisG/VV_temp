function genauto(boxdata)

boxdata = table2array(boxdata);

javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
selectquery = 'SELECT * FROM actualcost';
data = select(conn,selectquery);
data = table2array(data);
close(conn);

for i = 1:10
    if boxdata(i,1)
        gencost_entry(data(i,6),data(i,7),data(i,8),data(i,9),data(i,10),data(i,11),data(i,12),data(i,13),data(i,14),data(i,15),1,i)
    end
end

end