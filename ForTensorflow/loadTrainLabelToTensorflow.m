testLabel = zeros(50,50)
trainLabel  = zeros(250,50)
for i = 1 : 50
   trainLabel((i-1)*5+1:i*5,i) = i; 
   testLabel(i,i)= i;
end

save trainLabel.mat trainLabel
save testLabel.mat testLabel