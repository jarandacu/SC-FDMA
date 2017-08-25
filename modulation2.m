function [x xb]=modulation2(nsym,mod)
%x:símbolos.
%xb:bits.
%modulation
switch mod
    case '16QAM'
    dataSet=[1+j 1-j -1+j -1-j...
    3+j 3-j -3+j -3-j...
    1+3j 1-3j -1+3j -1-3j...
    3+3j 3-3j -3+3j -3-3j];
    %dataSet=dataSet/sqrt(mean(abs(dataSet).^2));
    tmp=ceil(rand(nsym,1)*16);
    data=dataSet(tmp(1:end))/sqrt(10);
    xb=reshape(dec2bin(tmp-1,4).',[],1);
    xb = logical(xb(:)'-'0').';
    x=data.';
    case 'QPSK'
    i=1
    n=2; %Orden de la modulación
    n1 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
    n2 = (randi(2,nsym,1) - 1)*2-1; % Bits 0-1 equiprobables.
    xb=[n1 n2];
    x=(n1+j*n2)/sqrt(2);
    otherwise
    xb=0;
    x=0;
end
end