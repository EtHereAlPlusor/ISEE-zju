% randomSeq.m
clc; clear;

N = 200; % ����
n = 0:N-1;
x = rand(1,N)-0.5; % ��������ź�����
X = dftmtx(N)*x'; % ��ɢ����Ҷ�任

% ��X(k)д���ļ�
f1 = fopen('../MATLAB������/randomSeq.txt','w');
for i = 1:N
    fprintf(f1,'X(%d) = %.5f\n',i-1,X(i));
end

% ��ͼ
subplot(2,1,1); stem(n,x,'filled');
title('�ź�����'); xlabel('n'); ylabel('magnitude');
subplot(2,1,2); stem(n,abs(X),'filled');
title('������'); xlabel('k'); ylabel('magnitude');