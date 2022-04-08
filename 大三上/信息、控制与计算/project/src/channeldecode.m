function channelDecodes = channeldecode(demodulatedCodes, n, k, sourceCodes)
% CHANNELDECODE �ŵ����룬����(15,7)BCH��
% ���������
%    demodulatedCodes: �����ı�������
%    n: ÿ����볤��
%    k��ÿ����Ϣλ����
% ���������
%    channelDecodes: ����ŵ������ı�������

% �ŵ�����
blocks = length(demodulatedCodes)/n; % ��Ҫ�ֳɵ�����
demodulatedCodes = gf(reshape(demodulatedCodes, n, blocks)'); % ת��blocks*n�ľ���
gfCodes = bchdec(demodulatedCodes, n, k); % BCH����(GF��
channelDecodes = double(gfCodes.x); % BCH����(ʵ����)
channelDecodes = reshape(channelDecodes', [], 1); % ת��������
channelDecodes = channelDecodes(1:length(sourceCodes)); % ȥ����0��ֵ

[numerrs, ratio] = biterr(channelDecodes, sourceCodes); % ������������������

% % ������д���ļ�
% fp = fopen('../data/ChannelDecode.txt','w');
% fprintf(fp, '������: %d\n', numerrs);
% fprintf(fp, '������: %f\n', ratio);
% fprintf(fp, '\n');
% fprintf(fp, '�ŵ�������: ');
% for i = 1:length(channelDecodes)
%     fprintf(fp, '%d', channelDecodes(i)); % �ŵ�������
% end

end