% BP_FIR.m
clc; clear;

fl = 160-150/2; % ͨ����ʼƵ��
fh = 1500+150/2; % ͨ����ֹƵ��
% ��ȡ��Ƶ��Ϣ��fsΪ����Ƶ��
[audio,fs] = audioread('../Audio/05-03-noisy.wav');
Y=fft(audio); % ԭʼ�źŵ�Ƶ�� 
N = length(audio); % �źų���
wl = 2*pi*fl/fs;
wh = 2*pi*fh/fs; % ���ֽ�ֹƵ��
tr_width = 2*pi*150/fs; % ���ɴ��� 

% ���δ�
N1 = ceil(1.8*pi/tr_width)+1; % ȡ����97
w_rec = (rectwin(N1))'; % ������
h1 = fir1(N1-1,[wl/pi,wh/pi],'BANDPASS',w_rec); % h1(n)
[H1,db1,mag1,pha1,grd1,w1] = freqz_m(h1,1);
y1 = filter(h1,1,audio); % �˲�
Y1 = fft(y1); % Ƶ��

% ������
N2 = ceil(6.2*pi/tr_width); 
w_han = (hanning(N2))'; % ������
h2 = fir1(N2-1,[wl/pi,wh/pi],'BANDPASS',w_han); % h2(n)
[H2,db2,mag2,pha2,grd2,w2] = freqz_m(h2,1);
y2 = filter(h2,1,audio); % �˲�
Y2 = fft(y2); % Ƶ��

% ��ͼ
figure; 
subplot(2,1,1); plot(0:1/fs:(N-1)/fs,audio); title('ԭʼ�ź�ʱ������');
xlabel('t/s'); ylabel('magnitude'); xlim([0 (N-1)/fs]);
subplot(2,1,2); plot(0:fs/(N-1):fs,abs(Y)); title('ԭʼ�ź�Ƶ��'); 
xlabel('frequency/Hz'); ylabel('magnitude'); xlim([0 fs]);

figure; % �˲����ķ�Ƶ��Ӧ
subplot(2,1,1); plot(0:1/500:1,20*log10(mag1)); title('20lg|H1(w)|'); % H1(w)
xlabel('frequency in pi units'); ylabel('Decibles');
subplot(2,1,2); plot(0:1/500:1,20*log10(mag2)); title('20lg|H2(w)|'); % H2(w)
xlabel('frequency in pi units'); ylabel('Decibles');

figure; % �˲����ʱ������
subplot(2,1,1); plot(0:1/fs:(N-1)/fs,y1); title('���δ����ʱ������'); % ���δ�
xlabel('t/s'); ylabel('magnitude'); xlim([0 (N-1)/fs]);
subplot(2,1,2); plot(0:1/fs:(N-1)/fs,y2); title('���������ʱ������'); % ������
xlabel('t/s'); ylabel('magnitude'); xlim([0 (N-1)/fs]);

figure; % �˲����Ƶ��
subplot(2,1,1); plot(0:fs/(N-1):fs,abs(Y1)); title('���δ����Ƶ��'); % ���δ�
xlabel('frequency/Hz'); ylabel('magnitude'); xlim([0 fs]);
subplot(2,1,2); plot(0:fs/(N-1):fs,abs(Y2)); title('���������Ƶ��'); % ������
xlabel('frequency/Hz'); ylabel('magnitude'); xlim([0 fs]);

% д����Ƶ�ļ�
audiowrite('../Audio/rectwin.wav',y1,fs);
audiowrite('../Audio/hanning.wav',y2,fs);
