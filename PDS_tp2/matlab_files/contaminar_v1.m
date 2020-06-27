%Contaminação do sinal original com ruído branco

function [sinal] = contaminar_v1(recorded, SNR)

S=mean(recorded.^2);                % Potência do sinal
L=S-(var(recorded(1:500)));
N=L/(10^(SNR/10));                  % Fórmula SNR

n = randn(1,length(recorded));      
n = n - mean(n);                    %ruído branco com media 0
ruido = n * sqrt(N); 
sinal=recorded+ruido';