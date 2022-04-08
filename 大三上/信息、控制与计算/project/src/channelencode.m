function channelCodes = channelencode(sourceCodes, n, k)
% CHANNELENCODE �ŵ����룬����(15,7)BCH��
% ���������
%    sourceCodes: ��Դ��������
%    n: ÿ����볤��
%    k��ÿ����Ϣλ����
% ���������
%    channelCodes: ��ɺ���ŵ�����

% �ŵ�����
N = length(sourceCodes); % ��Դ�������г���
blocks = ceil(N/k); % ��Ҫ�ֳɵ�����
if (blocks>N/k)
    sourceCodes(N:blocks*k) = 0; % ����������0
end
sourceCodes = gf(reshape(sourceCodes, k, blocks)'); % ת��blocks*k�ľ���
gfCodes = bchenc(sourceCodes, n, k); % BCH����(GF��
channelCodes = double(gfCodes.x); % BCH����(ʵ����)
channelCodes = reshape(channelCodes', [], 1); % ת��������

% % ������д���ļ�
% fp = fopen('../data/ChannelEncode.txt','w');
% fprintf(fp, '��Դ���������볤: %d\n', N);
% fprintf(fp, '�ŵ����������볤: %d\n', length(channelCodes));
% fprintf(fp, '��������: %f\n', k/n);
% fprintf(fp, '\n');
% fprintf(fp, '�ŵ�������: ');
% for i = 1:length(channelCodes)
%     fprintf(fp, '%d', channelCodes(i)); % �ŵ�������
% end
    
end