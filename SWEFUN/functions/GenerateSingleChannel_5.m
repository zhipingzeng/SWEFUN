%--------------------------------------------------------------------------
% Source code for generating stacks of blinking frames for different
% channels
% Copyright 2018 Zhiping Zeng
%--------------------------------------------------------------------------
%% Read resolution target file

close all;
clc
InputFilepath=cd;
pixelnumber=500;
aa=zeros(pixelnumber);
tt=zeros(pixelnumber);
resolution_target_3=imread('picture\target-5-adjust.tif');  %change with 1 2 5 6 or 1 2 3 4

[row, col] = find( resolution_target_3 >= 34);   % 42 
num = size(row, 1);           
bb=aa;
for i = 1:1:num                
    bb(row(i), col(i)) = 1;     % Reflection rates = 0.10,0.51,6.03,43.1
end
%imshow(bb,[])
imshow(uint8(bb)*app.strengthen,'Parent',app.originalpic)        


%% Generate power law blinking
bright5 = app.bright5;
darkness = app.darkness;
n1_R=bright5/(1+Alpha5);  %change Reflection rates = 0.10,0.51,6.03,43.1
n1_T=bright5-n1_R;  %ԭ 200
n2=darkness/(1+Alpha5);
n2_T=darkness-n2;
% n2=0;
% n2_T=0;
C = zeros(num,2*1000);
for n=1:1:num              
alpha=1.5;
alpha_off=1.9;
dmax=1;
frame_time=0.03; % s
xx=rand(1,1000);
ton1 = 0.01*exp(log(dmax)-log(xx)./alpha);    %on time power law
frame_on1 = ceil(ton1/frame_time);
xx=rand(1,1000);
toff1 = 0.01*exp(log(dmax)-log(xx)./alpha_off);  %off time power law
frame_off1 = 2*ceil(toff1/frame_time);
C(n,1:2:end) = frame_on1;  % 'on' state frame number
C(n,2:2:end) = frame_off1;
end  
a=ones(1,num);
for frame=1:150
    for m=1:1:num
    if C(m,a(m))>0
       aa(row(m), col(m))  = n1_R;
       tt(row(m), col(m))  = n1_T;
        C(m,a(m))=C(m,a(m))-1;
    else aa(row(m), col(m))  = n2;   % n changed to m
        tt(row(m), col(m))  = n2_T;
        a(m)=a(m)+1;
        temp1=n1_R;
        n1_R=n2;
        n2=temp1;    
        temp2=n1_T;
        n1_T=n2_T;
        n2_T=temp2;   
    end
    end
    
%% Convolution with PSF

xx=-1:0.03:1; %pixel size 30nm
PSFX=gaussmf(xx,[app.psf 0]);   %fwhm=223.8nm for 0.095
PSFXY=PSFX'*PSFX; 
jj=conv2(aa,PSFXY);  %image convolution
kk=conv2(tt,PSFXY);  %image convolution
% 
% figure(2)
% %imshow(jj,[]);pause(0.01)
imshow(uint16(jj)*app.strengthen,'Parent',app.blinkingf);pause(0.01)
filepath=strcat(InputFilepath,'\RawData\5\R\');  %change filepath
mkdir(filepath);
imwrite(uint16(jj),[filepath int2str(frame) '.tif']);
filepath=strcat(InputFilepath,'\RawData\5\T\');  %change filepath
mkdir(filepath);
imwrite(uint16(kk),[filepath int2str(frame) '.tif']);
imwrite(uint16(bb),[filepath 'target.tif']);
end
