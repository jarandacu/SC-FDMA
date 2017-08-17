function x=modulation2(nsym,modulation)
if modulation=='QPSK'
    n=2; %Orden de la modulación
    n1 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
    n2 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
    
end
x=(n1+j*n2)/sqrt(2);
end