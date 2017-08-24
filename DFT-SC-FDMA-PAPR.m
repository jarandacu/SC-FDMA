clear all
clc
%% PAPR-DFT-SC-FDMA
%% Parameters
W=5e6; %Bandwith
FFTsize=128; %input data block size.
Nsub=512; % total number of subcarriers.
Q=Nsub/FFTsize; % bandwith spreading factor.
db=10^6; % number of data blocks.
CP=20; % length of cyclic prefix.
mod='QPSK'; % modulation.
Submap='Interleaved'; % subcarrier z|mapping mode.
alpha=0.35; % roll-off factor.
beta=.5;
SNRdb=[0:30];
SNR=10.^(SNRdb/10); %Rango SNR lineal.
numsim=10000;
os=4;
Fs = 5e6;% Sampling Frequency.
Ts = 1/Fs;% sampling rate.
psFilter = ELP(Ts, os, alpha,beta);
%%
for i=1:numsim
%% Source & Modulation
[x xb]=modulation2(FFTsize,mod);
%% M-point DFT
x_fft=fft(x);
%% Subcarrier mapping
x_sb=submap(x_fft,Submap,Nsub);
%% N-point IDFT
x_ifft=ifft(x_sb);
%% CP
x_cp=[x_ifft(length(x_ifft)-CP+1:end) x_ifft];
%% Oversampling
x_oversampled(1:os:os*(Nsub+CP)) = x_cp;
%% Filtering
x_filter = filter(psFilter, 1, x_oversampled);
%% PAPR
papr(i) = 10*log10(max(abs(x_filter).^2)/mean(abs(x_filter).^2));
end
[N,X] = hist(papr,1000);
semilogy(X,1-cumsum(N)/max(cumsum(N)),'b-')
xlabel('PAPR(dB)');
ylabel('CCDF');