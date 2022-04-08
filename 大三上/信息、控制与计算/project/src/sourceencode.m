function [sourceCodes, dict, K] = sourceencode(quantizedSignal, nQuantizationBits)
% SOURCEENCODE ��Դ���룬���ö�ԪHuffman����
% ���������
%    quantizedSignal: ������������źţ���ɢ�޼�����Դ������� 
% ���������
%    sourceCodes: ��ɺ����Դ����

% ������Դ���ʷֲ�����Դ��
L = length(quantizedSignal); % ��Դ������г���
symbols = unique(quantizedSignal); % ͳ����Դ�ַ���
K = length(symbols); % �ַ���
U = zeros(3,K); % ��Դ�ַ����ʱ�
U(1,:) = symbols; % ��һ��Ϊ�ַ�
for i = 1:K
    U(2,i) = length(find(quantizedSignal==U(1,i))); % �ڶ���Ϊ���ִ���
    U(3,i) = U(2,i)/L; % ������Ϊ���ָ���
end
H = sum(-U(3,:).*log2(U(3,:))); % ��Դ��

% Huffman����
[dict, avglen] = huffmandict(U(1,:), U(3,:)); % �õ�ÿ�����Ŷ�Ӧ�����ּ�ƽ���볤
sourceCodes = huffmanenco(quantizedSignal, dict); % ���ź��и������滻Ϊ����
R = avglen; % ��������
eta = H/R; % ����Ч��
quantizedCodesLength = nQuantizationBits*L; % ����8λ���������볤
sourceCodesLength = length(sourceCodes); % Huffman���������볤
sourceCompressionRatio = quantizedCodesLength/sourceCodesLength; % ѹ����

% % ������д���ļ�
% fp = fopen('../data/SourceEncode.txt','w');
% fprintf(fp, '��Դ��(������): %f\n', H);
% fprintf(fp, '�ص������: %f\n', H/log2(K));
% fprintf(fp, '�����: %f\n', 1-H/log2(K));
% fprintf(fp, 'ƽ���볤: %f\n', avglen);
% fprintf(fp, '��������: %f\n', R);
% fprintf(fp, '����Ч��: %f\n', eta);
% fprintf(fp, '����8λ���������볤: %d\n', quantizedCodesLength);
% fprintf(fp, 'Huffman���������볤: %d\n', sourceCodesLength);
% fprintf(fp, 'ѹ����: %f\n\n', sourceCompressionRatio);
% fprintf(fp, '����                    ����\n');
% for i = 1:K
%     fprintf(fp,'%s   ', cell2mat(dict(i,1))); % ����
%     for j = 1:length(dict{i,2})
%         fprintf(fp, '%d', dict{i,2}(j)); % ��Ӧ������
%     end
%     fprintf(fp, '\n');
% end
% fprintf(fp, '\n');
% fprintf(fp, '��Դ������: ');
% for i = 1:length(sourceCodes)
%     fprintf(fp, '%d', sourceCodes(i)); % ��Դ������
% end

end