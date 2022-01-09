% LP_FIR_31.m
clc; clear;

wc = 0.5*pi; % ��ֹƵ��
N = 31; % ����
n = 0:N-1;
w1 = (rectwin(N))'; % ���δ�
w2 = (hamming(N))'; % ������

% ��һ���˲����ĵ�λ������Ӧ����
h1 = fir1(N-1,wc/pi,w1);
% �ڶ����˲����ĵ�λ������Ӧ����
h2 = fir1(N-1,wc/pi,w2);

% ��һ���˲�����Ƶ����Ӧ�������ֵ
[H1,db1,mag1,pha1,grd1,w1] = freqz_m(h1,1);
H1k = dftmtx(N)*h1';
% �ڶ����˲�����Ƶ����Ӧ�������ֵ
[H2,db2,mag2,pha2,grd2,w2] = freqz_m(h2,1);
H2k = dftmtx(N)*h2';

% ��h1��H1�ĳ���ֵд���ļ�
f1 = fopen('../MATLAB������/LPRectWindow.txt','w');
for i = 1:6
    for j = 1:5 % ÿ��6��
        fprintf(f1,'h1(%d) = %.6f, ',5*(i-1)+j-1,h1(5*(i-1)+j));
    end
    fprintf(f1,'\n');
end
fprintf(f1,'h1(30) = %.6f\n',h1(31));
for i = 1:6
    for j = 1:5 % ÿ��6��
        fprintf(f1,'H1(%d) = %.6f, ',5*(i-1)+j-1,H1k(5*(i-1)+j));
    end
    fprintf(f1,'\n');
end
fprintf(f1,'H1(30) = %.6f\n',H1k(31));

% ��h2��H2�ĳ���ֵд���ļ�
f2 = fopen('../MATLAB������/LPHamming.txt','w');
for i = 1:6
    for j = 1:5 % ÿ��5��
        fprintf(f2,'h2(%d) = %.6f, ',5*(i-1)+j-1,h2(5*(i-1)+j));
    end
    fprintf(f2,'\n');
end
fprintf(f2,'h2(30) = %.6f\n',h2(31));
for i = 1:6
    for j = 1:5 % ÿ��6��
        fprintf(f2,'H2(%d) = %.6f, ',5*(i-1)+j-1,H2k(5*(i-1)+j));
    end
    fprintf(f2,'\n');
end
fprintf(f2,'H2(30) = %.6f\n',H2k(31));

% ��ͼ
figure; 
subplot(3,1,1); stem(n,h1,'filled'); % h1(n)
title('h1(n)'); xlabel('n'); ylabel('magnitude');
subplot(3,1,2); stem(n,abs(H1k),'filled'); % |H1(k)|
title('|H1(k)|'); xlabel('k'); ylabel('magnitude');
subplot(3,1,3); plot(0:1/500:1,20*log10(mag1)); % H1(w)
title('20lg|H1(w)|'); 
xlabel('frequency in pi units'); ylabel('Decibels');

figure; 
subplot(3,1,1); stem(n,h2,'filled'); % h2(n)
title('h2(n)'); xlabel('n'); ylabel('magnitude');
subplot(3,1,2); stem(n,abs(H2k),'filled'); % |H2(k)|
title('|H2(k)|'); xlabel('k'); ylabel('magnitude');
subplot(3,1,3); plot(0:1/500:1,20*log10(mag2)); % H2(w)
title('20lg|H2(w)|'); 
xlabel('frequency in pi units'); ylabel('Decibels');

% �Ƚ����߲���
figure;
subplot(3,1,1); stem(n,h1,'filled'); 
hold on; stem(n,h2,':p','filled');
title('��λ������Ӧ����'); xlabel('n'); ylabel('magnitude');
legend('h1(n)','h2(n)');
subplot(3,1,2); stem(n,abs(H1k),'filled'); 
hold on; stem(n,abs(H2k),':p','filled');
title('Ƶ����Ӧ��������'); xlabel('k'); ylabel('magnitude');
legend('|H1(k)|','|H2(k)|');
subplot(3,1,3); plot(0:1/500:1,20*log10(mag1)); 
hold on; plot(0:1/500:1,20*log10(mag2),'-r');
title('Ƶ����Ӧ'); xlabel('frequency in pi units'); ylabel('dB');
legend('20lg|H1(w)|','20lg|H2(w)|');
