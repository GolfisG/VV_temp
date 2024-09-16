function  pass_init(app)
res = sql("SELECT * FROM users");

tab(:,1) = res(:,1);
tab(:,2) = res(:,2);
tab(:,3) = res(:,3);

set(app , 'data' , tab);
end