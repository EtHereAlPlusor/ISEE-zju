% RemoteVoiceControlSys.m
% REMOTE VOICE CONTROL SYSTEM Զ������ϵͳ��������������������������

clc; clear

%% ��������
% ����
Fs = 44100; % ����Ƶ��Ϊ44.1kHz
nSamplingBits = 16; % ����λ��Ϊ16λ
nChannels = 1; % ������
% ����
nQuantizationBits = 8; % ����λ��Ϊ8λ
% �ŵ�����
n = 15; % ÿ��ı��볤��
k = 7; % ÿ�����Ϣλ����
% �ŵ�����
SNR = 20; % �����(dB)
SNRs = -10:30;

%% ϵͳʵ��
% �����źŵĲ���
sampledSignal = signalsampling(Fs, nSamplingBits, nChannels);

% �����źŵ�����
quantizedSignal = signalquantization(Fs, sampledSignal, nQuantizationBits);

% ��Դ����--Huffman����
[sourceCodes, dict, K] = sourceencode(quantizedSignal, nQuantizationBits);

% �ŵ�����--(15,7)BCH��
channelCodes = channelencode(sourceCodes, n, k);

% ����--BPSK
modulatedCodes = modulation(channelCodes);

% �ŵ�����--AWGN
transmittedCodes = channeltransmission(modulatedCodes, SNR);

% ���
demodulatedCodes = demodulation(transmittedCodes, channelCodes);

% �ŵ�����
channelDecodes = channeldecode(demodulatedCodes, n, k, sourceCodes);

% ��Դ����
sourceDecodes = sourcedecode(channelDecodes, dict, quantizedSignal, sampledSignal, Fs);

% ����ʶ��
signal = speechrecognition(sourceDecodes, Fs);

% sound(sampledSignal);

% % ������������ʹ�ϵ��֤
% numerrs = zeros(length(SNRs),1);
% ratio = zeros(length(SNRs),1);
% for i = 1:length(SNRs)
%     transmittedCodes = channeltransmission(modulatedCodes, SNRs(i)); % �ŵ�����
%     demodulatedCodes = demodulation(transmittedCodes, channelCodes); % ���
%     channelDecodes = channeldecode(demodulatedCodes, n, k, sourceCodes); % �ŵ�����
%     [numerrs(i), ratio(i)] = biterr(channelDecodes, sourceCodes); % ������������������
% end
% % ��ͼ
% plot(SNRs, ratio); title('��ͬ��������ŵ�����������');
% xlabel('SNR(dB)'); ylabel('������');