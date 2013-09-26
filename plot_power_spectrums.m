function [] = plot_power_spectrums(data_left, data_right)
%plot_power_spectrums Summary of this function goes here
%   Detailed explanation goes here

 [VALUES, VALUES_FILT] = Extract_frequency_features(64,data_left);
 for i = 1:144
    for j = 1:10
        if(VALUES_FILT(i,j)>10^(-2))
            VALUES_FILT(i,j)=0;
        end
    end
 end
 imagesc(transpose(VALUES_FILT));
 [VALUES, VALUES_FILT] = Extract_frequency_features(64,data_right);
 for i = 1:144
    for j = 1:10
        if(VALUES_FILT(i,j)>10^(-2))
            VALUES_FILT(i,j)=0;
        end
    end
 end
 figure(2);
 imagesc(transpose(VALUES_FILT));
 
end

