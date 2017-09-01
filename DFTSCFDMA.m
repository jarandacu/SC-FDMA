function [SNRdb bitBer]=DFTSCFDMA(Modulation,CH,eq,Alpha)
%% DFT-SC-FDMA
%% Parameters
W=5e6; %Bandwith
FFTsize=256; %input data block size.
Nsub=512; % total number of subcarriers.
Q=Nsub/FFTsize; % bandwith spreading factor.
db=10^4; % number of data blocks.
CP=20; % length of cyclic prefix.
mod=Modulation; % modulation.
Submap='Interleaved'; % subcarrier mapping mode.
ch=CH; % channel.
equalizer=eq; % equalizer.
alpha=Alpha; % roll-off factor.
SNRdb=[0:30]; % range of SNR.
SNR=10.^(SNRdb/10); %range of linear SNR.
%% Channel
%Channels based on 3GPP TS 25.104.
if ch=='pedA'
    pedAchannel=[1 10^(-9.7/20) 10^(-22.8/20)];
    channel=pedAchannel/sqrt(sum(pedAchannel.^2));
elseif ch=='vehA'
    vehAchannel=[1 0 10^(-1/20) 0 10^(-9/20) 10^(-10/20) 0 0 0 10^(-15/20) 0 0 0 10^(-20/20)];
    channel=vehAchannel/sqrt(sum(vehAchannel.^2));
elseif ch=='AWGN'
    channel=1;
end
Hchannel = fft(channel,Nsub);
%% TRANSMITER
for ii=1:1:length(SNR)
for kk=1:1:db
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
%% CHANNEL
x_ch=filter(channel, 1,x_cp);

w=(1./sqrt(2*SNR(ii)))'; % Energ�a ruido.
d=(randn(1,Nsub+CP)+j*randn(1,Nsub+CP));
n=(w*d);
%Revisar la energía del ruido.
tmpn = randn(2,Nsub+CP);
complexNoise = (tmpn(1,:) + i*tmpn(2,:))/sqrt(2);
noisePower = 10^(-SNRdb(ii)/10);

r=x_ch+sqrt(noisePower/Q)*complexNoise;
%% RECEIVER
%% Remove-CP
y_cp=r(length(r)+1-Nsub:end);
%% Remove IFFT
y_fft=fft(y_cp);y_sb=y_fft(1:Q:end);
%% Remove Subcarrier mapping
y_sb=desubmap(y_fft,Submap,FFTsize);
%% FDE
%Find the channel response for the interleaved subcarriers.
Heff=Hchannel(1:Q:end);
%Perform channel equalization in the frequency domain.
if equalizer=='ZERO'
    y_fde=y_sb./Heff;
elseif equalizer == 'MMSE'
    C=conj(Heff)./(conj(Heff).*Heff+10^(-SNRdb(ii)/10));
    y_fde=y_sb.*C;
end
%% Remove DFT
y_ifft=ifft(y_fde);
%% Demodulation
[y yb]=demodulation2(y_ifft,mod);
%% Count the errors
nsErr(ii,kk) = size(find([y.'-x]),1);
nbErr(ii,kk) = size(find([reshape(yb,1,[])-reshape(xb',1,[])]),2);
end
end
simBer=(mean(nsErr,2)/FFTsize)';
bitBer=(mean(nbErr,2)/FFTsize)';
end
