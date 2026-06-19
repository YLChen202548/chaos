clc, clear all
close all;
% 原始图像的直方图分析
A = imread('butterfly.png');
B = imread('Horse.png');
C = imread('Relief.png');
D = imread('Cameraman.png');
A = double(A);
B = double(B);
C = double(C);
D = double(D);

figure(1);
histogram(A(:), 256, 'FaceColor', 'b', 'EdgeColor', 'b');
xlabel('Pixel value','fontsize',22);  % 设置横坐标
ylabel('Frequency','fontsize',22);  % 设置纵坐标
set(gca,'fontsize',22);
%ylim([0 600]);  % 将纵坐标范围限制为 0 到 600
figure(2);
histogram(B(:), 256, 'FaceColor', 'b', 'EdgeColor', 'b');
xlabel('Pixel value','fontsize',22);  % 设置横坐标
ylabel('Frequency','fontsize',22);  % 设置纵坐标
set(gca,'fontsize',22);
%ylim([0 600]);  % 将纵坐标范围限制为 0 到 600
figure(3);
histogram(C(:), 256, 'FaceColor', 'b', 'EdgeColor', 'b');
xlabel('Pixel value','fontsize',22);  % 设置横坐标
ylabel('Frequency','fontsize',22);  % 设置纵坐标
set(gca,'fontsize',22);
ylim([0 10*10e2]);  % 将纵坐标范围限制为 0 到 600
figure(4);
histogram(D(:), 256, 'FaceColor', 'b', 'EdgeColor', 'b');
xlabel('Pixel value','fontsize',22);  % 设置横坐标
ylabel('Frequency','fontsize',22);  % 设置纵坐标
set(gca,'fontsize',22);
%ylim([0 600]);  % 将纵坐标范围限制为 0 到 600