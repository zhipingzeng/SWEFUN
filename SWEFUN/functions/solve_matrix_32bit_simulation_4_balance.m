clc,close all


R1=1/(1+Alpha1);
R2=1/(1+Alpha2);
R3=1/(1+Alpha3);
R4=1/(1+Alpha4);
R5=1/(1+Alpha5);
R6=1/(1+Alpha6);
T1=Alpha1/(1+Alpha1);
T2=Alpha2/(1+Alpha2);
T3=Alpha3/(1+Alpha3);
T4=Alpha4/(1+Alpha4);
T5=Alpha5/(1+Alpha5);
T6=Alpha6/(1+Alpha6);
R = [R1^6 R2^6 R3^6 R4^6 R5^6 R6^6;T1*R1^5 T2*R2^5 T3*R3^5 T4*R4^5 T5*R5^5 T6*R6^5;T1^2*R1^4 T2^2*R2^4 T3^2*R3^4 T4^2*R4^4 T5^2*R5^4 T6^2*R6^4;T1^3*R1^3 T2^3*R2^3 T3^3*R3^3 T4^3*R4^3 T5^3*R5^3 T6^3*R6^3;T1^4*R1^2 T2^4*R2^2 T3^4*R3^2 T4^4*R4^2 T5^4*R5^2 T6^4*R6^2;T1^5*R1 T2^5*R2 T3^5*R3 T4^5*R4 T5^5*R5 T6^5*R6;];  % note that the accuracy
% R=1e4.*R;  %加权以降低矩阵的条件数
% R = power(R,1/7);
R_transpose=R';

R_max_1=max(R(1,:));
R_max_2=max(R(2,:));
R_max_3=max(R(3,:));
R_max_4=max(R(4,:));
R_max_5=max(R(5,:));
R_max_6=max(R(6,:));
v=[1/R_max_1 1/R_max_2 1/R_max_3 1/R_max_4 1/R_max_5 1/R_max_6];
D = diag(v);
N=D*R;

