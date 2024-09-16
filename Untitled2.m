[t by ay] = plPol(1,-1)
plot(t,ay)
hold on
plot(t,by)
%%
figure
t=0:1040;
a = piece(t,[-inf 0 100 300 700 900 1040 inf],{0 1500 6500 12500 16800 0 0})
plot(t,a)

%%
p = poly2sym([0 0 0 0 0 0 0 0 0.3 0.2 0.1])
bid = matlabFunction(p)
t=linspace(0,682.544)
%%
clear all
[bidy acty min max] = plPol(1,2)
[pg pr] = profit(1,2)
%%
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
res  = fetch(conn , "SELECT * FROM `rounds_info` Where `rounds_info`.`roundid` = 1")
%%
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
query = sprintf("SELECT * FROM `gen` WHERE `gen`.`userid`= %d " , 51)
res = fetch(conn, query)
res= table2array(res)
min = res(1,11);max=res(1,10);

%%


max=-30

x1=-30;y1=-1000;
x2=-20;y2=-900;
x3=-10;y3=-698;
x4=-5;y4=-300;
x5=-0.001;y5=-110;

if(x3 ==0 && x4==0 && x5 ==0)
a=(y2-y1)/(x2-x1)
f = @(x)((a*(x-x1) + y1).*(x>=x1 & x<=x2))

end

if(x3 ~=0 && x4==0 && x5 ==0)
a1=(y2-y1)/(x2-x1)
f1 = @(x)((a1*(x-x1) + y1).*(x>x1 & x<=x2))

a2=(y3-y2)/(x3-x2)
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<x3))
f= @(x) f1(x) + f2(x)
end

if(x3 ~=0 && x4~=0 && x5 ==0)
a1=(y2-y1)/(x2-x1)
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2))

a2=(y3-y2)/(x3-x2)
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3))

a3=(y4-y3)/(x4-x3)
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4))


f= @(x) f1(x) + f2(x) + f3(x)

end

if(x3 ~=0 && x4~=0 && x5 ~=0)
a1=(y2-y1)/(x2-x1)
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2))

a2=(y3-y2)/(x3-x2)
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3))

a3=(y4-y3)/(x4-x3)
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4))

a4=(y5-y4)/(x5-x4)
f4 = @(x)((a4*(x-x4) + y4).*(x>x4 & x<=x5))

f= @(x) f1(x) + f2(x) + f3(x) + f4(x)

end


x=linspace(0,-30)
plot(x , f(x))


