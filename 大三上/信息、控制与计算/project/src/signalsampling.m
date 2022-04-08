function [sampledSignal, fs] = signalsampling(Fs, nSamplingBits, nChannels)
% SIGNALSAMPLING ���������źŵĲ���
% �������:
%    Fs: ����Ƶ��
%    nSamplingBits: ����λ��
%    nChannels: ������
% �������:
%    sampledSignal: ������������ź�

% myRecording = audiorecorder(Fs, nSamplingBits, nChannels);
% disp('Start speaking.');
% recordblocking(myRecording, 1); % ¼��ʱ��Ϊ1s
% disp('End of Recording');
% play(myRecording); % ����¼�Ƶ���Ƶ
% sampledSignal = getaudiodata(myRecording); % ��ȡ¼������
% plot(sampledSignal); % ���������ź�
% audiowrite('../data/command.flac', sampledSignal, Fs); % �洢�����ź�

[sampledSignal, fs] = audioread('../data/command.flac'); % ��ȡ�����ź�
info = audioinfo('../data/command.flac'); % �����źŵ���Ϣ
% plot(sampledSignal); % ���������ź�
% sound(sampledSignal); % ���������ź�

% % ʱ��ͼ��
% t = 0:seconds(1/Fs):seconds(info.Duration); % ����������ʱ��
% t = t(1:end-1);
% figure; subplot(2,1,1);
% plot(t, sampledSignal); % ����ʱ����
% xlabel('Time'); ylabel('Sampled Signal');
% title('�����ź�ʱ����');

% % Ƶ��ͼ��
% N = length(sampledSignal); % �źŵ���
% X = fft(sampledSignal); % �������źŽ��и���Ҷ�任
% f = Fs/N*(0:round(N/2)-1); % ��ʾʵ��Ƶ���һ�룬��λΪHz
% subplot(2,1,2);
% plot(f, abs(X(1:round(N/2)))); % ����Ƶ��ͼ��
% xlabel('Frequency/Hz'); ylabel('Amplitude');
% xlim([0 Fs/2]); title('�����ź�Ƶ��');

end
