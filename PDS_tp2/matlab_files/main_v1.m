%O PROGRAMA COMECA AQUI

%Captar sinal original
Fs=10000;
recorder = audiorecorder(Fs,16,1);
disp('Tem agora 5s, fale pausadamente')
record(recorder,5);
pause('on');
pause(5);
record2 = getaudiodata(recorder);
audiowrite('sinal_original.wav',record2,Fs);

%Ler som replicado para obtenção da carateristica SNR-Threshold
%[record2, FS]=audioread('C:\Users\João Faria\Desktop\UM\3 ano\2 sem\PDS\tp2\audio_files\sinal_original.wav');

disp('Reproduzir sinal de entrada')
%sound(record2, Fs);
%pause(5);

%Contaminar sinal com base no SNR
[sinal_contaminado] = contaminar_v1(record2, -10);

%Aplicar melhor Threshold
threshold = 0.1;
%threshold = aplicar_threshold_automatico_v1(record2, Fs);
disp('Threshold:')
disp(threshold)

sinal_decente=my_wiener(sinal_contaminado);
%Retirar Ruido
%[sinal_puro1, ruido1] = retira_ruido_v1(sinal_contaminado, threshold, Fs);
[sinal_puro2, ruido2] = retira_ruido_v1(sinal_decente, threshold, Fs);
disp('antes filtro');
sound(sinal_contaminado, Fs);
pause(5);
disp('dps filtro');
sound(sinal_decente, Fs);
pause(5);

sinal_f1=my_wiener(sinal_puro1);


%Mostrar gráfico temporal dos sinais 
f2 =figure('Name','Sinal original vs Sinal Puro vs Apenas ruido','NumberTitle','off');
subplot(3,1,1);
plot(record2);
title('Sinal Original');
subplot(3,1,2);
plot(sinal_contaminado);
title('Sinal contaminado com SNR -10 dBs');
subplot(3,1,3);
plot(sinal_puro2*10);
title('Sinal pós funcao filtro wiener e retira ruido amplificado 10x');

Gravar sinais puro e ruído
audiowrite('sinal_puro.wav',sinal_puro,Fs);
audiowrite('apenas_ruido.wav',ruido,Fs);

Reproduzir sinais puro e ruído
disp('Reproduzir sinal puro')
sound(sinal_puro1, Fs);
pause(5);
disp('Reproduzir sinal ruidoso')
sound(sinal_puro2*10, Fs);
pause(5);
sound(sinal_puro2*10, Fs);
pause(5);
sound(sinal_f1*10, Fs);

