function quantizedSignal = signalquantization(Fs, sampledSignal, nQuantizationBits)
% SIGNALQUANTIZATION ���������źŵľ�������
% �������:
%    Fs: ����Ƶ��
%    sampledSignal: ������������ź�
%    nQuantizationBits: ����λ��
% �������:
%    quantizedSignal: ������������ź�

Min = min(sampledSignal); % �ҳ��źŵ���Сֵ
Max = max(sampledSignal); % �ҳ��źŵ����ֵ
delta = (Max-Min)/2^nQuantizationBits; % ��С�ֱ���
for i = 1:2^nQuantizationBits+1
    q(i) = Min + delta*(i-1); % ����ȡֵ
end

% ����ȡ��
N = length(sampledSignal); % ���������źŵ�ÿ��������
quantizedSignal = sampledSignal;
for i = 1:N
    for j = 1:2^nQuantizationBits
        % ���ź�ĳ��ȡֵ����������ֵ֮�䣬��ȡ������ֵ���м�ֵ
        if sampledSignal(i)>=q(j) && sampledSignal(i)<=q(j+1)
            quantizedSignal(i) = (q(j)+q(j+1))/2;
            break
        end
    end
end

% ����ȡ��
N = length(sampledSignal); % ���������źŵ�ÿ��������
quantizedSignalRoundDown = sampledSignal;
for i = 1:N
    for j = 1:2^nQuantizationBits+1
        % ���ź�ĳ��ȡֵ������ֵ����������������ڣ���ȡ������ֵ
        if sampledSignal(i)>=q(j)-0.5*delta && sampledSignal(i)<=q(j)+0.5*delta
            quantizedSignalRoundDown(i) = q(j);
            break
        end
    end
end

% % �Ƚ�����ǰ����ź�
% info = audioinfo('../data/command.flac'); % �������������źŵ���Ϣ
% t = 0:seconds(1/Fs):seconds(info.Duration); % ����������ʱ��
% t = t(1:end-1);
% figure; subplot(2,1,1);
% plot(t, sampledSignal); % ��������ǰ�źŵ�ʱ����
% hold on; plot(t, quantizedSignal,'r'); % �����������źŵ�ʱ���Σ�����ȡ����
% legend('����ǰ�ź�','�������ź�');
% title('����ǰ���źŶԱ�(����ȡ��)'); xlabel('Time'); ylabel('Signal');
% subplot(2,1,2);
% plot(t, sampledSignal); % ��������ǰ�źŵ�ʱ����
% hold on; plot(t, quantizedSignalRoundDown,'r'); % �����������źŵ�ʱ���Σ�����ȡ����
% legend('����ǰ�ź�','�������ź�');
% title('����ǰ���źŶԱȣ�����ȡ����'); xlabel('Time'); ylabel('Signal');

end