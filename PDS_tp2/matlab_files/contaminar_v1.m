%Contamina��o do sinal original com ru�do branco

function [sinal] = contaminar_v1(recorded, SNR)

S=mean(recorded.^2);                % Pot�ncia do sinal
L=S-(var(recorded(1:500)));
N=L/(10^(SNR/10));                  % F�rmula SNR

n = randn(1,length(recorded));      
n = n - mean(n);                    %ru�do branco com media 0
ruido = n * sqrt(N); 
sinal=recorded+ruido';