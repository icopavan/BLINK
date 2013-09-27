function [VALUES, VALUES_FILT] = Extract_frequency_features(window_size,data)
%Extract_frequency_features extract frequency features using given window
%(window given in number of time samples)
%size
%   Warning: some window size might result in unproper execution of script (don't go higher than 0.25 second with current script).

VALUES=[];
VALUES_FILT=[];
for i = 1:144
    VALUES(i,:)= pwelch(data((i-1)*16+192:(i-1)*16+window_size+192),window_size,[],64,256); %16 is the shift 16*(1/256)=.0625 seconds
end

for i = 1:144
    for j = 1:window_size/2
        if(j>=0 && j<=10)   
            VALUES_FILT(i,j)= VALUES(i,j);
        end
    end
end


end

