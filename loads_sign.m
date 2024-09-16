%The above code connects in our database at it compares if the given
%credentials are equal with some user's data from 'users' SQL table.
%If user's credential are right then it returns userid.
%
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.


function [validate, i] = loads_sign(user,pass)
i=0;
validate=0;
res = sql('SELECT * FROM users');
t=size(res,1);
for k=11:t
    if (user==string(res{k,2}) && pass==string(res{k,3}))
        validate =1;
        i=k;
    end
end
end