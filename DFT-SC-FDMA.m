%% DFT-SC-FDMA
%% Parameters
W=5e6; %Bandwith
FFTsize=128; %input data block size.
Nsub=512; % total number of subcarriers.
Q=Nsub/FFTsize; % bandwith spreading factor.
db=10^5; % number of data blocks.
CP=20; % length of cyclic prefix.
mod='QPSK'; % modulation.
Submap='Interleaved'; % subcarrier mapping mode.
alpha=0.35; % roll-off factor.
SNRdb=[-3:20];
SNR=10.^(SNRdb/10); %Rango SNR lineal.
ii=20;
%% TRANSMITER
%% Source & Modulation
x=modulation2(FFTsize,mod);
%% M-point DFT
x_fft=fft(x);
%% Subcarrier mapping
x_sb=submap(x_fft,Submap,Nsub);
%% N-point IDFT
x_ifft=ifft(x_sb);
%% CP
x_cp=[x_ifft(length(x_ifft)-CP+1:end) x_ifft];
%% Channel
w=(1./sqrt(2*SNR(ii)))'; % Energ�a ruido.
d=(randn(1,Nsub+CP)+j*randn(1,Nsub+CP));
n=(w*d);
r=x_cp+n;
%% RECEIVER
%% Remove-CP
y_cp=r(length(r)+1-Nsub:end);
%% Remove IFFT
y_fft=fft(y_cp);
%% Remove Subcarrier mapping
y_sb=y_fft(1:Q:end)