M=(N'*N+5e-5*eye(6));  %正则化处理


% R = [1 1 1 1 1 1 1 1;R1 R2 R3 R4 R5 R6 R7 R8;R1^2 R2^2 R3^2 R4^2 R5^2 R6^2 R7^2 R8^2;R1^3 R2^3 R3^3 R4^3 R5^3 R6^3 R7^3 R8^3;R1^4 R2^4 R3^4 R4^4 R5^4 R6^4 R7^4 R8^4;R1^5 R2^5 R3^5 R4^5 R5^5 R6^5 R7^5 R8^5;R1^6 R2^6 R3^6 R4^6 R5^6 R6^6 R7^6 R8^6;R1^7 R2^7 R3^7 R4^7 R5^7 R6^7 R7^7 R8^7;];  % note that the accuracy

% R = [0.1^3 0.51^3 6.03^3 43.1^3;0.1^2 0.51^2 6.03^2 43.1^2;0.1 0.51 6.03 43.1;1 1 1 1;];  % note that the accuracy
% R=transpose(R);
% inv_R=load('inv_R.mat');
% inv_R.inv_R(1,1);
% inv_R = inv(R); % 使用的式子
% inv_R=transpose(inv_R);
% inv_R = vpa(inv_R,8);
% inv_R=transpose(inv_R);
Current_dir=cd;
load cumulant3_0.mat;
load cumulant3_1.mat;
load cumulant3_2.mat;
load cumulant3_3.mat;
load cumulant3_4.mat;
load cumulant3_5.mat;
y1=cumulant3_0;
y2=cumulant3_1;
y3=cumulant3_2;
y4=cumulant3_3;
y5=cumulant3_4;
y6=cumulant3_5;
% y1=R(1,1).*(x1/(1+R1))+R(1,2).*(x2/(1+R2))+R(1,3).*(x3/(1+R3))+R(1,4).*(x4/(1+R4));
% y2=R(2,1).*(x1/(1+R1))+R(2,2).*(x2/(1+R2))+R(2,3).*(x3/(1+R3))+R(2,4).*(x4/(1+R4));
% y3=R(3,1).*(x1/(1+R1))+R(3,2).*(x2/(1+R2))+R(3,3).*(x3/(1+R3))+R(3,4).*(x4/(1+R4));
% y4=R(4,1).*(x1/(1+R1))+R(4,2).*(x2/(1+R2))+R(4,3).*(x3/(1+R3))+R(4,4).*(x4/(1+R4));
% y1=R(1,1).*(x1)+R(1,2).*(x2)+R(1,3).*(x3)+R(1,4).*(x4);
% y2=R(2,1).*(x1)+R(2,2).*(x2)+R(2,3).*(x3)+R(2,4).*(x4);
% y3=R(3,1).*(x1)+R(3,2).*(x2)+R(3,3).*(x3)+R(3,4).*(x4);
% y4=R(4,1).*(x1)+R(4,2).*(x2)+R(4,3).*(x3)+R(4,4).*(x4);
% figure(1)
% imshow(y1,[])
% figure(2)
% imshow(y2,[])
% figure(3)
% imshow(y3,[])
% figure(4)
% imshow(y4,[])
% figure(5)
% imshow(y5,[])
% figure(6)
% imshow(y6,[])
% imshow(uint16(y1)*app.strengthen,'Parent',app.CSUSRRF);pause (0.01)
% imshow(uint16(y2)*app.strengthen,'Parent',app.CSUSRRF);pause (0.01)
% imshow(uint16(y3)*app.strengthen,'Parent',app.CSUSRRF);pause (0.01)
% imshow(uint16(y4)*app.strengthen,'Parent',app.CSUSRRF);pause (0.01)
% imshow(uint16(y5)*app.strengthen,'Parent',app.CSUSRRF);pause (0.01)
% imshow(uint16(y6)*app.strengthen,'Parent',app.CSUSRRF);pause (0.01)
%% 写入图像y1-4
filepath = strcat(cd,'\');
length=500;
% for j = 1:1:4 % 4层
%     if j == 1
%         t = Tiff('y1-4.tif','w');
%     else
%         t = Tiff('y1-4.tif', 'a');
%     end
t = Tiff('y1.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,y1);
close(t)

t = Tiff('y2.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,y2);
close(t)

t = Tiff('y3.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,y3);
close(t)

t = Tiff('y4.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,y4);
close(t)

t = Tiff('y5.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,y5);
close(t)

t = Tiff('y6.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,y6);
close(t)

% end

%%
y1=double(y1);
y2=double(y2);
y3=double(y3);
y4=double(y4);
y5=double(y5);
y6=double(y6);
len=size(y1);
x1=zeros(len(1),len(2));
x2=zeros(len(1),len(2));
x3=zeros(len(1),len(2));
x4=zeros(len(1),len(2));
x5=zeros(len(1),len(2));
x6=zeros(len(1),len(2));
for i=1:len(1)
    for j=1:len(2)
        Y=[y1(i,j) y2(i,j) y3(i,j) y4(i,j) y5(i,j) y6(i,j)]';
        Y=D*Y;
        Y=N'*Y; %正则T化处理方法
        X=M\Y;%
        x1(i,j)=X(1);
        x2(i,j)=X(2);
        x3(i,j)=X(3);
        x4(i,j)=X(4);
        x5(i,j)=X(5);
        x6(i,j)=X(6);
    end
end


x1_max=max(max(x1));
x2_max=max(max(x2));
x3_max=max(max(x3));
x4_max=max(max(x4));
x5_max=max(max(x5));
x6_max=max(max(x6));


%%  绝对值化 零化
s=size(x1);
for x=1:s(1)
    for y=1:s(2)
        if x1(x,y)<0
            x1(x,y)=0;  %x1(x,y)=abs(x1(x,y));
        end
    end
end
for x=1:s(1)
    for y=1:s(2)
        if x2(x,y)<0
            x2(x,y)=0;
        end
    end
end
for x=1:s(1)
    for y=1:s(2)
        if x3(x,y)<0
            x3(x,y)=0;
        end
    end
end
for x=1:s(1)
    for y=1:s(2)
        if x4(x,y)<0
            x4(x,y)=0;
        end
    end
end
for x=1:s(1)
    for y=1:s(2)
        if x5(x,y)<0
            x5(x,y)=0;
        end
    end
end
for x=1:s(1)
    for y=1:s(2)
        if x6(x,y)<0
            x6(x,y)=0;
        end
    end
end
% x1=R1^3.*x1+x1;
% x2=R2^3.*x2+x2;
% x3=R3^3.*x3+x3;
% x4=R4^3.*x4+x4;
% x1=R1^4.*x1+x1;
% x2=R2^4.*x2+x2;
% x3=R3^4.*x3+x3;
% x4=R4^4.*x4+x4;
%%
% x1=inv_R(1,1).*int32(y1*100)+inv_R(1,2).*int32(y2*100)+inv_R(1,3).*int32(y3*100)+inv_R(1,4).*int32(y4*100);
% x2=inv_R(2,1).*int32(y1*100)+inv_R(2,2).*int32(y2*100)+inv_R(2,3).*int32(y3*100)+inv_R(2,4).*int32(y4*100);
% x3=inv_R(3,1).*int32(y1*100)+inv_R(3,2).*int32(y2*100)+inv_R(3,3).*int32(y3*100)+inv_R(3,4).*int32(y4*100);
% x4=inv_R(4,1).*int32(y1*100)+inv_R(4,2).*int32(y2*100)+inv_R(4,3).*int32(y3*100)+inv_R(4,4).*int32(y4*100);
%  figure(7)
%  imshow(x1,[])
%  figure(8)
%  imshow(x2,[])
%  figure(9)
%  imshow(x3,[])
%  figure(10)
%  imshow(x4,[])
%  figure(11)
%  imshow(x5,[])
%  figure(12)
%  imshow(x6,[])
% imshow(uint32(x1)*app.strengthen*0.2,'Parent',app.y1);
% imshow(uint32(x2)*app.strengthen*0.2,'Parent',app.y2);
% imshow(uint32(x3)*app.strengthen*0.2,'Parent',app.y3);
% imshow(uint32(x4)*app.strengthen*0.2,'Parent',app.y4);
% imshow(uint32(x5)*app.strengthen*0.2,'Parent',app.y5);
% imshow(uint32(x6)*app.strengthen*0.2,'Parent',app.y6);
x1=int32(x1);
x2=int32(x2);
x3=int32(x3);
x4=int32(x4);
x5=int32(x5);
x6=int32(x6);
t = Tiff('x1.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);  %64 for double and int64
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int); %IEEEFP  for double
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,x1);
close(t)
t = Tiff('x2.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,x2);
close(t)
t = Tiff('x3.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,x3);
close(t)
t = Tiff('x4.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,x4);
close(t)
t = Tiff('x5.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,x5);
close(t)
t = Tiff('x6.tif','w');
t.setTag('Photometric',Tiff.Photometric.MinIsBlack);
t.setTag('Compression',Tiff.Compression.None);
t.setTag('BitsPerSample',32);
t.setTag('SamplesPerPixel',1);
t.setTag('SampleFormat',Tiff.SampleFormat.Int);
t.setTag('ImageLength',length);                      %指定图像长宽像素数
t.setTag('ImageWidth',length);
t.setTag('PlanarConfiguration',Tiff.PlanarConfiguration.Chunky);
write(t,x6);
close(t)
% imwrite(uint16(x1),[filepath 'x1.tif']);
% imwrite(uint16(x2),[filepath 'x2.tif']);
% imwrite(uint16(x3),[filepath 'x3.tif']);
% imwrite(uint16(x4),[filepath 'x4.tif']);
%% Brightness linearization
second_sofi=imread(strcat(cd,'\x1.tif')); 
second_sofi_adj=double(second_sofi).^(1/2);
second_sofi_adj=uint16(1*second_sofi_adj);
% max=max(max(second_sofi_adj));
for i=1:500
    for j=1:500
        if second_sofi_adj(i,j)<=1   %truncate small values
            second_sofi_adj(i,j)=0;
        end
    end
end
% second_sofi_adj = imadjust(second_sofi_adj,[],[],0.5);
imwrite(second_sofi_adj,strcat(cd,'\x1_adj.tif'))
wavelength1 = app.Fluor1;
adjtext1 = strcat('wavelength = ',int2str(wavelength1));
adjtext1 = num2str(adjtext1);
app.adj1.Title.String =adjtext1;
imshow(uint16(second_sofi_adj)*30,'Parent',app.adj1)

second_sofi=imread(strcat(cd,'\x2.tif')); 
second_sofi_adj=double(second_sofi).^(1/2);
second_sofi_adj=uint16(1*second_sofi_adj);
% max=max(max(second_sofi_adj));
for i=1:500
    for j=1:500
        if second_sofi_adj(i,j)<=1   %truncate small values
            second_sofi_adj(i,j)=0;
        end
    end
end
% second_sofi_adj = imadjust(second_sofi_adj,[],[],0.5);
imwrite(second_sofi_adj,strcat(cd,'\x2_adj.tif'))
wavelength2 = app.Fluor2;
adjtext2 = strcat('wavelength = ',int2str(wavelength2));
adjtext2 = num2str(adjtext2);
app.adj2.Title.String =adjtext2;
imshow(uint16(second_sofi_adj)*30,'Parent',app.adj2)

second_sofi=imread(strcat(cd,'\x3.tif')); 
second_sofi_adj=double(second_sofi).^(1/2);
second_sofi_adj=uint16(1*second_sofi_adj);
% max=max(max(second_sofi_adj));
for i=1:500
    for j=1:500
        if second_sofi_adj(i,j)<=1   %truncate small values
            second_sofi_adj(i,j)=0;
        end
    end
end
% second_sofi_adj = imadjust(second_sofi_adj,[],[],0.5);
imwrite(second_sofi_adj,strcat(cd,'\x3_adj.tif'))
wavelength3 = app.Fluor3;
adjtext3 = strcat('wavelength = ',int2str(wavelength3));
adjtext3 = num2str(adjtext3);
app.adj3.Title.String =adjtext3;
imshow(uint16(second_sofi_adj)*30,'Parent',app.adj3)

second_sofi=imread(strcat(cd,'\x4.tif')); 
second_sofi_adj=double(second_sofi).^(1/2);
second_sofi_adj=uint16(1*second_sofi_adj);
% max=max(max(second_sofi_adj));
for i=1:500
    for j=1:500
        if second_sofi_adj(i,j)<=1   %truncate small values
            second_sofi_adj(i,j)=0;
        end
    end
end
% second_sofi_adj = imadjust(second_sofi_adj,[],[],0.5);
imwrite(second_sofi_adj,strcat(cd,'\x4_adj.tif'))
wavelength4 = app.Fluor4;
adjtext4 = strcat('wavelength = ',int2str(wavelength4));
adjtext4 = num2str(adjtext4);
app.adj4.Title.String =adjtext4;
imshow(uint16(second_sofi_adj)*30,'Parent',app.adj4)

second_sofi=imread(strcat(cd,'\x5.tif')); 
second_sofi_adj=double(second_sofi).^(1/2);
second_sofi_adj=uint16(1*second_sofi_adj);
% max=max(max(second_sofi_adj));
for i=1:500
    for j=1:500
        if second_sofi_adj(i,j)<=1   %truncate small values
            second_sofi_adj(i,j)=0;
        end
    end
end
% second_sofi_adj = imadjust(second_sofi_adj,[],[],0.5);
imwrite(second_sofi_adj,strcat(cd,'\x5_adj.tif'))
wavelength5 = app.Fluor5;
adjtext5 = strcat('wavelength = ',int2str(wavelength5));
adjtext5 = num2str(adjtext5);
app.adj5.Title.String =adjtext5;
imshow(uint16(second_sofi_adj)*30,'Parent',app.adj5)

second_sofi=imread(strcat(cd,'\x6.tif'));  
second_sofi_adj=double(second_sofi).^(1/2);
second_sofi_adj=uint16(1*second_sofi_adj);
% max=max(max(second_sofi_adj));
for i=1:500
    for j=1:500
        if second_sofi_adj(i,j)<=1   %truncate small values
            second_sofi_adj(i,j)=0;
        end
    end
end
% second_sofi_adj = imadjust(second_sofi_adj,[],[],0.5);
imwrite(second_sofi_adj,strcat(cd,'\x6_adj.tif'))
wavelength6 = app.Fluor6;
adjtext6 = strcat('wavelength = ',int2str(wavelength6));
adjtext6 = num2str(adjtext6);
app.adj6.Title.String =adjtext6;
imshow(uint16(second_sofi_adj)*30,'Parent',app.adj6)