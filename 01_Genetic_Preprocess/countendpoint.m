%% count point in 4x4
function [count] =  countendpoint(x,y,img)

     count = (sum(img(x-1:x+1,y-1:y+1)));
end