%This function takes as inputs userid and roundid.
%Then it returns user's gencost formula.It is able to calculate both
%polynomial and linear entries as also it is able to calculate for
%generator's as also load's formulas.It's also returns minimum and maximum
%constraints from gen table.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function [bidy acty min max] = plPol(k,r)
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');
  %Orismos Pmin Pmax gia na broume ta oria  
query = sprintf("SELECT * FROM `gen` WHERE `gen`.`userid`= %d " , k );
res1=fetch(conn,query);
res= table2array(res1);
min = res(1,11);max=res(1,10);
x=linspace(min,max);
disp(min)
disp(max)
%-------------------------------------------PREVIOUS ROUND-----
if(r>=0)

   
    %GENCOST
   
query  = sprintf("SELECT * FROM `gencost_hist` WHERE (`gencost_hist`.`userid`= %d && `gencost_hist`.`roundid`= %d)" , k , r);
disp(query)
res = fetch(exec(conn,query));
res=cell2mat(res.Data);
disp(res(1,3))

if(res(1,3)==2)%Gia gencost polynomial
c9=res(1,7);c8=res(1,8);c7=res(1,9);c6=res(1,10);c5=res(1,11);c4=res(1,12);c3=res(1,13);c2=res(1,14);c1=res(1,15);c0=res(1,16);
% p = poly2sym([c9 c8 c7 c6 c5 c4 c3 c2 c1 c0])
% bidy = matlabFunction(p)
bidy = @(x)x.^9.*c9 + x.^8.*c8 + x.^7.*c7 + x.^6.*c6 + x.^5.*c5 + x.^4.*c4 + x.^3.*c3 + x.^2.*c2 + x.*c1 + c0;
%bidy = bid(x)
%plot(x, bidy)
end
if(res(1,3)==1)%gia gencost linear
    x1=res(1,7);y1=res(1,8);x2=res(1,9);y2=res(1,10);x3=res(1,11);y3=res(1,12);x4=res(1,13);y4=res(1,14);x5=res(1,15);y5=res(1,16);
if(x3 ==0 && x4==0 && x5 ==0)
a=(y2-y1)/(x2-x1);
f = @(x)((a*(x-x1) + y1).*(x>=x1 & x<x2));
bidy = f;
end

if(x3 ~=0 && x4==0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));
f= @(x) f1(x) + f2(x);
bidy = f;
end

if(x3 ~=0 && x4~=0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));


f= @(x) f1(x) + f2(x) + f3(x);
bidy = f;
end

if(x3 ~=0 && x4~=0 && x5 ~=0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));

a4=(y5-y4)/(x5-x4);
f4 = @(x)((a4*(x-x4) + y4).*(x>x4 & x<=x5));

f= @(x) f1(x) + f2(x) + f3(x) + f4(x);
bidy = f;
end
end
%ACTUAL
query = sprintf("SELECT * FROM `actualcost_hist` WHERE (`actualcost_hist`.`userid` = %d && `actualcost_hist`.`roundid` = %d)" ,k ,r);
res = fetch(exec(conn , query));
res = cell2mat(res.Data);
if(res(1,3)==2)%Gia actual polynomial
c9=res(1,7);c8=res(1,8);c7=res(1,9);c6=res(1,10);c5=res(1,11);c4=res(1,12);c3=res(1,13);c2=res(1,14);c1=res(1,15);c0=res(1,16);
% p1 = poly2sym([c9 c8 c7 c6 c5 c4 c3 c2 c1 c0])
% acty = matlabFunction(p1)
acty = @(x)x.^9.*c9 + x.^8.*c8 + x.^7.*c7 + x.^6.*c6 + x.^5.*c5 + x.^4.*c4 + x.^3.*c3 + x.^2.*c2 + x.*c1 + c0;
end
if(res(1,3)==1)%Gia actual linear
    x1=res(1,7);y1=res(1,8);x2=res(1,9);y2=res(1,10);x3=res(1,11);y3=res(1,12);x4=res(1,13);y4=res(1,14);x5=res(1,15);y5=res(1,16);
    if(x3 ==0 && x4==0 && x5 ==0)
a=(y2-y1)/(x2-x1);
f = @(x)((a*(x-x1) + y1).*(x>=x1 & x<x2));
acty = f;
    end
if(x3 ~=0 && x4==0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));
f= @(x) f1(x) + f2(x);
acty = f;
end

if(x3 ~=0 && x4~=0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));


f= @(x) f1(x) + f2(x) + f3(x);
acty = f;
end

if(x3 ~=0 && x4~=0 && x5 ~=0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));

a4=(y5-y4)/(x5-x4);
f4 = @(x)((a4*(x-x4) + y4).*(x>x4 & x<=x5));

f= @(x) f1(x) + f2(x) + f3(x) + f4(x);
acty = f;
end

    
end






