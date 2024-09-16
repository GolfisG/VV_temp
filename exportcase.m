%This function creates a file with an exported case of Admin's choice.
%The unique input is the name of the file.
%
%Authors:Karampasis Kleitos , Gkolfinopoulos Panagiotis
%This code is intented for educational reasons.

function exportcase(a)
fname = a;

mpc.version = '2';
mpc.baseMVA = 100;
mkt.OPF = 'AC';
global pd_change;
javaaddpath('C:\Program Files\MATLAB\R2022b\java\jarext\mysql-connector-java-8.0.16.jar');
conn = database('vem','root','','com.mysql.cj.jdbc.Driver','jdbc:mysql://127.0.0.1:3306/vem');

load_reset();

mpc.version = '2';
mpc.baseMVA = 100;
res = sql('SELECT * FROM branch');
mpc.branch = table2array(res(:,2:end));
res = sql('SELECT * FROM bus');
mpc.bus = table2array(res);
res1=sql('SELECT * FROM gen');
mpc.gen = table2array(res1(:,2:end));
res2=sql('SELECT * FROM gencost');
mpc.gencost= table2array(res2(:,2:end));


%%%%%%%%%%%%%%%%%%%%  LOADCHANGE START &&&&&&&&&&&&&&&&&&&&&&&&&&&

query = "Select COUNT(*) From `rounds_info`";
t = fetch(exec(conn,query));
roundid = cell2mat(t.Data);
selectquery = 'SELECT * FROM loads';
data = select(conn,selectquery);
data = table2array(data);

data1 = zeros(1,25);
for i = 1:5
    for j = i:5
        if data(j,1) < data(i,1)
            data1(1,:) = data(i,:);
            data(i,:) = data(j,:);
            data(j,:) = data1(1,:);
        end
    end
end


chgtab =  [1 1 7 6 3 2 0
           1 1 7 10 3 2 0
           1 1 7 17 3 2 0
           1 1 7 28 3 2 0
           1 1 7 19 3 2 0
           1 1 9 11 -2 2 0
           1 1 9 12 -2 2 0
           1 1 9 13 -2 2 0
           1 1 9 14 -2 2 0
           1 1 9 15 -2 2 0];
          
         

for i = 1:5 
    chgtab(i,7) = 1+ data(i,roundid+1)/100; 
end

for j = 6:10 
    chgtab(j,7) = 1+ data(j-5,roundid+1)/100;  
end

mpc_new1 = apply_changes(1, mpc, chgtab);

%%%%%%%%%%%%%%%%%%%%  LOADCHANGE END &&&&&&&&&&&&&&&&&&&&&&&&&&&

%%%%%%%%%%%%%%%%%%%%  GEN_STATUS/Pd_Change START  &&&&&&&&&&&&&&&&&&&&&&&&&&&
selectquery = 'SELECT * FROM gen';
data3 = select(conn,selectquery);
data3 = table2array(data3);

chgtab1 = [3 1 2 1 8 1 0
           3 1 2 2 8 1 0
           3 1 2 3 8 1 0
           3 1 2 4 8 1 0
           3 1 2 5 8 1 0
           3 1 2 6 8 1 0
           3 1 2 7 8 1 0
           3 1 2 8 8 1 0
           3 1 2 9 8 1 0
           3 1 2 10 8 1 0
           3 1 8 1 2 2 0
           3 1 8 2 2 2 0
           3 1 8 3 2 2 0];
for i = 1:10
     chgtab1(i,7) = data3(i,9);
end

gens_off = 0;       
for i = 1:10
    if chgtab1(i,7) <= 0
        gens_off = gens_off + 1;
    end
end 

if gens_off == 1
    
        chgtab1(11,7) = pd_change;
        chgtab1(12,7) = pd_change;
        chgtab1(13,7) = pd_change;
        
elseif gens_off == 0
    
        chgtab1(11,7) = pd_change;
        chgtab1(12,7) = pd_change;
        chgtab1(13,7) = pd_change;
    
elseif gens_off > 1
    disp("ERROR : You cannot shutdown two or more Generators simultaneously")
    return
end    

mpc_new2 = apply_changes(3,mpc_new1,chgtab1);
%%%%%%%%%%%%%%%%%%%%  GEN_STATUS/Pd_Change END  &&&&&&&&&&&&&&&&&&&&&&&&&&&

%%%%%%%%%%%%%%%%%%%%  BRANCHCHANGE START  &&&&&&&&&&&&&&&&&&&&&&&&&&&
selectquery = 'SELECT * FROM branch';
data = select(conn,selectquery);
data = table2array(data);


