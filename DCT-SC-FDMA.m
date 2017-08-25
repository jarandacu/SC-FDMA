clear all
clc
%% DFT-SC-FDMA
%% Parameters
W=5e6; %Bandwith
FFTsize=128; %input data block size.
Nsub=512; % total number of subcarriers.
Q=Nsub/FFTsize; % bandwith spreading factor.
db=10^5; % number of data blocks.
CP=20; % length of cyclic prefix.
mod='QPSK'; % modulation.
Submap='Interleaved'; % subcarrier z|mapping mode.
alpha=0.35; % roll-off factor.
SNRdb=[0:30];
SNR=10.^(SNRdb/10); %Rango SNR lineal.
%% TRANSMITER
for ii=1:1:length(SNR)
for kk=1:1:db
%% Source & Modulation
[x xb]=modulation2(FFTsize,mod);
%% M-point DFT
x_fft=dct(x);
%% Subcarrier mapping
x_sb=submap(x_fft,Submap,Nsub);
%% N-point IDFT
x_ifft=idct(x_sb);
%% CP
x_cp=[x_ifft(length(x_ifft)-CP+1:end) x_ifft];

%% CHANNEL
w=(1./sqrt(2*SNR(ii)))'; % Energ�a ruido.
d=(randn(1,Nsub+CP)+j*randn(1,Nsub+CP));
n=(w*d);

tmpn = randn(2,Nsub+CP);
complexNoise = (tmpn(1,:) + i*tmpn(2,:))/sqrt(2);
noisePower = 10^(-SNRdb(ii)/10);

r=x_cp+sqrt(noisePower/Q)*complexNoise;
%% RECEIVER

%% Remove-CP
y_cp=r(length(r)+1-Nsub:end);
%% FDE
% DFT
% FDE
% IDFT
%% Remove IDCT
y_fft=dct(y_cp);
%% Remove Subcarrier mapping
y_sb=y_fft(1:Q:end);
%% Remove DFT
y_ifft=idct(y_sb);
%% Demodulation
[y yb]=demodulation2(y_ifft,mod);
%% Count the errors
nsErr(ii,kk) = size(find([y.'-x]),1);
nbErr(ii,kk) = size(find([reshape(yb,1,[])-reshape(xb',1,[])]),2);
end
end
simBer=(mean(nsErr,2)/FFTsize)';
bitBer=(mean(nbErr,2)/FFTsize)';
figure()
semilogy(SNRdb,simBer,'kx-');
hold on
semilogy(SNRdb,bitBer,'rx-');
legend('SER','BER')
xlabel('SNR [db]')

