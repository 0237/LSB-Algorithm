function o = lsb_encode( block, data, I )
% LSB隐藏函数
% block:隐藏信息的最小块
% data:要隐藏的信息
% I:载体图片

si = size(I);
lend = length(data);

% 将图像划分为M*N个小块
N = floor(si(2) / block(2));
M = min(floor(si(1) / block(1)), ceil(lend / N));
o = I;

for i = 0 : M-1
    % 计算每小块垂直方向起止位置
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        % 计算每小块隐藏的秘密信息的序号
        idx = i * N + j + 1;
        if idx > lend
            break;
        end;
        % 取每小块隐藏的秘密信息
        bit = data(idx);
        % 计算每小块水平方向起止位置
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        % 将每小块最低位平面替换为秘密信息
        o(rst:red, cst:ced) = bitset(o(rst:red, cst:ced), 1, bit);
    end;
end;
   
end