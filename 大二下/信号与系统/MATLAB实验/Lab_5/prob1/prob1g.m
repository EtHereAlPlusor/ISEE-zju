% prob1g.m
clear;
clc;

omega0=2*pi*3000;
omegas=2*pi*8192; % ��ֹƵ�������Ƶ��
T=1/8192;
beta=2000;
t=0:T:1-T; % 0<=t<1
x=sin(omega0.*t+0.5*beta.*t.*t);
plot(t,x);
sound(x,1/T);

% ��˲ʱƵ�ʵ��ڲ���Ƶ�ʵ�һ��ʱ��
% the chrip signal has its maximum pitch