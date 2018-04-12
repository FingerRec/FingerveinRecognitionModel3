 
for hidden=50:50:50
    for i=1:2:1
        TrainFeatures = ConvolutionPooling( i, hidden, 'imgPack.mat' );
        save(sprintf('03_Convolution&Pooling/TrainFeatures/TrainFeatures_H%d_I%d.mat',hidden,i*100), 'TrainFeatures');
    end 
end
