function br_initgen(app,boxdata)
res = sql("SELECT * FROM gen");
       
tab(:,1) = res(1:10,1);
tab(:,2) = res(1:10,9);
tab(:,3) = boxdata(1:10,1);

set(app , 'data' , tab);
end