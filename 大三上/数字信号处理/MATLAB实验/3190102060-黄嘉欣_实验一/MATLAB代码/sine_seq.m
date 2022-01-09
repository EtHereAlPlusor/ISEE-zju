% sine_seq.m
clc;
clear;

% x(n)=sin(0.2*pi*n)�����г���Ϊ10
length = 10;
n = 0:length-1;
x = sin(2*pi*0.1.*n);
k = 0:length-1;
y = dftmtx(10)*x'; % DFT
figure; % ��ͼ
% �����е�ʵ��
subplot(2,2,1);stem(n,real(x));xlabel('n');ylabel('Re\{x(n)\}');title('ʵ��');  
% �����е��鲿
subplot(2,2,2);stem(n,imag(x));xlabel('n');ylabel('Im\{x(n)\}');title('�鲿');
% �����е�ģ�����
subplot(2,2,3);stem(n,abs(x));xlabel('n');ylabel('|x(n)|');title('ģ'); 
subplot(2,2,4);stem(n,(180/pi)*angle(x)); % ������תΪ�Ƕ�
xlabel('n');ylabel('\phi');title('���');
figure;
% ������
subplot(3,1,1);stem(k,abs(y));xlabel('k');ylabel('|y|');title('������');
% Ƶ��ʵ��
subplot(3,1,2);stem(k,real(y));xlabel('k');ylabel('Re\{y\}');title('Ƶ��ʵ��');
% Ƶ���鲿
subplot(3,1,3);stem(k,imag(y));xlabel('k');ylabel('Im\{y\}');title('Ƶ���鲿');