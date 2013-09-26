function [] = plot_fft(signal,Fs)
%plot_fft Compute and plot the FFT given a signal and its sampling
%frequency.
    signal2=fft(signal);
    signal2=ifftshift(abs(signal2));
    a=-1*(Fs/2)+Fs/length(signal);
    b=Fs/2;
    axis=[a:Fs/length(signal):b];
    plot(axis,signal2);
end
