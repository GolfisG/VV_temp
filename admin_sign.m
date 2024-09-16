function [c] = admin_sign(user , pass)
c=0;
if(string(user) == "admin" && string(pass) == "admin")
    c=1 ;
end
end