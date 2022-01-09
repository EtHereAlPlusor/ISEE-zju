% studentnameB2_DIT.m
clc;
clear;

% �������У�ǰ10��Ϊѧ�ţ���6��0
x = [3 1 9 0 1 0 2 0 6 0 0 0 0 0 0 0]; 
N = 16; % ����
n = 0:N-1;
figure; stem(n,x,'filled'); % ��������ͼ��
xlabel('n'); ylabel('x(n)'); title('��������');

XDFT = dftmtx(N)*x'; % �������е�DFT
X1 = zeros(2,8); % ��ʼ����һ������������
X2 = zeros(4,4); % ��ʼ���ڶ�������������
X3 = zeros(8,2); % ��ʼ������������������

X = zeros(16,1); % ��ʼ�������Ƶ������
W = exp(-1j*2*pi/N); % W_16^1
W2 = dftmtx(2); % 2��DFTϵ������
x0 = [x(1);x(9)]; x1 = [x(5);x(13)]; % ����
x2 = [x(3);x(11)]; x3 = [x(7);x(15)]; 
x4 = [x(2);x(10)]; x5 = [x(6);x(14)];
x6 = [x(4);x(12)]; x7 = [x(8);x(16)];

% ��һ�����θ���
X1(:,1) = W2*x0; X1(:,2) = W2*x1; X1(:,3) = W2*x2; X1(:,4) = W2*x3;
X1(:,5) = W2*x4; X1(:,6) = W2*x5; X1(:,7) = W2*x6; X1(:,8) = W2*x7;
% �ڶ������θ���
for k = 0:1 
    for m = 0:3 % ÿ��ѭ���������
        t1 = W2*[X1(k+1,2*m+1);W^(4*k)*X1(k+1,2*m+2)];
        X2(k+1,m+1) = t1(1); X2(k+3,m+1) = t1(2); 
    end
end
% ���������θ���
for k = 0:3 
    for m = 0:1 % ÿ��ѭ���������
        t2 = W2*[X2(k+1,2*m+1);W^(2*k)*X2(k+1,2*m+2)];
        X3(k+1,m+1) = t2(1); X3(k+5,m+1) = t2(2);
    end
end
% ���ļ����θ���
for k = 0:7
    t3 = W2*[X3(k+1,1);W^k*X3(k+1,2)]; 
    X(k+1) = t3(1); X(k+9) = t3(2);
end

figure;
subplot(2,2,1); stem(n,real(XDFT),'filled');
xlabel('k'); ylabel('Re\{X\}'); title('DFT����Ƶ��ʵ��');
subplot(2,2,2); stem(n,imag(XDFT),'filled');
xlabel('k'); ylabel('Im\{X\}'); title('DFT����Ƶ���鲿');
subplot(2,2,3); stem(n,real(X),'filled');
xlabel('k'); ylabel('Re\{X\}'); title('��2DIT-FFTƵ��ʵ��');
subplot(2,2,4); stem(n,imag(X),'filled');
xlabel('k'); ylabel('Im\{X\}'); title('��2DIT-FFTƵ���鲿');

% ������д���ļ�
f = fopen('studentnameB2_DIT.txt','w');
for i = 1:16
    if imag(X(i))<0
        fprintf(f,'X(%d) = %f-j%f\n',i-1,real(X(i)),-imag(X(i)));
    else
        fprintf(f,'X(%d) = %f+j%f\n',i-1,real(X(i)),imag(X(i))); 
    end
end