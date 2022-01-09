% studentnameB4.m
clc;
clear;

% �������У�ǰ10��Ϊѧ�ţ���6��0
x = [3 1 9 0 1 0 2 0 6 0 0 0 0 0 0 0]; 
N = 16; % ����
n = 0:N-1;
figure; stem(n,x,'filled'); % ��������ͼ��
xlabel('n'); ylabel('x(n)'); title('��������');

XDFT = dftmtx(N)*x'; % �������е�DFT
X = zeros(16,1); % ��ʼ�������Ƶ������
W = exp(-1j*2*pi/N); % W_16^1
W4 = dftmtx(4); % 4��DFTϵ������
x0 = [x(1);x(5);x(9);x(13)]; % ����
x1 = [x(2);x(6);x(10);x(14)];
x2 = [x(3);x(7);x(11);x(15)];
x3 = [x(4);x(8);x(12);x(16)];

% ��һ�����θ���
X0 = W4*x0; X1 = W4*x1; X2 = W4*x2; X3 = W4*x3;
% �ڶ������θ���
for k = 0:3 % ÿ��ѭ������ĵ�
   t = W4*[X0(k+1);W^k*X1(k+1);W^(2*k)*X2(k+1);W^(3*k)*X3(k+1)];
   X(k+1) = t(1); X(k+5) = t(2); X(k+9) = t(3); X(k+13) = t(4);
end

figure;
subplot(2,2,1); stem(n,real(XDFT),'filled');
xlabel('k'); ylabel('Re\{X\}'); title('DFT����Ƶ��ʵ��');
subplot(2,2,2); stem(n,imag(XDFT),'filled');
xlabel('k'); ylabel('Im\{X\}'); title('DFT����Ƶ���鲿');
subplot(2,2,3); stem(n,real(X),'filled');
xlabel('k'); ylabel('Re\{X\}'); title('��4-FFTƵ��ʵ��');
subplot(2,2,4); stem(n,imag(X),'filled');
xlabel('k'); ylabel('Im\{X\}'); title('��4-FFTƵ���鲿');

% ������д���ļ�
f = fopen('studentnameB4.txt','w');
for i = 1:16
    if imag(X(i))<0
        fprintf(f,'X(%d) = %f-j%f\n',i-1,real(X(i)),-imag(X(i)));
    else
        fprintf(f,'X(%d) = %f+j%f\n',i-1,real(X(i)),imag(X(i))); 
    end
end