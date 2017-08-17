function y=demodulation2(x,modulation)
if modulation=='QPSK'
    n=2; %Orden de la modulación
    r=real(x);
    i=imag(x);
    r=r>0;
    i=i>0;
    r=r*2-1;
    i=i*2-1;
    y=(r+j*i)/sqrt(n);    
end
end