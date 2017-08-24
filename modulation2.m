function [x xb]=modulation2(nsym,modulation)
%x:símbolos.
%xb:bits.
if modulation=='QPSK'
    n=2; %Orden de la modulación
    n1 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
    n2 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
elseif modulation=='16QAM'
    dataSet=[1+i 1-i -1+i -1-i...
    3+i 3-i -3+i -3-i...
    1+3i 1-3i -1+3i -1-3i...
    3+3i 3-3i -3+3i -3-3i];
    %dataSet=dataSet/sqrt(mean(abs(dataSet).^2));
    tmp=ceil(rand(nsym,1)*16);
    





end

x=(n1+j*n2)/sqrt(2);
xb=[n1 n2];
end