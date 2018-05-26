
clear all;
close all;
sysCfg=sysCfgStr();
global puschDMRS;

%% generate DMRS
ue.NPUSCHID = 42;
ue.NDMRSID = 1;
ue.NSubframe = 0;
chs.PRBSet = (0:24).';
puschDMRS = ltePUSCHDRS(ue,chs);
DMRS=[puschDMRS(1:300).';puschDMRS(301:end).']; % only use the DMRS(1,:)

Ber=[];
for SNR=1:30
    for i=1:10
        BerRaw(SNR,i)=runonce('LS','ZFxx',SNR);
        BerZF(SNR,i)=runonce('LS','ZF',SNR);
    end
    
end
b=sum(BerRaw,2)/10;
semilogy(1:30,b);hold on;
b=sum(BerZF,2)/10;
semilogy(1:30,b);

%scatterplot(RxDataTd(1,:))

%a=txWaveFormWithCh(37:end);% remove CP
%a=fft(a,512);% FFT
%a=ifft(a,300);% IDFT
%scatterplot(a)
%


'OK'