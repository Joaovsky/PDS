function filtered=my_wiener(signal)

varn=var(signal(1:500));
for i=501:length(signal)
    vars=var(signal(i-500:i));
    means=mean(signal(i-500:i));
    filtered (i)=means+((vars-varn)/vars)*(signal(i)-means);
end

