function [ a1 a2 ] = threshold( w1,w2,x, ms1, draw )
%THRESHOLD looks at a window and determines if their mean is x times
%biggers than the ms1
%   w1 & w2 - window of signal 1 and 2
%   x - threshold multiplicator
%   ms1 - baseline of signal1

w1 = smooth(abs(hilbert(w1)),10);
w2 = smooth(abs(hilbert(w2)),10);


if(mean(w1) > x*ms1)
    a1 = 1;
else
    a1 = 0;
end

if(mean(w2) > x*ms1)
    a2 = 1;
else
    a2 = 0;
end

% for i = 1:1:length(w1)
%     if(w1(i)>x*ms1)
%        counter = counter +1;
%     else
%         counter = 0;
%     end
%     
%     if(counter > 20)
%         blink1 = blink1+1;
%         counter = 0;
%     end
% end
% 
% blink2=0;
% counter = 0;
% for i = 1:1:length(w2)
%     if(w2(i)>x*ms1)
%        counter = counter +1;
%     else
%         counter = 0;
%     end
%     
%     if(counter > 20)
%         blink2 = blink2+1;
%         counter = 0;
%     end
% end

    


% if(draw)
%     hold off;
%     figure(3);
%     plot(w1);
%     hold on;
%     plot(w2,'r');
% end

end

