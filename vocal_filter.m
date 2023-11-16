%this is a basic vocal filter 
%I need to meet my deadline, thus i'll I will be back n refine the code comments later :)

clc,clear
close all


tic

music='file_name';
[Sound,Fs] = audioread([music,'.mp3']);
T=1/Fs; 
N=length(Sound);
t=(0:N-1)*T;  
f=(-N/2:N/2-1)*Fs/N; 

SoundL_t=Sound(:,1);  
SoundR_t=Sound(:,2);  
SoundL_f=fft(SoundL_t,N);
SoundR_f=fft(SoundR_t,N);
figure(1)


subplot(221)
plot(t,SoundL_t);
title('Left_Tract')
xlabel('t/s')

subplot(222)
plot(f,SoundL_f,'r');
title('LeftTract_Spectrogram')
xlabel('f/Hz')

subplot(223)
plot(t,SoundR_t);
title('Right_Tract')
xlabel('t/s')

subplot(224)
plot(f,SoundR_f,'r');
title('RightTract_Spectrogram')
xlabel('f/Hz')


NewSoundL_t=SoundL_t-SoundR_t;
NewSoundR_t=SoundL_t-SoundR_t;

NewSound(:,1)=NewSoundL_t;
NewSound(:,2)=NewSoundR_t;

NewSoundL_f=fft(NewSoundL_t,N);
NewSoundR_f=fft(NewSoundR_t,N);
figure(2)

subplot(221)
plot(t,NewSoundL_t);
title('LeftTract_Neo')
xlabel('t/s')

subplot(222)
plot(f,NewSoundL_f,'r');
title('LeftTractNeo_Spectrogram')
xlabel('f/Hz')

subplot(223)
plot(t,NewSoundR_t);
title('RightTract_Neo')
xlabel('t/s')

subplot(224)
plot(f,NewSoundR_f,'r');
title('RightTractNeo_Spectrogram')
xlabel('f/Hz')



BandStop1=fir1(200,2*[60,80]/Fs,'stop');%Low frequency
SoundTemp=filter(BandStop1,1,NewSound);
BandStop2=fir1(200,2*[700,800]/Fs,'stop');%High frequency
SoundFinal=filter(BandStop2,1,SoundTemp);


SoundFinalL_t=SoundFinal(:,1);
SoundFinalR_t=SoundFinal(:,2);
SoundFinalL_f=fft(SoundFinalL_t,N);
SoundFinalR_f=fft(SoundFinalR_t,N);

figure()

subplot(221)
plot(t,SoundFinalL_t);
title('FinalTract_L')
xlabel('t/s')

subplot(222)
plot(f,SoundFinalL_f,'r');
title('FinalTractL_Spectrogram')
xlabel('f/Hz')

subplot(223)
plot(t,SoundFinalR_t);
title(''FinalTract_R')
xlabel('t/s')

subplot(224)
plot(f,SoundFinalR_f,'r');
title(''FinalTractR_Spectrogram')
xlabel('f/Hz')

%play
player = audioplayer(SoundFinal, Fs);
play(player);

%create new file
audiowrite('file_name(accompaniment ver).wav',SoundFinal,Fs)
toc%
