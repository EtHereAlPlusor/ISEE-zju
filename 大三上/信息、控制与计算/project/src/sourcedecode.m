function sourceDecodes = sourcedecode(channelDecodes, dict, quantizedSignal, sampledSignal, Fs)
% SOURCEDECODE ��Դ���룬���ö�ԪHuffman����
% ���������
%    channelDecodes: �ŵ����������� 
%    dict: ��Դ����õ�������
%    quantizedSignal: ��������ź�
%    sampledSignal: ��������ź�
%    Fs: ����Ƶ��
% ���������
%    sourceCodes: ��Դ�������ַ�����

% ��Դ����
sourceDecodes = huffmandeco(channelDecodes, dict);

% sound(sourceDecodes); % ������Դ�������ź�

% rights = length(find(sourceDecodes==quantizedSignal)); % ����������ʹ�����
% numerrs = length(quantizedSignal)-rights; % ������
% ratio = numerrs/length(quantizedSignal); % ������

% % �źŵ�ʱ���Ƶ��Ա�
% % ʱ��
% info = audioinfo('../data/command.flac'); % �������������źŵ���Ϣ
% t = 0:seconds(1/Fs):seconds(info.Duration); % ����������ʱ��
% t = t(1:end-1); figure;
% subplot(2,1,1); plot(t, sampledSignal); % ���Ʋ�������ź�
% hold on; plot(t, sourceDecodes, 'r'); % ������Դ����õ����ź�
% legend('�������ź�','��Դ������ź�');
% title('��Դ�����ź���������źŵ�ʱ��Ա�'); xlabel('Time'); ylabel('Signal');
% % Ƶ��
% N1 = length(sampledSignal); % �źŵ���
% N2 = length(sourceDecodes);
% X1 = fft(sampledSignal); % ���źŽ��и���Ҷ�任
% X2 = fft(sourceDecodes);
% f1 = Fs/N1*(0:round(N1/2)-1); % ��ʾʵ��Ƶ���һ�룬��λΪHz
% f2 = Fs/N2*(0:round(N2/2)-1);
% subplot(2,1,2); plot(f1, abs(X1(1:round(N1/2)))); % ����Ƶ��ͼ��
% hold on; plot(f2, abs(X2(1:round(N2/2))), 'r');
% legend('�������ź�','��Դ������ź�');
% title('��Դ�����ź���������źŵ�Ƶ��Ա�'); xlabel('Frequency/Hz'); ylabel('Amplitude');
% xlim([0 Fs/2]); 

% % ������д���ļ�
% fp = fopen('../data/SourceDecode.txt','w');
% fprintf(fp, '������: %d\n', numerrs);
% fprintf(fp, '������: %f\n', ratio);
% fprintf(fp, '\n');
% fprintf(fp, '��Դ������: \n');
% for i = 1:length(sourceDecodes)
%     fprintf(fp, '%d\n', sourceDecodes(i)); % ��Դ������
% end

end