end

%---------------------------------------------------------------------------------------%




%------------------------------------------current round-------------------
if (r<0)
%GENCOST
query  = sprintf("SELECT * FROM `gencost` WHERE `gencost`.`userid`= %d " , k );
disp(query)
res = fetch(exec(conn,query));
res=cell2mat(res.Data);

if(res(1,2)==2)%Gia gencost polynomial
c9=res(1,6);c8=res(1,7);c7=res(1,8);c6=res(1,9);c5=res(1,10);c4=res(1,11);c3=res(1,12);c2=res(1,13);c1=res(1,14);c0=res(1,15);
% p = poly2sym([c9 c8 c7 c6 c5 c4 c3 c2 c1 c0])
% bidy = matlabFunction(p)
bidy = @(x)x.^9.*c9 + x.^8.*c8 + x.^7.*c7 + x.^6.*c6 + x.^5.*c5 + x.^4.*c4 + x.^3.*c3 + x.^2.*c2 + x.*c1 + c0;
%bidy = bid(x)
%plot(x, bidy)
end
if(res(1,2)==1)%gia gencost linear
    x1=res(1,6);y1=res(1,7);x2=res(1,8);y2=res(1,9);x3=res(1,10);y3=res(1,11);x4=res(1,12);y4=res(1,13);x5=res(1,14);y5=res(1,15);
       
if(x3 ==0 && x4==0 && x5 ==0)
a=(y2-y1)/(x2-x1);
f = @(x)((a*(x-x1) + y1).*(x>=x1 & x<x2));
bidy = f;
end

if(x3 ~=0 && x4==0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));
f= @(x) f1(x) + f2(x);
bidy = f;
end

if(x3 ~=0 && x4~=0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));


f= @(x) f1(x) + f2(x) + f3(x);
bidy = f;
end

if(x3 ~=0 && x4~=0 && x5 ~=0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));

a4=(y5-y4)/(x5-x4);
f4 = @(x)((a4*(x-x4) + y4).*(x>x4 & x<=x5));

f= @(x) f1(x) + f2(x) + f3(x) + f4(x);
bidy = f;
end
end






%ACTUAL
query = sprintf("SELECT * FROM `actualcost` WHERE `actualcost`.`userid` = %d " ,k );
res = fetch(exec(conn , query));
res = cell2mat(res.Data);


if(res(1,2)==2)%Gia actual polynomial
c9=res(1,6);c8=res(1,7);c7=res(1,8);c6=res(1,9);c5=res(1,10);c4=res(1,11);c3=res(1,12);c2=res(1,13);c1=res(1,14);c0=res(1,15);
% p1 = poly2sym([c9 c8 c7 c6 c5 c4 c3 c2 c1 c0])
% acty = matlabFunction(p1)
acty = @(x)x.^9.*c9 + x.^8.*c8 + x.^7.*c7 + x.^6.*c6 + x.^5.*c5 + x.^4.*c4 + x.^3.*c3 + x.^2.*c2 + x.*c1 + c0;
%acty = act(x)
%hold on;
%plot(x, acty)


end
if(res(1,3)==1)%Gia actual linear
   x1=res(1,6);y1=res(1,7);x2=res(1,8);y2=res(1,9);x3=res(1,10);y3=res(1,11);x4=res(1,12);y4=res(1,13);x5=res(1,14);y5=res(1,15);
      x1=res(1,7);y1=res(1,8);x2=res(1,9);y2=res(1,10);x3=res(1,11);y3=res(1,12);x4=res(1,13);y4=res(1,14);x5=res(1,15);y5=res(1,16);
if(x3 ==0 && x4==0 && x5 ==0)
a=(y2-y1)/(x2-x1);
f = @(x)((a*(x-x1) + y1).*(x>=x1 & x<x2));
acty = f;
end

if(x3 ~=0 && x4==0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));
f= @(x) f1(x) + f2(x);
acty = f;
end

if(x3 ~=0 && x4~=0 && x5 ==0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));


f= @(x) f1(x) + f2(x) + f3(x);
acty = f;
end

if(x3 ~=0 && x4~=0 && x5 ~=0)
a1=(y2-y1)/(x2-x1);
f1 = @(x)((a1*(x-x1) + y1).*(x>=x1 & x<=x2));

a2=(y3-y2)/(x3-x2);
f2 = @(x)((a2*(x-x2) + y2).*(x>x2 & x<=x3));

a3=(y4-y3)/(x4-x3);
f3 = @(x)((a3*(x-x3) + y3).*(x>x3 & x<=x4));

a4=(y5-y4)/(x5-x4);
f4 = @(x)((a4*(x-x4) + y4).*(x>x4 & x<=x5));

f= @(x) f1(x) + f2(x) + f3(x) + f4(x);
acty = f;
end
end

end
end