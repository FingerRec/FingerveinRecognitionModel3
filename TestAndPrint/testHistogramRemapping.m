clc;close all;
img = imread('E:\ͼƬ���ݿ�\Finger Vein Database\Finger Vein Database\001\left\index_1.bmp');
img = imrotate(img,90);
subplot(1,2,1);imshow(img);
gray = rgb2gray(img);
hist = histeq(gray);
subplot(1,2,2);imshow(hist);