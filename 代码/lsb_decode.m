function out = lsb_decode( block, I )
% LSB提取函数
% block:隐藏信息的最小块
% I:载体图片

si = size(I);

% 将图像划分为M*N个小块
N = floor(si(2) / block(2));
M = floor(si(1) / block(1));
out = [];

% 计算比特1判决阈值：即每小块半数以上元素隐藏的是比特1时，判决该小块嵌入的信息为1
thr = ceil((block(1) * block(2) + 1) / 2);
idx = 0;

for i = 0 : M-1
    % 计算每小块垂直方向起止位置
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        % 计算每小块将要数据的秘密信息的序号
        idx = i * N + j + 1;
        % 计算每小块水平方向起止位置
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        % 提取小块最低位平面，统计1比特个数，判决输出秘密信息
        tmp = sum(sum(bitget(I(rst:red, cst:ced), 1)));
        if(tmp >= thr)
            out(idx) = 1;
        else
            out(idx) = 0;
        end;
    end;
end;

end