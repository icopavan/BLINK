function plotfromserial

    clear
    close all;
    colourindexlist = [8 8 8 8 1 1 2 2 3 3 4 4 5 5 6 6 7];

%     [h,e] = IOPort('OpenSerialPort','/dev/tty.usbserial-A501GR7R')
% 
%     IOPort('ConfigureSerialPort',h,'BaudRate=57600');
%     IOPort('ConfigureSerialPort',h,'BlockingBackgroundRead=0');
%     IOPort('ConfigureSerialPort',h,'InputBufferSize=65536');
%     IOPort('ConfigureSerialPort',h,'PollLatency=0.0039');
% 
%     IOPort('Purge',h);
%     IOPort('Close',h);

    temp1 = [];
    temp2 = [];

    window=1; %in seconds
    charles=0;
    while(charles<10)
        [h,e] = IOPort('OpenSerialPort','/dev/tty.usbserial-A501GR7R')
     
        IOPort('ConfigureSerialPort',h,'BaudRate=57600');
        IOPort('ConfigureSerialPort',h,'BlockingBackgroundRead=0');
        IOPort('ConfigureSerialPort',h,'InputBufferSize=65536');
        IOPort('ConfigureSerialPort',h,'PollLatency=0.0039');
        
        IOPort('ConfigureSerialPort',h,'StartBackgroundRead=1');
        WaitSecs(window);
        bytestoget = 7000;%IOPort('BytesAvailable',h)
        [longdata,when,e] = IOPort('Read',h,1,bytestoget);
        length(longdata)

        IOPort('ConfigureSerialPort',h,'StopBackgroundRead');
        IOPort('Purge',h);
        IOPort('Close',h);
        
        if(length(longdata)>=256*window*17)
            longdata = longdata((end+1-(256*window*17)):end);
        else
            IOPort('Close',h);
            break;
        end
        s = length(longdata);
        roundedlength = floor(s/17)*17;
        longdata = longdata(1:roundedlength);
        s = length(longdata); 

        for n = 1:17
            parseddata(n,:) = longdata(n:17:s);
        end

        s = size(parseddata)
        allmeans = round(mean(parseddata,2));
        a = find(allmeans==165);

        sync0 = mod(a-1,17)+1;
        sync1 = mod(1+a-1,17)+1;
        version = mod(2+a-1,17)+1;
        pcount = mod(3+a-1,17)+1;
        
        lineID(1,1) = mod(4+a-1,17)+1;
        lineID(1,2) = mod(5+a-1,17)+1;

        lineID(2,1) = mod(6+a-1,17)+1;
        lineID(2,2) = mod(7+a-1,17)+1;

        lineID(3,1) = mod(8+a-1,17)+1;
        lineID(3,2) = mod(9+a-1,17)+1;

        lineID(4,1) = mod(10+a-1,17)+1;
        lineID(4,2) = mod(11+a-1,17)+1;

        lineID(5,1) = mod(12+a-1,17)+1;
        lineID(5,2) = mod(13+a-1,17)+1;

        lineID(6,1) = mod(14+a-1,17)+1;
        lineID(6,2) = mod(15+a-1,17)+1;

        switches = mod(16+a-1,17)+1;

        for l = 1:6
            for m = 1:s(2)
                trace(l,m) = bin2dec(strcat(dec2bin(parseddata(lineID(l,1),m)),dec2bin(parseddata(lineID(l,2),m))))./1023;
            end
        end

        channels(1,:) = trace(1,:);  % - trace(3,:);
        channels(2,:) = trace(2,:);  % - trace(4,:);
        channels(3,:) = trace(3,:);
        channels(4,:) = trace(4,:);

        ch1fft = fftshift(fft(channels(1,:)));
        ch2fft = fftshift(fft(channels(2,:)));
    %   ch3fft = fftshift(fft(channels(3,:)));
    %   ch4fft = fftshift(fft(channels(4,:)));
        bpfilter = zeros(1,s(2));
        bpfilter(1,0.35*s(2):0.65*s(2)) = 1;
        bpfilter(1,floor(s(2)/2)-2:ceil(s(2)/2)+4) = 0;
        ch1filtered = ch1fft .* bpfilter;
        ch2filtered = ch2fft .* bpfilter;
    %   ch3filtered = ch3fft .* bpfilter;
    %   ch4filtered = ch4fft .* bpfilter;

        close all;
    
        lengthseconds = s(2)/256;
        spectrumxvals = -(s(2)/2):(s(2)/2)-1;
