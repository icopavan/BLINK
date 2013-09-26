function [] = plot_fft(signal,Fs)
%plot_fft computes and plots the FFT of a given signal, knowing its sampling rate
%frequency.
    signal2=fft(signal);
    signal2=ifftshift(abs(signal2));
    a=-1*(Fs/2)+Fs/length(signal);
    b=Fs/2;
    axis=[a:Fs/length(signal):b];
    plot(axis,signal2);
end
