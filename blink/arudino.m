%%
% Read the values returned by an ARDUINO
% example of ARDUINO code :
% void setup()
% {
%   Serial.begin(115200);
% }
%
% void loop()
% {
%   int firstValue=1;
%   int secondValue=2;
%
%   Serial.println(firstValue);
%   delay(2); //between 2 values it may be needed to wait
%   Serial.println(secondValue);
%
%   delay(40); //TO BE TESTED, SOMETIMES MATLAB IS TOO SLOW TO EMPTY THE
%   //BUFFER IN TIME, THUS IT DOESN'T STAY IN REAL-TIME...
%
% }


%the following lines verify that the port was closed, which is not the case
%if an error occured

try
    fclose(s);
    delete(s);
end
try
    
    clear all;
    close all;
    clc;
    
    % /!\ MODIFY HERE THE PATH OF THE SERIAL PORT  /!\
    % example of ports: COM6 (windows) or /dev/tty.usbmodemfd111(macos)
    %s = serial('/dev/cu.usbmodemfa131');
    s = serial('/dev/cu.usbmodemfd121');
    set(s,'BaudRate',115200);
    fopen(s);
    
    figure(100);
    plot([],[]);
    xlabel('time');
    ylabel('volts');
    hold on
    
    
    %change here the number of value corresponding to 1 trial:
    nbIn1Trial=3;%2 for the previous example
    
    array=zeros(1,nbIn1Trial);
    
    allData=[];
    
    while true
        
        for i=1:1:nbIn1Trial
            while s.BytesAvailable<=0
            end
            temp = fscanf(s,'%f');
            array(i)=temp
        end
        
        %from here, all the values for 1 trial are stored into the variable
        %'array'
        
        allData=[allData;array];
        
        %insert the plot commands here
        plot(allData(:,1)/100,allData(:,2)/10000);
        
        hold on
        %for real-time:
        drawnow
        %finish the operation if the figure is closed:
        if(ishandle(100)==false)
            break;
        end
    end
catch
    disp('fail !')
end
close all;
fclose(s);
delete(s);
clear s

%plot(allData(:,1),allData(:,2))
