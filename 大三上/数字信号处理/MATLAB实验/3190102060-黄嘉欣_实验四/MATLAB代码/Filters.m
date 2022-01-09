% Filters.m
clc; clear;

N1 = 200; % ����
n1 = 0:N1-1;
x = rand(1,N1)-0.5; % ����ź�����
X = dftmtx(N1)*x'; % ������

wc = 0.5*pi; % ��ֹƵ��
N2 = 31; % ����
n2 = 0:N2-1;
w1 = (rectwin(N2))'; % ���δ�
w2 = (hamming(N2))'; % ������

N3 = 127; % ����
n3 = 0:N3-1;
w3 = (rectwin(N3))'; % ���δ�

% ��һ���˲����ĵ�λ������Ӧ����
h1 = fir1(N2-1,wc/pi,w1);
% �ڶ����˲����ĵ�λ������Ӧ����
h2 = fir1(N2-1,wc/pi,w2);
% �������˲����ĵ�λ������Ӧ����
h3 = fir1(N3-1,wc/pi,w3); 

% ������һ���˲�������������
y1 = filter(h1,1,x);
Y1 = dftmtx(N1)*y1'; % ������
% �����ڶ����˲�������������
y2 = filter(h2,1,x);
Y2 = dftmtx(N1)*y2'; % ������
% �����������˲�������������
y3 = filter(h3,1,x);
Y3 = dftmtx(N1)*y3'; % ������

% ��һ���˲�����Ƶ����Ӧ
[H1,db1,mag1,pha1,grd1,w1] = freqz_m(h1,1);
% �������˲�����Ƶ����Ӧ
[H3,db3,mag3,pha3,grd3,w3] = freqz_m(h3,1);

% ��X(k)д���ļ�
f1 = fopen('../MATLAB������/randomSeq.txt','w');
for i = 1:N1
    fprintf(f1,'X(%d) = %.5f\n',i-1,X(i));
end

% ��ͼ
subplot(2,1,1); stem(n1,x,'filled');
title('�ź�����x(n)'); xlabel('n'); ylabel('magnitude');
subplot(2,1,2); stem(n1,abs(X),'filled');
title('������|X(k)|'); xlabel('k'); ylabel('magnitude');

figure; % ��һ���˲���
subplot(2,1,1); stem(n1,abs(X),'filled');
title('|X(k)|'); xlabel('k'); ylabel('magnitude');
subplot(2,1,2); stem(n1,abs(Y1),'filled');
title('|Y1(k)|'); xlabel('k'); ylabel('magnitude');

figure; % �ڶ����˲���
subplot(2,1,1); stem(n1,abs(X),'filled');
title('|X(k)|'); xlabel('k'); ylabel('magnitude');
subplot(2,1,2); stem(n1,abs(Y2),'filled');
title('|Y2(k)|'); xlabel('k'); ylabel('magnitude');

figure; % �������˲���
subplot(2,1,1); stem(n1,abs(X),'filled');
title('|X(k)|'); xlabel('k'); ylabel('magnitude');
subplot(2,1,2); stem(n1,abs(Y3),'filled');
title('|Y3(k)|'); xlabel('k'); ylabel('magnitude');

% �Ƚ��˲������Ƶ��
figure; stem(n1,abs(Y1),'filled');
hold on; stem(n1,abs(Y2),':p','filled');
title('���Ƶ��'); xlabel('k'); ylabel('magnitude');
legend('|Y1(k)|','|Y2(k)|'); % |Y1(k)|��|Y2(k)|

figure; stem(n1,abs(Y1),'filled');
hold on; stem(n1,abs(Y3),':p','filled');
title('���Ƶ��'); xlabel('k'); ylabel('magnitude');
legend('|Y1(k)|','|Y3(k)|'); % |Y1(k)|��|Y3(k)|

% �Ƚ��˲�������
figure; 
subplot(2,1,1); plot(0:1/500:1,mag1); 
hold on; plot(0:1/500:1,mag3,'-r');
title('Ƶ��'); xlabel('frequency in pi units'); ylabel('magnitude');
legend('|H1(w)|','|H3(w)|'); % |H1(w)|��|H3(w)|
subplot(2,1,2); plot(0:1/500:1,20*log10(mag1)); 
hold on; plot(0:1/500:1,20*log10(mag3),'-r');
title('Ƶ����Ӧ'); xlabel('frequency in pi units'); ylabel('dB');
legend('20lg|H1(w)|','20lg|H3(w)|'); % ��Ƶ��Ӧ