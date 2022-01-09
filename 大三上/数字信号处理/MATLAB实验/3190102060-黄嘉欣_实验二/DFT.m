% DFT.m
clc; clear;
T = 0.000625; N = 32; % �׷���������ÿ���ڴ˴��޸�(��Ϊ��һ��)
% T = 0.005; N = 32; % �ڶ������
% T = 0.0046875; N = 32; % ���������
% T = 0.004; N = 32; % ���������
% T = 0.0025; N = 16; % ���������
t = 0:0.001:N*T; xt = sin(2*pi*50*t); % ԭ�ź�
n = 0:N-1; xn = sin(2*pi*50*n*T); % ������������
k = 0:N-1; X = dftmtx(N)*xn'; % DFT

figure; % ʱ��ͼ��Ա�
subplot(2,1,1); plot(t,xt); xlim([0 N*T]); % ԭ�ź�ͼ��
xlabel('t'); ylabel('x(t)'); title('ԭ�ź�');
subplot(2,1,2); stem(n,xn); xlim([0 N]); % ����ͼ��
xlabel('n'); ylabel('x(n)'); title('������������');

figure; % ����ʱ��ͼ��
subplot(2,2,1); stem(n,real(xn)); xlim([0 N]); % ����ʵ��
xlabel('n'); ylabel('Re\{x(n)\}'); title('����ʵ��');
subplot(2,2,2); stem(n,imag(xn)); xlim([0 N]); % �����鲿
xlabel('n'); ylabel('Im\{x(n)\}'); title('�����鲿');
subplot(2,2,3); stem(n,abs(xn)); xlim([0 N]); % ���е�ģ
xlabel('n'); ylabel('|x(n)|'); title('����ģ��');
subplot(2,2,4); stem(n,180/pi*angle(xn)); xlim([0 N]); % �������
xlabel('n'); ylabel('\phi'); title('�������');

figure; % ����Ƶ��
subplot(4,1,1); stem(k,X); xlim([0 N]); % DFTƵ��
xlabel('k'); ylabel('X'); title('Ƶ��');
subplot(4,1,2); stem(k,abs(X)); xlim([0 N]); % ������
xlabel('k'); ylabel('|X|'); title('������');
max_value = roundn(max(abs(X)),-4); % ���ֵ
max_index = find(roundn(abs(X),-4)==max_value); % Ѱ�����ֵ������
index = max_index(1); % ȡ��һ�����ֵ������
format = sprintf('(%d, %.2f)',(index-1),max_value); % ��һ���������
text((index-1),max_value,format); % ��ͼ������ʾ
subplot(4,1,3); stem(k,real(X)); xlim([0 N]); % Ƶ��ʵ��
xlabel('k'); ylabel('Re\{X\}'); title('Ƶ��ʵ��');
subplot(4,1,4); stem(k,imag(X)); xlim([0 N]); % Ƶ���鲿
xlabel('k'); ylabel('Im\{X\}'); title('Ƶ���鲿');