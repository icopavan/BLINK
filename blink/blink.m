[signal1 signal2] = simusignal(500,1);

[signal1 signal2] = baseliner(signal1,signal2,100,1);

[signal1 signal2 blink1 blink2] = threshold(signal1,signal2,2,1);

% abs(hilbert(signal1))