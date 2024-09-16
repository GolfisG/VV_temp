%This function set's the images that are contained inside Energy Market
%Application
%
%Author:Nikolaos Koutantos
%This code is intented for educational reasons.

function gridsetup(app, app1)
a = imread(pwd + "/Drawing1.jpg");
imshow(a , 'parent', app);

b=imread(pwd + "/log.jpg");
imshow(b , 'parent' , app1)
end