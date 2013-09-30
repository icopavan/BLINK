function [ signal1 signal2 blink1 blink2 ] = threshold( signal1,signal2,t, draw )
%THRESHOLD this function checks how many interval superior to 20 points are
%above are present
%   Detailed explanation goes here
signal1 = smooth(abs(hilbert(signal1)),20);
signal2 = smooth(abs(hilbert(signal2)),20);

mean1 = mean(signal1);
mean2 = mean(signal2);

blink1=0;
counter = 0;


for i = 1:1:length(signal1)
    if(signal1(i)>t*mean1)
       counter = counter +1;
    else
        counter = 0;
    end
    
    if(counter > 20)
        blink1 = blink1+1;
        counter = 0;
    end
end

blink2=0;
counter = 0;
for i = 1:1:length(signal2)
    if(signal2(i)>t*mean2)
       counter = counter +1;
    else
        counter = 0;
    end
    
    if(counter > 20)
        blink2 = blink2+1;
        counter = 0;
    end
end

    


if(draw)
    hold off;
    figure(3);
    plot(signal1);
    hold on;
    plot(signal2,'r');
end

end

