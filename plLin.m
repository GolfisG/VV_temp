function plLin(x1 ,y1,x2,y2,x3,y3,x4,y4 ,x5 ,y5)
if( (x2~=0) && (y2~=0))
    x=[x1 x2];y=[y1 y2] ;
    if(x3~=0 && y3~=0)
    x=[x1 x2 x3];y=[y1 y2 y3]; 
        if(x4~=0 && y4~=0)
        x=[x1 x2 x3 x4];y=[y1 y2 y3 y4] ;
            if(x5~=0 && y5~=0)
            x=[x1 x2 x3 x4 x5];y=[y1 y2 y3 y4 y5] ;
end
end
end
end



    

line(x,y)
end