%         figure(1)
%         hold on;
%         plot(spectrumxvals,abs(ch1fft),'k-','LineWidth',2, 'color', d_getgoodcolour(1))
%         % plot(spectrumxvals,abs(ch2fft),'k-','LineWidth',1, 'color', d_getgoodcolour(3))
%         % plot(spectrumxvals,abs(ch3fft),'k-','LineWidth',1, 'color', d_getgoodcolour(5))
%         % plot(spectrumxvals,abs(ch4fft),'k-','LineWidth',1, 'color', d_getgoodcolour(6))
% 
%         xlabel('Frequency (Hz)', 'FontSize', 12);
%         ylabel('Amplitude', 'FontSize', 12);
%         set(gcf,'Position',[343 82 560 420]);

        ch1ifft = real(ifft(fftshift(ch1filtered)));
        ch2ifft = real(ifft(fftshift(ch2filtered)));
    %   ch3ifft = real(ifft(fftshift(ch3filtered)));
    %   ch4ifft = real(ifft(fftshift(ch4filtered)));

        xvals = (1:s(2))/256;
        
        temp1 = (1:s(2)*(charles+1))/256;
        temp2 = [temp2 ch1ifft]

%         figure(2);
%         hold on;
%         plot(xvals,ch1ifft,'k-','LineWidth',2,'Color', d_getgoodcolour(1));
%         axis([0 1 -0.5 0.5]);
%         xlabel('Time (s)', 'FontSize', 12);
%         ylabel('Voltage', 'FontSize', 12);
%         set(gca,'XTick',0:0.25:1);
% 
%         set(gcf,'Position',[903 81 560 420]);
        charles=charles+1;
    end
    
    figure(2);
    hold on;
    plot(temp1,temp2,'k-','LineWidth',2,'Color', d_getgoodcolour(1));
    axis([0 10 -0.5 0.5]);
    xlabel('Time (s)', 'FontSize', 12);
    ylabel('Voltage', 'FontSize', 12);
    set(gca,'XTick',0:0.25:10);

    set(gcf,'Position',[903 81 560 420]);
    charles=charles+1;
    
    IOPort('Purge',h);
    IOPort('Close',h);

return
%--------------------------------------------------------------------------
function output = d_getgoodcolour(input)

    % this returns colour vectors so that i can have decent colours for graphs
    % knows red, green, blue, orange, purple, pink, brown, black

    while input > 8
        input = input - 8;
    end

    switch input
    case 1	%red
        r = 1;
        g = 0;
        b = 0;
    case 2	%green
        r = 0;
        g = 1;
        b = 0;
    case 3	%blue
        r = 0;
        g = 0;
        b = 1;
    case 4	%orange
        r = 1;
        g = 0.5;
        b = 0;
    case 5	%purple
        r = 0.6;
        g = 0.2;
        b = 1;
    case 6	%pink
        r = 1;
        g = 0.4;
        b = 0.8;
    case 7	%brown
        r = 0.6;
        g = 0.3;
        b = 0.3;
    case 8	%black
        r = 0;
        g = 0;
        b = 0;

    %         % now aquamarine
    %     r = 0;
    %     g = 0.8;
    %     b = 0.7;
    end

    output(1) = r;
    output(2) = g;
    output(3) = b;

return
%--------------------------------------------------------------------------