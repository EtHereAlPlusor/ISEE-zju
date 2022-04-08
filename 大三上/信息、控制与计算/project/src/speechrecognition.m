function signal = speechrecognition(sourceDecodes, Fs)
% SPEECHRECOGNITION ����ʶ��
% ���������
%    reconstructedSignal: �ع��õ��������ź�
%    Fs: ����Ƶ��
% ���������
%    signal: ����ʶ��õ���ָ��

load('commandNet.mat'); % ���ظ�Ԥѵ������
% ��������Ƶ��ͼ
auditorySpect = helperExtractAuditoryFeatures(sourceDecodes, Fs);
% ��������Ƶ��ͼ��������з���
signal = classify(trainedNet, auditorySpect);

disp(signal); % ��ӡʶ���������ָ��

% % ���ӻ�����
% info = audioinfo('../data/command.flac'); % �������������źŵ���Ϣ
% t = 0:seconds(1/Fs):seconds(info.Duration); % ����������ʱ��
% t = t(1:end-1); figure;
% subplot(2,1,1); plot(t, sourceDecodes);
% axis tight; title(string(signal)); % ��ʶ�����ָ����Ϊ����
% subplot(2,1,2); pcolor(auditorySpect); % α��ͼ
% shading flat; title('����Ƶ��ͼ');

% % ��ָ��д���ļ�
% fp = fopen('../data/SpeechRecognition.txt','w');
% fprintf(fp, '����ָ��Ϊ: %s\n', signal);

end