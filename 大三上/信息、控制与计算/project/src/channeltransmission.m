function transmittedCodes = channeltransmission(modulatedCodes, SNR)
% CHANNELTRANSMISSION �ŵ����䣬���ü��Ը�˹�����ŵ�
% ���������
%    modulatedCodes: ���ƺ����������
%    SNR: �ŵ��������(dB)
% ���������
%    transmittedCodes: ͨ���ŵ�����������

transmittedCodes = awgn(modulatedCodes, SNR); % ��Ӹ�˹������

% ��ͼ
% h = scatterplot(modulatedCodes);
% scatterplot(transmittedCodes,[],[],'r*',h);

end