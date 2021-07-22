clc;
clear;

s = serial('com4');
s.BytesAvailableFcnMode = 'byte';  
s.InputBufferSize = 4096;
s.OutputBufferSize = 1024;
s.BytesAvailableFcnCount = 100;
s.ReadAsyncMode = 'continuous';
s.Terminator = 'CR'; % ��������

fopen(s); % �򿪴���
data = fopen('serial_data.txt','wt');
result = 1;
while(result ~= '#')
    result = fread(s, 1, 'uint8');
end
out = fread(s, 2, 'uint8');

hold on; % ��һ��ͼ
grid on;
InputBufferSize = 100;
margin = 50;
t = 1 : InputBufferSize;
for i = 1 : InputBufferSize
    out = fread(s, 3, 'uint8'); % ÿ�ζ���3���ַ�
    out = out';
    amp = out(2)*16 + out(3); % 16����תΪʮ����
    InputBuffer(i) = amp;
    fprintf(data, '%g\n', amp); % ��������
    plot([1:i], InputBuffer(1,1:i), '-r');
    axis([t(1) t(InputBufferSize) min(InputBuffer)-margin max(InputBuffer)+margin]);
    pause(0.001);
end

for i = 1:1000 % ��̬��ͼ
    t = t + 1;
    for j = 2 : InputBufferSize
        InputBuffer(j-1) = InputBuffer(j);
    end
    out = fread(s, 3, 'uint8');   % ����3���ַ�
    out = out';
    amp = out(2)*16+out(3);
    fprintf(data, '%g\n', amp);
    InputBuffer(InputBufferSize) = amp;
    p = plot(t,InputBuffer(1,:),'-r');
    axis([t(1) t(InputBufferSize) min(InputBuffer)-margin max(InputBuffer)+margin]);
    pause(0.001);
end

fclose(s);
fclose(data);

