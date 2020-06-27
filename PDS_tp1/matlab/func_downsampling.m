function y=func_downsampling(signal,N) 
    %%y = zeros(1, 8000);
 
for i=1 : (length(signal)/N) 
    y(i)=signal(N*i);                 %% resampling N to N samples 
end