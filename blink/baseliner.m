function [ signal1 signal2 ] = baseliner( signal1, signal2, interval ,draw)
%BASELINER adjustssss the amplitudes of the two signals to the same baseline
%   interval goes from 1-interval
sum1=0;
sum2=0;
temps1= abs(signal1);
temps2= abs(signal2);

for i = 1:1:interval
    sum1 = sum1 + temps1(i);
    sum2 = sum2 + temps2(i);
end

baselinediff = sum1/sum2;

signal2 = signal2 * baselinediff;
if(draw)
    hold off;
    figure(2);
    plot(signal1);
    hold on;
    plot(signal2,'r');
end

end

