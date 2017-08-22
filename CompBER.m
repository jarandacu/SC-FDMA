clear all;
clc;
figure()
[a1,b1]=DFTSCFDMA('QPSK');
ylabel('BER')
xlabel('SNR [db]')
[a2,b2]=DCTSCFDMA('QPSK');
semilogy(a1,b1,'rx-');
hold on
semilogy(a2,b2,'kx-');
legend('DFT','DCT')
[a3,b3]=WAVSCFDMA('QPSK','db10');
semilogy(a3,b3,'rx-');

