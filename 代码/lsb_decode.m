function out = lsb_decode( block, I )
% LSB��ȡ����
% block:������Ϣ����С��
% I:����ͼƬ

si = size(I);

% ��ͼ�񻮷�ΪM*N��С��
N = floor(si(2) / block(2));
M = floor(si(1) / block(1));
out = [];

% �������1�о���ֵ����ÿС���������Ԫ�����ص��Ǳ���1ʱ���о���С��Ƕ�����ϢΪ1
thr = ceil((block(1) * block(2) + 1) / 2);
idx = 0;

for i = 0 : M-1
    % ����ÿС�鴹ֱ������ֹλ��
    rst = i * block(1) + 1;
    red = (i + 1) * block(1);
    for j = 0 : N-1
        % ����ÿС�齫Ҫ���ݵ�������Ϣ�����
        idx = i * N + j + 1;
        % ����ÿС��ˮƽ������ֹλ��
        cst = j * block(2) + 1;
        ced = (j + 1) * block(2);
        % ��ȡС�����λƽ�棬ͳ��1���ظ������о����������Ϣ
        tmp = sum(sum(bitget(I(rst:red, cst:ced), 1)));
        if(tmp >= thr)
            out(idx) = 1;
        else
            out(idx) = 0;
        end;
    end;
end;

end