clc;
close all;
%Signal generator block
[signal1 signal2] = simusignal(1500,1);



buffer1 = [];
buffer2 = [];
w=30;
bl_window=100;
blink1=[];
blink2=[];


for i= 1:1:length(signal1)
    
       pause(0.001);
    
       %baseline block
    if length(buffer1) < bl_window
        buffer1 = [buffer1 signal1(i)];
        buffer2 = [buffer2 signal2(i)];
        if length(buffer1) == bl_window
            [bl ms1] = baseliner(buffer1,buffer2,1,100,0);
            buffer2 = buffer2*bl;
        end
    else
        buffer1 = [buffer1 signal1(i)];
        buffer2 = [buffer2 signal2(i)*bl];
        %moving window block
        if(length(buffer1)>bl_window+w)
            [a1 a2] = threshold(buffer1(end-w:end),buffer2(end-w:end),3, ms1,1);
            blink1 = [blink1 a1];
            blink2 = [blink2 a2];
        end
        
 
    end
end



    figure(4);
    plot(buffer1);
    hold on;
    plot(buffer2,'r');
    a1_adjusted =[zeros(1,bl_window+w) blink1]*3*ms1;
    a2_adjusted =[zeros(1,bl_window+w) blink2]*3*ms1;
    plot(a1_adjusted,'g');
    plot(a2_adjusted,'y');

    



