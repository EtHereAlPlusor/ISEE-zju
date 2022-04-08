function demodulatedCodes = demodulation(transmittedCodes, channelCodes)
% DEMODULATION BPSK���
% ���������
%    transmittedCodes: ͨ����˹�ŵ�����ź�����
% ���������
%    transmittedCodes: ����������
 
% �о�
tempCodes(transmittedCodes>-0) = 1;
tempCodes(transmittedCodes<0) = -1; 
% ���
demodulatedCodes(tempCodes>-0) = 0; 
demodulatedCodes(tempCodes<0) = 1; 
% ת��������
demodulatedCodes = reshape(demodulatedCodes,[],1); 

[numerrs, ratio] = biterr(demodulatedCodes, channelCodes); % ������������������

% % ������д���ļ�
% fp = fopen('../data/demodulation.txt','w');
% fprintf(fp, '������: %d\n', numerrs);
% fprintf(fp, '������: %f\n', ratio);
% fprintf(fp, '\n');
% fprintf(fp, '������: ');
% for i = 1:length(demodulatedCodes)
%     fprintf(fp, '%d', demodulatedCodes(i)); % ������
% end

end