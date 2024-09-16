function id = recep(us)
res = sql("SELECT * FROM users")
for i=1:height(res)
if(us==string(res{i,2}))
    id=table2array(res(i,1))
end
    
end