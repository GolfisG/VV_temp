function  br_init(app)
res = sql("SELECT * FROM branch");

tab(:,1) = res(:,1);
tab(:,2) = res(:,2);
tab(:,3) = res(:,3);
tab(:,4) = res(:,12);

res1 = sql("SELECT * FROM limits");
tab(:,5) = res1(:,2);

set(app , 'data' , tab);
end