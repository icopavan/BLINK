function [ bl ms1] = baseliner( signal1, signal2, istart, iend,draw)
%BASELINER adjusts the amplitudes of the second signal to the same baseline
%as the first signal
%   signal1 & 2 must be superior the the given interval
%   istart iend - interval of the signal on which the baseline is evaluated 
%   draw - defines if a figure should be drawn 
%   RETURN 
%       bl is the basline coefficient to be applied to signal2
%       ms1 is the mean of signal 1 baseline

sum1=0;
sum2=0;
temps1= abs(signal1);
temps2= abs(signal2);

for i = istart:1:iend
    sum1 = sum1 + temps1(i);
    sum2 = sum2 + temps2(i);
end

baselinediff = sum1/sum2;

signal2 = signal2 * baselinediff;

bl = baselinediff;
ms1 = sum1/(iend-istart+1);

if(draw)
    hold off;
    figure(2);
    plot(signal1);
    hold on;
    plot(signal2,'r');
end

end

