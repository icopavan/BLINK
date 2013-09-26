VALUES=[];
VALUES_FILT=[];
for i = 1:144
    VALUES(i,:)= pwelch(temp2((i-1)*16+1:(i-1)*16+256),256,128,[],512);
end

for i = 1:144
    for j = 1:129
        if(j>=2 && j<=25)
            VALUES_FILT(i,j-1)= VALUES(i,j);
        end
    end
end

% LABELS = [];
% LABELS=vertcat(LABELS,zeros(100,1));
% TRAINING=[]
% TRAINING=VALUES_FILT_ACTIVE(1:100,:)
% TRAINING=vertcat(TRAINING,VALUES_FILT_REST(1:100,:));
% TEST=[]
% TEST=VALUES_FILT_ACTIVE(101:128,:)
% TEST=vertcat(TEST,VALUES_FILT_REST(101:128,:));
% [class,err,POSTERIOR,logp,coeff] = classify(TEST,TRAINING,LABELS);