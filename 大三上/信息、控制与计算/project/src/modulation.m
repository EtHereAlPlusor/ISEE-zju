function modulatedCodes = modulation(channelCodes)
% MODULATION ���ƣ�����BPSK
% ��������� 
%    channelCodes: �ŵ��������� 
% ���������
%    modulatedCodes: ���ƺ�ı���

modulatedCodes = 1-2*channelCodes; % BPSK����

% ��ͼ
% scatterplot(modulatedCodes);

end