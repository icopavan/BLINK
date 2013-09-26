function [] = plot_fft(signal,Fs)
%plot_fft computes and plots the FFT of a given signal (signal), knowing its sampling rate (Fs).
%   Simple function displaying the FFT of the input signal.
   
    signal2=abs(fft(signal,Fs));
    signal2=fftshift(abs(signal2));
   
    axis_values=[-Fs/2:Fs/2-1];

    plot(axis_values,signal2,'r','LineWidth',1.5);
    grid on;
    grid minor;
    title('FFT of input signal');
    xlabel('Frequencies [Hz]');
    ylabel('Amplitude [-]');
    
    axis([(-Fs/2),(Fs/2),0,max(signal2)*1.05]);
    set(gca,'XTick',[-1000:10:1000])

end
