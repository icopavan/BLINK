function [] = plot_fft(signal,Fs)
%plot_fft computes and plots the FFT of a given signal (signal), knowing
%its sampling rate (Fs). Also plots the original signal for inspection.
%   Simple function displaying the FFT of the input signal as well as the signal itself.
   
    %performs the fast fourier transform
    signal2=abs(fft(signal,Fs));
    %shifts the result so that it is centered around 0 (this is not the
    %case with the initial output of the previous function)
    signal2=fftshift(abs(signal2));
   
    %defines the x-axis values corresponding to the fft (the frequency
    %values)
    axis_values=[-Fs/2:Fs/2-1];
    
    %choose subplot
    subplot(2,1,1);
    
    %plot initial signal
    plot(1:[length(signal)],signal,'b','LineWidth',1.5);
    
    %choose subplot
    subplot(2,1,2);
    
    %plots fft
    plot(axis_values,signal2,'r','LineWidth',1.5);
    
    %adjusted the look of the graph
    
    %enable tickmarks
    grid on;
    grid minor;
    
    %label graph and axes
    title('FFT of input signal');
    xlabel('Frequencies [Hz]');
    ylabel('Amplitude [-]');
    
    %define range of axes
    axis([(-Fs/2),(Fs/2),0,max(signal2)*1.05]);
    
    %set tick marks on x-axis
    set(gca,'XTick',[-1000:10:1000])

end
