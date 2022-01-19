% (2, 3)-RIVCS

clc;
clear all;
close all;

%Read Input Secret Image
I = imread('image.bmp');
% secret = double(secret);
secret = im2gray(I);
figure, imshow (secret);


%LK01= LK02 (unite all white matrices for 1 and 2 security level)
B0 = [0 255 255 0;];
B1 = [255 0 255 0;];
B2 = [255 255 0 0;];

% LK12 (black matrices for 2 security level)
S21 = [255 255 0 0;];
S22 = [255 0 255 0;];
S23 = [255 0 0 255;];

% LK11 (black matrices for 1 security level)
S1 = [0 255 255 0;];

%size of the secret image
[row col] = size(secret);
%secret message is encoded in m pixels
m=2;
shadow1 = zeros(row*m,col*m);
shadow2 = zeros(row*m,col*m);
shadow3 = zeros(row*m,col*m);

%iteration for all the rows and half of the columns
for i=1:row
 for j=1:col/2
    vector = randperm(4);
    if (secret(i,j)<128)
        shadow1(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(S1(1,vector),2,2);
        shadow2(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(S1(1,vector),2,2);
        shadow3(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(S1(1,vector),2,2);
    else
        shadow1(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(B0(1,vector),2,2);
        shadow2(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(B1(1,vector),2,2);
        shadow3(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(B2(1,vector),2,2);
    end
 end
end

%iteration for all the rows and second half of the columns
for i=1:row
 for j=col/2+1:col
    vector = randperm(4);
    if (secret(i,j)<128)
    shadow1(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(S21(1,vector),2,2);
    shadow2(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(S22(1,vector),2,2);
    shadow3(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(S23(1,vector),2,2);
    else
    shadow1(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(B0(1,vector),2,2);
    shadow2(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(B1(1,vector),2,2);
    shadow3(m*(i-1)+1:i*m, m*(j-1)+1:j*m) = reshape(B2(1,vector),2,2);
    end
 end
end

%stacking the shadows based on the security level
shadow4 = or(~shadow1,~shadow2);
shadow5 = or(~shadow2,~shadow3);
shadow6 = or(~shadow1,~shadow3);
shadow7 = or(shadow4,~shadow3);

imwrite(double(~shadow1),'shadow1.bmp');
figure, imshow('shadow1.bmp');

imwrite(double(~shadow2),'shadow2.bmp');
figure, imshow('shadow2.bmp');

imwrite(double(~shadow3),'shadow3.bmp');
figure, imshow('shadow3.bmp');

imwrite(double(~shadow4),'stackshadow12.bmp');
figure, imshow('stackshadow12.bmp');

imwrite(double(~shadow5),'stackshadow23.bmp');
figure, imshow('stackshadow23.bmp');

imwrite(double(~shadow6),'stackshadow13.bmp');
figure, imshow('stackshadow13.bmp');

imwrite(double(~shadow7),'stackshadow123.bmp');
figure, imshow('stackshadow123.bmp');
