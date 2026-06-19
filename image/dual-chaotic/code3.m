clc, clear
close all;
% 加密程序
% 生成混沌序列 z1 和 z2
z1 = improved_logistic_chaotic(4,7,0.2506,4,0.3245,0.3125,0.1045);
z2 = improved_logistic_chaotic(4,7,0.4506,4,0.6467,0.3813,0.2509);

% 对 z2 进行处理
z2 = mod(floor(z2 * 10^15), 256); % 对混沌序列z2处理

% 读取图像并转换为双精度类型
% P = uint8(repmat((0:255)', 1, 256)); % A = repmat((0:255)', 1, 256);
%  P = repmat((0:255)', 1, 256);
%  P = uint8(P');
tic;
P = imread('butterfly.png');
% P = imread('Horse.png'); % 待加密图片
% P = imread('Relief.png'); % 待加密图片
% P = imread('Cameraman.png'); % 加解密图片

figure(1)
imshow(P);

P = double(P);  % 转换为双精度类型
figure(2)
histogram(P(:), 256, 'FaceColor', 'b', 'EdgeColor', 'b');
xlabel('Pixel value','fontsize',22);  % 设置横坐标
ylabel('Frequency','fontsize',22);  % 设置纵坐标
set(gca,'fontsize',22);
%ylim([0 600]);  % 将纵坐标范围限制为 0 到 600
% 将二维图像展平为一维向量
P1 = P(:);
% 对图像进行混沌置乱
[z1_sort, ind] = sort(z1);  % 混沌序列 z1 排序并获取索引
for i = 1:256*256
Ps(ind(i)) = P1(i);  % 置乱
end
% 对图像进行扩散
for i = 1:256*256
Pd(i) = bitxor(uint8(Ps(i)), uint8(z2(i)));  % 混沌扩散
end
% 重构加密后的图像
C = reshape(Pd, [256, 256]);  % 将一维数据重构为256x256
C = uint8(C);
imwrite(C,'butterflyc.png');
toc;
% imwrite(C,'Horsec.png'); % 保存加密图片
% imwrite(C,'Reliefc.png'); % 保存加密图片
% imwrite(C,'Cameramanc.png'); % 保存加密图片
figure(3);
imshow(C);
% 显示加密图像的直方图
C = double(C);
figure(4);
histogram(C(:), 256, 'FaceColor', 'b', 'EdgeColor', 'b');
xlabel('Pixel value','fontsize',22);  % 设置横坐标
ylabel('Frequency','fontsize',22);  % 设置纵坐标
set(gca,'fontsize',22);
ylim([0 600]);  % 将纵坐标范围限制为 0 到 600

% 混沌映射函数
function Z_values = improved_logistic_chaotic(T1, T2, p, mu0, x0, y0, z0)
    mu = mu0;
    X_n = x0;
    Y_n = y0;
    Z_n = z0;
    n = 0;
    Z_values = [];
    max_iterations = 256 * 256;
    
    while n < max_iterations
        Z_n1 = mu * Z_n * (1 - Z_n);
        if X_n <= p
            X_n1 = X_n / p;
            Y_n1 = p * X_n;
        else
            X_n1 = (X_n - p) / (1 - p);
            Y_n1 = Y_n * (1 - p) + 1 - p;
        end
        
        X_n = X_n1;
        Y_n = Y_n1;
        
        if mod(n, T1) == 0
            mu = function1(X_n);
        end
        
        if mod(n, T2) == 0
            Z_n = function2(Y_n);
        end
        
        Z_values = [Z_values, Z_n1];
        Z_n = Z_n1;
        n = n + 1;
    end
end

function mu = function1(X_n)
    mu = 3.5699 + (4 - 3.5699) * X_n;
    mu = min(max(mu, 3.5699), 4);
end

function Z_n = function2(Y_n)
    Z_n = Y_n;
    Z_n = min(max(Z_n, 0), 1);
end
