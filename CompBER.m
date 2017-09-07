clear all;
clc;
[a1,b1]=DFTSCFDMA('16QAM','AWGN','ZERO',0.35);
[a2,b2]=DCTSCFDMA('16QAM','AWGN','ZERO',0.35);
[a5,b5]=DSTSCFDMA('16QAM','AWGN','ZERO',0.35);
[a3,b3]=WAVSCFDMA('16QAM','haar');
[a4,b4]=WAVSCFDMA('16QAM','bior1.1');
h=figure();
ylabel('BER')
xlabel('SNR [db]')
semilogy(a1,b1,'k--d','LineWidth',2);
hold on
semilogy(a2,b2,'b--*','LineWidth',2);
hold on
semilogy(a5,b5,'g-s','LineWidth',2);
hold on
semilogy(a4,b4,'r-.o','LineWidth',2);
legend('DFT','DCT','HAAR','bior1.1')
title('SC-FDMA para canal AWGN, modulacion QPSK, idb=256')
axis([min([min(a1) min(a2) min(a3) min(a4)]) 15 min([min(b1) min(b2) min(b3) min(b4)]) max([max(b1) max(b2) max(b3) max(b4)])])
%set(gca,'YTick',[-0.2 0 0.2 0.4 0.6 0.8 1])
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,'a035','-dpdf','-r300')