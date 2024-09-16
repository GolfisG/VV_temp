%This function is responsible to plot each users gencost formula based on
%round.It takes as input's arguments the plotting area(handle) , userid and
%finally roundid.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function plotarei(handle , k,r)
[pg pr bidy acy min max] = profit(k,r)
     %[bidy acy min max] = plPol(k,r)
   if(pg==0 && pr==0)
       disp("False input data")
    end
    if(pg~=0) 
        t=linspace(min,max);
    plot(handle , t(1,1:end) , bidy(t(1,1:end)))  
    hold(handle)
    pause(0.4)
    plot(handle, t(1,1:end) , acy(t(1,1:end)))
    pause(0.3)
    t1=linspace(0,pg)  
    pause(0.05)
    plot(handle , t1(1,1:end) , pr(1,1:end))
    
    end
































end