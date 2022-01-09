% studentnameB2_DIF.m
clc;
clear;

% �������У�ǰ10��Ϊѧ�ţ���6��0
x = [3 1 9 0 1 0 2 0 6 0 0 0 0 0 0 0]; 
N = 16; % ����
n = 0:N-1;
figure; stem(n,x,'filled'); % ��������ͼ��
xlabel('n'); ylabel('x(n)'); title('��������');

XDFT = dftmtx(N)*x'; % �������е�DFT
X1 = zeros(8,2); % ��ʼ����һ������������
X2 = zeros(4,4); % ��ʼ���ڶ�������������
X3 = zeros(2,8); % ��ʼ������������������
X4 = zeros(2,8); % ��ʼ������������������
X = zeros(1,16); % ��ʼ�������Ƶ������
W = exp(-1j*2*pi/N); % W_16^1
W2 = dftmtx(2); % 2��DFTϵ������

% ��һ�����θ���
for k = 0:7
    t1 = W2*[x(k+1);x(k+9)]; 
    X1(k+1,1) = t1(1); X1(k+1,2) = t1(2);
end
% �ڶ������θ���
for k = 0:3 
    t2 = W2*[X1(k+1,1);X1(k+5,1)];
    X2(k+1,1) = t2(1); X2(k+1,2) = t2(2); 
    t2 = W2*[W^k*X1(k+1,2);W^(k+4)*X1(k+5,2)];
    X2(k+1,3) = t2(1); X2(k+1,4) = t2(2);
end
% ���������θ���
for k = 0:1 
    t3 = W2*[X2(k+1,1);X2(k+3,1)];
    X3(k+1,1) = t3(1); X3(k+1,2) = t3(2);
    t3 = W2*[W^(2*k)*X2(k+1,2);W^(2*k+4)*X2(k+3,2)];
    X3(k+1,3) = t3(1); X3(k+1,4) = t3(2);
    t3 = W2*[X2(k+1,3);X2(k+3,3)];
    X3(k+1,5) = t3(1); X3(k+1,6) = t3(2);
    t3 = W2*[W^(2*k)*X2(k+1,4);W^(2*k+4)*X2(k+3,4)];
    X3(k+1,7) = t3(1); X3(k+1,8) = t3(2);
end
% ���ļ����θ���
X4(:,1) = W2*X3(:,1); X4(:,2) = W2*[X3(1,2);W^4*X3(2,2)]; 
X4(:,3) = W2*X3(:,3); X4(:,4) = W2*[X3(1,4);W^4*X3(2,4)];
X4(:,5) = W2*X3(:,5); X4(:,6) = W2*[X3(1,6);W^4*X3(2,6)]; 
X4(:,7) = W2*X3(:,7); X4(:,8) = W2*[X3(1,8);W^4*X3(2,8)];

% λ�����
X(1) = X4(1,1); X(2) = X4(1,5); X(3) = X4(1,3); X(4) = X4(1,7);
X(5) = X4(1,2); X(6) = X4(1,6); X(7) = X4(1,4); X(8) = X4(1,8);
X(9) = X4(2,1); X(10) = X4(2,5); X(11) = X4(2,3); X(12) = X4(2,7);
X(13) = X4(2,2); X(14) = X4(2,6); X(15) = X4(2,4); X(16) = X4(2,8);

figure;
subplot(2,2,1); stem(n,real(XDFT),'filled');
xlabel('k'); ylabel('Re\{X\}'); title('DFT����Ƶ��ʵ��');
subplot(2,2,2); stem(n,imag(XDFT),'filled');
xlabel('k'); ylabel('Im\{X\}'); title('DFT����Ƶ���鲿');
subplot(2,2,3); stem(n,real(X),'filled');
xlabel('k'); ylabel('Re\{X\}'); title('��2DIF-FFTƵ��ʵ��');
subplot(2,2,4); stem(n,imag(X),'filled');
xlabel('k'); ylabel('Im\{X\}'); title('��2DIF-FFTƵ���鲿');

% ������д���ļ�
f = fopen('studentnameB2_DIF.txt','w');
for i = 1:16
    if imag(X(i))<0
        fprintf(f,'X(%d) = %f-j%f\n',i-1,real(X(i)),-imag(X(i)));
    else
        fprintf(f,'X(%d) = %f+j%f\n',i-1,real(X(i)),imag(X(i))); 
    end
end