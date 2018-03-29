% 首先是隐藏信息部分
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 约定秘密信息位数
len = 10;

% 随机生成要隐藏的秘密信息
d = randsrc(1, len, [0 1]);
block = [3, 3];

% 显示生成的秘密信息
fprintf('\n随机生成要隐藏的秘密信息：\n');
fprintf('%d', d);

% 读取载体文件
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

% 如果载体图像尺寸不足以隐藏秘密信息，则在垂直方向上复制填充图像
if sN < tN
    multiple = ceil(tN / sN);
    tmp = [];
    for i = 1:multiple
        tmp = [tmp; I];
    end;
    I = tmp;
end;

% 调用隐藏算法，把隐蔽载体写至硬盘
stegoed = lsb_encode(block, d, I);
imwrite(stegoed, 'hide.bmp', 'bmp');

% 之后为提取秘密信息部分
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 读取隐藏信息的载体
y = imread('hide.bmp');
sy = size(y);
if(length(sy) >= 3)
    I = rgb2gray(y);
else
    I = y;
end;

% 调用提取算法，获得秘密信息
out = lsb_decode(block, I);
 
% 显示提取的秘密信息
len = min(length(d), length(out));
fprintf('\n\n提取的秘密信息：\n');
fprintf('%d', out(1:len));

% 最后为计算误码率部分
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rate = sum(abs(out(1:len) - d(1:len))) / len;
y = 1 - rate;
fprintf('\n\nLSB :秘密信息长度:%d\t 误码率:%f\t  错误位数:%d\n', len, rate, len * rate);