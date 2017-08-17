function [x xb]=modulation2(nsym,modulation)
%x:símbolos.
%xb:bits.
if modulation=='QPSK'
    n=2; %Orden de la modulación
    n1 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
    n2 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
    
end
x=(n1+j*n2)/sqrt(2);
xb=[n1 n2];
end