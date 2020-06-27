%Cálculo automático do SNR para obtenção do valor de threshold mais indicado

function threshold = aplicar_threshold_automatico_v1(sinal, Fs)

potencia_sinal = mean(sinal.^2);            %potencia do sinal
potencia_ruido = mean(sinal(1:(Fs/5)).^2);  %potencia do ruido, considerando que a primeira quinta parte do sinal é ruído

SNR = 10*log10(potencia_sinal/potencia_ruido); %calculo do SNR pela formula em dBs

disp('SNR:')
disp(SNR)

if (SNR <= 0)
    disp ('O ruido é em potência superior à fala.');
    threshold = 0.55;
elseif (SNR >= 0 && SNR <5)
    threshold = SNR*((0.6-0.55)/5)+0.55; %Calculo da reta do intervalo de 0 a 5
elseif (SNR >= 5 && SNR <10)
    threshold = SNR*((0.8-0.6)/5)+(0.6-((0.8-0.6)/5)*5); %Calculo da reta do intervalo de 5 a 10
elseif (SNR >=10 && SNR <15)
    threshold = SNR*((1-0.8)/5)+(0.8-((1-0.8)/5)*10); %Calculo da reta do intervalo de 10 a 15
elseif (SNR >=15 && SNR <20)
    threshold = SNR*((1.5-1)/5)+(1-((1.5-1)/5)*15); %Calculo da reta do intervalo de 15 a 20
elseif (SNR >=20 && SNR <25)
    threshold = SNR*((2-1.5)/5)+(1.5-((2-1.5)/5)*20); %Calculo da reta do intervalo de 20 a 25
elseif (SNR >=25 && SNR <30)
    threshold = SNR*((4.5-2)/5)+(2-((4.5-2)/5)*25); %Calculo da reta do intervalo de 25 a 30
elseif (SNR >=30 && SNR <35)
    threshold = SNR*((6-4.5)/5)+(4.5-((6-4.5)/5)*30); %Calculo da reta do intervalo de 30 a 35
elseif (SNR >=35 && SNR <40)
    threshold = SNR*((12-6)/5)+(6-((12-6)/5)*35); %Calculo da reta do intervalo de 35 a 40
elseif (SNR >=40)
    threshold = 12; %Calculo da reta para SNR superior ou igual a 40dBs
    
end
