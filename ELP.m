function[v]=ELP(Ts,Nos,alpha,beta)
T=1;
Ts=1;
t1 = [-8*Ts:Ts/Nos:-Ts/Nos];
t2 = [Ts/Nos:Ts/Nos:8*Ts];
t = [t1 0 t2];
for i=1:1:length(t)    
    if t(i)~=0
        v(i)=sinc(t(i)/T) * sinc(alpha*t(i)/T) * exp(-0.5 * pi * beta * (t(i)/T)^2);  % # typical case
    else
        v(i)=1;  % L'Hopital limit for alpha * tau = 0.5
    end
end
end