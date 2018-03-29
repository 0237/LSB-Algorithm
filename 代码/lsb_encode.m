function o = lsb_encode( block, data, I )
% LSB���غ���
% block:������Ϣ����С��
% data:Ҫ���ص���Ϣ
% I:����ͼƬ

si = size(I);
lend = length(data);

% ��ͼ�񻮷�ΪM*N��С��
N = floor(si(2) / block(2));
M = min(floor(si(1) / block(1)), ceil(lend / N));
o = I;

for i = 0 : M-1
    % ����ÿС�鴹ֱ������ֹλ��
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        % ����ÿС�����ص�������Ϣ�����
        idx = i * N + j + 1;
        if idx > lend
            break;
        end;
        % ȡÿС�����ص�������Ϣ
        bit = data(idx);
        % ����ÿС��ˮƽ������ֹλ��
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        % ��ÿС�����λƽ���滻Ϊ������Ϣ
        o(rst:red, cst:ced) = bitset(o(rst:red, cst:ced), 1, bit);
    end;
end;
   
end