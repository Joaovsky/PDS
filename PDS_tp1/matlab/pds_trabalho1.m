
%SOUND RECORDING
Fs = 8000;
sound_object = audiorecorder(Fs,8,1)                                        %% Parameters: 8000Hz, 8 bits, 1 channel
recordblocking(sound_object, 3);                                            %% Records for 5 secs
sound_array = getaudiodata(sound_object);                                   %% Converts object to plottable sound
figure
plot(sound_array);                                                          %% Plot 8kHz original sound signal 
title('Sound signal');                        
%%figure
%%freqz(sound_array);                                                       %% Bode diagram of sound signal
%%title('Bode diagram of sound signal');
sound(sound_array);                                                         %% Original sound replay


for N=2 : 8                                                              %% Recursive-like for
%%FILTER
Wp = 2*tan((pi/N)/2);                                                       %% Passband edge frequency
Ws = 2*tan((1.2*pi/N)/2);                                                   %% Stopband edge frequency 
Rp = -20*log(0.99);                                                         %% Passband Ripple 40 db
Rs = 60;                                                                    %% Stopband Ripple 60 db
[n, Wp] = ellipord(Wp, Ws, Rp, Rs, 's');                                    %% Outputs a low-pass n ord elliptic filt.
[b, a] = ellip(n, Rp, Rs, Wp, 's');                                         %% Design an eliptic filter
[num, den] = bilinear(b, a, 1);                                             %% Using bilinear method


%%FILTERED SIGNAL
filtered_signal = filter(num,den,sound_array);                              %% Filtered signal
%%freqz(filtered_signal);                                                   %% Filtered downsampled signal
%%title('Bode diagram of filtered signal');
sound(filtered_signal, Fs);                                                 %% Filtered sound replay


%%DOWNSAMPLING SIGNAL
downsampled_signal = func_downsampling(sound_array, N);                     %% Downsampling reduces numb samples
figure
%%plot(downsampled_signal);                                                   %% Plot 8/N kHz downsampled signal
%%title(sprintf('8 kHz downsampled sound signal, N=%d', N));                  
%%figure
%%freqz(downsampled_signal);                                                %% Bode diagram of downsampled signal
%%title(sprintf('Bode diagram of downsampled sound signal, N=%d', N));
sound(downsampled_signal, Fs/N);                                            %% Downsampled sound repla


%%FILTER/DOWNSAMPLING SIGNAL
filtered_downsampled_signal = func_downsampling(filtered_signal, N);            %% Filtered signal
%%filtered_downsampled_signal = filter(num,den,downsampled_signal);         %% Filtered downsampled signal
sound(filtered_downsampled_signal, Fs/N);                                   %% Filtered/downsampled sound replay
%%filtered_downsampled_signal = upsample(filtered_downsampled_signal, N);   %% Upsampled so it is easy to compare
%%plot(filtered_downsampled_signal);                                          %% Plot filtered 8/N kHz downsampled signal
%%title(sprintf('Filtered Downsampled signal, N=%d', N));   
%%figure 
%%freqz(filtered_downsampled_signal);                                       %% Bode diagram of downsampled signal
%%title (sprintf('Bode diagram of downsampled filtered signal, N= %d', N));


%%Comparison between Original/DS/Filtered_downsampled
figure
plot(sound_array, 'b-');                                
hold on
plot(filtered_signal, 'r-');
plot(downsampled_signal, 'y-');
plot(filtered_downsampled_signal, 'g-');                                    %% Plot original and dec/filt 8 kHz signal
hold off 
title(sprintf('Original and Filtered signal, N=%d', N));
figure
%%freqz(num,den);                                                             %% Bode diagram of eliptic filter
title (sprintf('Bode Diagram of Low-pass eliptic filter, N=%d', N));


%% N point FFT for aliasing analysis
%%downsampled_signal = upsample(downsampled_signal, N);     
L1=length(downsampled_signal);                                               %% Aliasing effect w/ FFT with zero-padding
NFFT1 = 2^nextpow2(L1);                                                      %% Better Frequency Resolution
decimated_signal_fft1 = abs(fft(downsampled_signal, NFFT1));
freq1 = (Fs / (2*N)) * linspace(0, 1, NFFT1 / 2 + 1);    
figure;
%%subplot(2,1,1);
plot(freq1, decimated_signal_fft1(1 : NFFT1 / 2 + 1));
hold on;
title(sprintf('Espectro do Sinal Decimado e não filtrado com N= %d', N));
xlabel('frequency (Hz)');
ylabel('Amplitude');
L2=length(filtered_downsampled_signal);                                          
NFFT2 = 2^nextpow2(L2);
decimated_signal_fft2 = abs(fft(filtered_downsampled_signal, NFFT2));
freq2 = (Fs / (2*N)) * linspace(0, 1, NFFT2 / 2 + 1);
%%subplot(2,1,2);
plot(freq2, decimated_signal_fft2(1 : NFFT2 / 2 + 1));
title(sprintf('Espectro do Sinal Decimado e filtrado com N= %d', N));
xlabel('Frequencia (Hz)');
ylabel('Amplitude');  
%%grid;
end  


  