chg_tab = [1 1 3 1 11 1 0
           1 1 3 2 11 1 0
           1 1 3 3 11 1 0
           1 1 3 4 11 1 0
           1 1 3 5 11 1 0
           1 1 3 6 11 1 0
           1 1 3 7 11 1 0
           1 1 3 8 11 1 0
           1 1 3 9 11 1 0
           1 1 3 10 11 1 0
           1 1 3 11 11 1 0
           1 1 3 12 11 1 0
           1 1 3 13 11 1 0
           1 1 3 14 11 1 0
           1 1 3 15 11 1 0
           1 1 3 16 11 1 0
           1 1 3 17 11 1 0
           1 1 3 18 11 1 0
           1 1 3 19 11 1 0
           1 1 3 20 11 1 0
           1 1 3 21 11 1 0
           1 1 3 22 11 1 0
           1 1 3 23 11 1 0
           1 1 3 24 11 1 0
           1 1 3 25 11 1 0
           1 1 3 26 11 1 0
           1 1 3 27 11 1 0
           1 1 3 28 11 1 0
           1 1 3 29 11 1 0
           1 1 3 30 11 1 0
           1 1 3 31 11 1 0
           1 1 3 32 11 1 0
           1 1 3 33 11 1 0
           1 1 3 34 11 1 0
           1 1 3 35 11 1 0
           1 1 3 36 11 1 0
           1 1 3 37 11 1 0
           1 1 3 38 11 1 0
           1 1 3 39 11 1 0
           1 1 3 40 11 1 0
           1 1 3 41 11 1 0
           1 1 3 42 11 1 0
           1 1 3 43 11 1 0
           1 1 3 44 11 1 0
           1 1 3 45 11 1 0
           1 1 3 46 11 1 0];

 for i = 1:46
     chg_tab(i,7) = data(i,12);
 end

mpc_new3 = apply_changes(1,mpc_new2,chg_tab);
%%%%%%%%%%%%%%%%%%%%  BRANCHCHANGE END  &&&&&&&&&&&&&&&&&&&&&&&&&&&

%%%%%%%%%%%%%%%%%%%%  THERMALLIMIT START  &&&&&&&&&&&&&&&&&&&&&&&&&&&

selectquery = 'SELECT * FROM limits';
data2 = select(conn,selectquery);
data2 = table2array(data2);
disp(data2);

chg_tab1 = [2 1 3 1 6 2 1.1
           2 1 3 2 6 2 0
           2 1 3 3 6 2 0
           2 1 3 4 6 2 0
           2 1 3 5 6 2 0
           2 1 3 6 6 2 0
           2 1 3 7 6 2 0
           2 1 3 8 6 2 0
           2 1 3 9 6 2 0
           2 1 3 10 6 2 0
           2 1 3 11 6 2 0
           2 1 3 12 6 2 0
           2 1 3 13 6 2 0
           2 1 3 14 6 2 0
           2 1 3 15 6 2 0
           2 1 3 16 6 2 0
           2 1 3 17 6 2 0
           2 1 3 18 6 2 0
           2 1 3 19 6 2 0
           2 1 3 20 6 2 0
           2 1 3 21 6 2 0
           2 1 3 22 6 2 0
           2 1 3 23 6 2 0
           2 1 3 24 6 2 0
           2 1 3 25 6 2 0
           2 1 3 26 6 2 0
           2 1 3 27 6 2 0
           2 1 3 28 6 2 0
           2 1 3 29 6 2 0
           2 1 3 30 6 2 0
           2 1 3 31 6 2 0
           2 1 3 32 6 2 0
           2 1 3 33 6 2 0
           2 1 3 34 6 2 0
           2 1 3 35 6 2 0
           2 1 3 36 6 2 0
           2 1 3 37 6 2 0
           2 1 3 38 6 2 0
           2 1 3 39 6 2 0
           2 1 3 40 6 2 0
           2 1 3 41 6 2 0
           2 1 3 42 6 2 0
           2 1 3 43 6 2 0
           2 1 3 44 6 2 0
           2 1 3 45 6 2 0
           2 1 3 46 6 2 0];


 for i = 2:46
     chg_tab1(i,7) = 1 + data2(i,2)/100;
 end


mpc_new = apply_changes(2,mpc_new3,chg_tab1);
disp(mpc_new.branch)
%%%%%%%%%%%%%%%%%%%%  THERMALLIMIT END  &&&&&&&&&&&&&&&&&&&&&&&&&&&

savecase(fname, mpc_new)
fprintf(" Scenario succesfully exported as: '%s'",fname)
end