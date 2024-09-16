%This functions returns each time we execute it returns a table with
%ifnoramtion about rounds.These informations are saved in rounds_info
%table.
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.


function tab = infround()
result = sql("SELECT * FROM rounds_info")
tab(:,1) = result(:,1)
tab(:,2) = result(:,5)
tab(:,3) = result(:,3)
tab(:,4) = result(:,2)
end