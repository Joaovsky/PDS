%Separação de ruído branco esporádico da fala (sem pausas)

function [s_p, s_ruido] = retira_ruido_v1(sinal, threshold_limit, Fs)
       
noise_samples = floor(Fs/2);        %o primeiro meio segundo de amostras servirá para determinar as estatísticas gaussianas do ruído

%calculo da media e do desvio padrao do ruido
background_noise_array=[];

for i=1:1:noise_samples
    background_noise_array = [background_noise_array sinal(i)];
end

media_ruido=mean(background_noise_array);
desviop_ruido=std(background_noise_array);
mult_noise_constant = threshold_limit/desviop_ruido;


disp('Desvio Padrão do Sinal');
disp(desviop_ruido);
disp('Multiplicative Constante');
disp(mult_noise_constant);

for i=1:1:length(sinal)
    if(((abs(sinal(i)- media_ruido))/desviop_ruido) > threshold_limit)
        voice(i) = 1;%#voiced
    else
        voice(i) = 0;%#unvoiced
    end
end

% 10 ms per frame sample with Fs defined
samples_per_frame = floor(Fs/100);
disp('Amostras por frame:');         %100 amostras por frame
disp(samples_per_frame); 
number_samples = length(sinal) - mod(length(sinal), samples_per_frame); 
n_frames = number_samples/samples_per_frame;
frame_voice_count = zeros(1, n_frames);
for i = 1:1:n_frames
    c_voiced = 0;
    for j = i*samples_per_frame-samples_per_frame+1:1:i*samples_per_frame
        c_voiced = c_voiced + voice(j);
    end
    frame_voice_count(i) =  floor(c_voiced/((samples_per_frame/2)+1)); %Given frame: assigns 1 to it if #voiced > #unvoiced else 0
end
% sinal_puro = [sinal_puro sinal(j)];

s_p =[];
s_ruido =[];
consecutive_frame_voice_count = 0;
holding_samples = 0;
for i = 1:1:n_frames
    if(frame_voice_count(i) == 1)
        consecutive_frame_voice_count = consecutive_frame_voice_count+1;
        if(consecutive_frame_voice_count >= 25)
            for j = (i-24+24*holding_samples)*samples_per_frame-samples_per_frame+1:1:i*samples_per_frame
                s_p = [s_p sinal(j)];
            end
            holding_samples  = 1;
        end
    else
        if(consecutive_frame_voice_count < 25)
            for j = (i-consecutive_frame_voice_count)*samples_per_frame-samples_per_frame+1:1:i*samples_per_frame
                s_ruido = [s_ruido sinal(j)];     
            end
        end
        consecutive_frame_voice_count = 0;
        holding_samples = 0;
    end 
end
        
        
        