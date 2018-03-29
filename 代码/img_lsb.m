% ������������Ϣ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Լ��������Ϣλ��
len = 10;

% �������Ҫ���ص�������Ϣ
d = randsrc(1, len, [0 1]);
block = [3, 3];

% ��ʾ���ɵ�������Ϣ
fprintf('\n�������Ҫ���ص�������Ϣ��\n');
fprintf('%d', d);

% ��ȡ�����ļ�
s = imread('lena_g.bmp');
ss = size(s);
if(length(ss) >= 3)
    I = rgb2gray(s);
else
    I = s;
end;
si = size(I);
sN = floor(si(1) / block(1)) * floor(si(2) / block(2));
tN = length(d);

% �������ͼ��ߴ粻��������������Ϣ�����ڴ�ֱ�����ϸ������ͼ��
if sN < tN
    multiple = ceil(tN / sN);
    tmp = [];
    for i = 1:multiple
        tmp = [tmp; I];
    end;
    I = tmp;
end;

% ���������㷨������������д��Ӳ��
stegoed = lsb_encode(block, d, I);
imwrite(stegoed, 'hide.bmp', 'bmp');

% ֮��Ϊ��ȡ������Ϣ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ��ȡ������Ϣ������
y = imread('hide.bmp');
sy = size(y);
if(length(sy) >= 3)
    I = rgb2gray(y);
else
    I = y;
end;

% ������ȡ�㷨�����������Ϣ
out = lsb_decode(block, I);
 
% ��ʾ��ȡ��������Ϣ
len = min(length(d), length(out));
fprintf('\n\n��ȡ��������Ϣ��\n');
fprintf('%d', out(1:len));

% ���Ϊ���������ʲ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rate = sum(abs(out(1:len) - d(1:len))) / len;
y = 1 - rate;
fprintf('\n\nLSB :������Ϣ����:%d\t ������:%f\t  ����λ��:%d\n', len, rate, len * rate);