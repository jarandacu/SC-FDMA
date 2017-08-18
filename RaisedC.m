function[v]=RaisedC(Ts,Nos,alpha)
T=1;
Ts=1;
t1 = [-8*Ts:Ts/Nos:-Ts/Nos];
t2 = [Ts/Nos:Ts/Nos:8*Ts];
t = [t1 0 t2];
for i=1:1:length(t)
    
    if abs(abs(alpha * t(i) / T) - 0.5) > 1e-5
        v(i)=sinc(t(i)/T) * cos(pi * alpha * t(i) / T) / (1 - (2 * alpha * t(i) / T)^2); % # typical case
    else
        v(i)=sinc(t(i)/T) * pi * sin(pi * alpha * t(i) / T) / (8 * alpha * t(i) / T);  % L'Hopital limit for alpha * tau = 0.5
    end
end
end