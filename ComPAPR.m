clear all;
clc;
alpha=0.5;
mod='16QAM';
[a1 b1]=DFTPAPR(mod,alpha);
[a2 b2]=DCTPAPR(mod,alpha);
[a3 b3]=DWTPAPR(mod,alpha,'haar');
[a4 b4]=DWTPAPR(mod,alpha,'bior1.1');
h=figure()
semilogy(a1(1:5:end),b1(1:5:end),'k--d','LineWidth',1);
hold on
semilogy(a2(1:5:end),b2(1:5:end),'b--*','LineWidth',1);
hold on
semilogy(a3(1:5:end),b3(1:5:end),'g-s','LineWidth',1);
hold on
semilogy(a4(1:5:end),b4(1:5:end),'r-.o','LineWidth',1);
xlabel('PAPR(dB)');
ylabel('CCDF');
legend('DFT','DCT','HAAR','bior1.1')
legend('Location','southwest')
title(strcat('PAPR modulacion: ', mod, ' \alpha= ',num2str(alpha),' idbs=256'))
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'a035','-dpdf','-r300')