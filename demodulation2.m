function [y yb]=demodulation2(x,demod)
switch demod
    case 'QPSK'
    n=2; %Orden de la modulación
    r=real(x);
    i=imag(x);
    r=r>0;
    i=i>0;
    r=r*2-1;
    i=i*2-1;
    yb=[r ;i];
    y=(r+j*i)/sqrt(n);    
    case '16QAM'
    I=[];
    dataSet=[1+j 1-j -1+j -1-j...
    3+j 3-j -3+j -3-j...
    1+3j 1-3j -1+3j -1-3j...
    3+3j 3-3j -3+3j -3-3j];
    dataSet=dataSet/sqrt(10);
    for i=1:1:length(x)
    [minimum ind]=min((dataSet-x(i)));
    aux=dec2bin(ind-1,4);
    I(i,:)=logical(aux(:)'-'0').';
    end
y=0;
yb=reshape(I.',[],1);
end
end