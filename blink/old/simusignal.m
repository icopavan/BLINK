function [ signal1 signal2 ] = simusignal( length , draw )
%SIMUSIGNAL Summary of this function goes here
%min length is 500
%   this function takes length as a parameter to generate two signals
%   with noise and one activity peak randomly placed
%   Draw is a bool that defines if the signals are plotted.

signal1 = wgn(length,1,0);
signal2 = wgn(length,1,30);


activity1 = zeros(length,1);
activity2 = zeros(length,1);
blink1 = wgn(50,1,10);
blink2 = wgn(50,1,42);

pos1= randi([101,length-100]);
pos2 = randi([101,length-100]);
activity1 = [activity1(1:100)' activity1(101:pos1)' blink1' activity1((pos1+51):end)']';
activity2 = [activity2(1:100)' activity2(101:pos2)' blink2' activity2((pos2+51):end)']';


if(draw)
    figure(1);
    plot(signal1+activity1);
    hold on;
    plot(signal2+activity2,'r');
    hold off;
end
signal1= signal1+activity1;
signal2= signal2+activity2;

end

