makePatch();

for hidden=50:50:50 
    for i=1:2:7
        %16times,iteration 700 times
        theta = initializeParameters(hidden, 100); 
        opt = linearDecoder( hidden, i, theta );%self learning
    end
end
