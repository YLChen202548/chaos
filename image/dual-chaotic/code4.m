clc, clear
close all;
% 破译解密程序
% 生成混沌序列 z1 和 z2
% z1 = improved_logistic_chaotic(4,7,0.2506,4,0.3245,0.3125,0.1045);
% z2 = improved_logistic_chaotic(4,7,0.4506,4,0.6467,0.3813,0.2509);

% 对 z2 进行处理
% z2 = mod(floor(z2 * 10^15), 256); % 对混沌序列z2处理
tic;
P1 = imread('C1.png');
P2 = imread('C2.png');
EK_D = imread('EK_D.png'); % 扩散秘钥
 P3 = imread('butterflyc.png'); % 待解密图片
% P3 = imread('Horsec.png'); % 待解密图片
% P3 = imread('Reliefc.png'); % 待解密图片
% P3 = imread('Cameramanc.png'); % 待解密图片
figure(1);
imshow(P3);
% 转成一维向量 
P1 = P1(:);
P2 = P2(:);
EK_D = EK_D(:);
P3 = P3(:);
for i = 1:256*256
P1s(i) = bitxor(P1(i), EK_D(i));
P2s(i) = bitxor(P2(i), EK_D(i));
P3s(i) = bitxor(P3(i), EK_D(i));
end
for i = 1:256*256
EK_S(i) = 256*double(P1s(i))+double(P2s(i));
end
[EK_SP,ind] = sort(EK_S); % 找到置乱关系
for i = 1:256*256
P3r(i) = P3s(ind(i));
end
D1 = reshape(P1s, [256, 256]);  % 将一维数据重构为256x256
D2 = reshape(P2s, [256, 256]);  % 将一维数据重构为256x256
P3r = reshape(P3r, [256, 256])';  % 将一维数据重构为256x256
imwrite(D1,'D1.png');
imwrite(D2,'D2.png');
imwrite(P3r,'butterflyr.png');
toc;
% imwrite('Horser.png'); % 保存解密图片
% imwrite('Reliefr.png'); % 保存解密图片
% imwrite('Cameramanr.png'); % 保解加密图片
figure(2);
imshow(D1);
figure(3);
imshow(D2);
figure(4);
imshow(P3r);
figure(5);
P3r = double(P3r);
histogram(P3r(:), 256, 'FaceColor', 'b', 'EdgeColor', 'b');
xlabel('Pixel value','fontsize',22);  % 设置横坐标
ylabel('Frequency','fontsize',22);  % 设置纵坐标
set(gca,'fontsize',22);
% ylim([0 10*10e2]);

% 混沌映射函数
% function Z_values = improved_logistic_chaotic(T1, T2, p, mu0, x0, y0, z0)
%     mu = mu0;
%     X_n = x0;
%     Y_n = y0;
%     Z_n = z0;
%     n = 0;
%     Z_values = [];
%     max_iterations = 256 * 256;
%     
%     while n < max_iterations
%         Z_n1 = mu * Z_n * (1 - Z_n);
%         if X_n <= p
%             X_n1 = X_n / p;
%             Y_n1 = p * X_n;
%         else
%             X_n1 = (X_n - p) / (1 - p);
%             Y_n1 = Y_n * (1 - p) + 1 - p;
%         end
%         
%         X_n = X_n1;
%         Y_n = Y_n1;
%         
%         if mod(n, T1) == 0
%             mu = function1(X_n);
%         end
%         
%         if mod(n, T2) == 0
%             Z_n = function2(Y_n);
%         end
%         
%         Z_values = [Z_values, Z_n1];
%         Z_n = Z_n1;
%         n = n + 1;
%     end
% end
% 
% function mu = function1(X_n)
%     mu = 3.5699 + (4 - 3.5699) * X_n;
%     mu = min(max(mu, 3.5699), 4);
% end
% 
% function Z_n = function2(Y_n)
%     Z_n = Y_n;
%     Z_n = min(max(Z_n, 0), 1);
% end
