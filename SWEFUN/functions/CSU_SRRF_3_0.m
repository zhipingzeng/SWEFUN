% close all;
% clc
% tic
%% Alexa 488 R1=0.10
avg=zeros(500,500);
cumulant2=zeros(500,500);
cumulant3=zeros(500,500);
cumulant4=zeros(500,500);
cumulant5=zeros(500,500);

% filename0=strcat('C:\Zhiping Zeng\FUZHOU UNIV 2\Simultaneous Multicolor SRRF -2020\RawData\stack\stack_R.tif');
stack=app.filename0;
I=Tiff(stack,'r');
img=zeros(500,500,100);
for kk=1:100;
    I.setDirectory(kk);
    img(:,:,kk)=I.read();
    imshow(uint16(img(:,:,kk))*app.strengthen*0.5,'Parent',app.solve_matrix); pause(0.01)
end

v0=img;

% filename1=strcat('C:\Zhiping Zeng\FUZHOU UNIV 2\Simultaneous Multicolor SRRF -2020\RawData\stack\stack_T.tif');
stack=app.filename1;
I=Tiff(stack,'r');
img=zeros(500,500,100);
for kk=1:100;
    I.setDirectory(kk);
    img(:,:,kk)=I.read();
    imshow(uint16(img(:,:,kk))*app.strengthen*0.5,'Parent',app.CSUSRRF); pause(0.01)
end
v1=img;

v=zeros(500,500,100);

% figure
% imshow(v0(:,:,1),[]);
%imshow(uint16(v0(:,:,1)),'Parent',app.CSUSRRF); 

v_frame=zeros(490,490);
v_frame_interp=zeros(500,500);
s=size(v0);
for ii=1:100;   % 插值运算
    v_frame=v0(:,:,ii);
    v_frame_T=v1(:,:,ii);
    for xx=6:495;
        for yy=6:495;
        ave0=sum(v0(xx,yy,:))/s(3);
        p_AAA=(v_frame(xx,yy)-ave0).^6/(200^3);  %换成相加或相乘
        
        v_frame_interp(xx,yy)=p_AAA;

        end
   end
% imshow(v_frame_interp,[])  
% imwrite(uint16(v_frame_interp),[filepath2 int2str(ii) '.tif']);  %激活保存
for i=1:500;
    for j=1:500;
        v(i,j,ii)=v_frame_interp(i,j);
    end
end
end

for x=1:s(1);
    for y=1:s(2);
        %     ave0=sum(v(x,y,:))/s(3);
        %     ave1=sum(v(x,y,:))/s(3);

        G_3=0;

        %     w=12;     %FWHM of PSF
        %     U=exp(-((x.^2+y.^2)./(2*w.^2)));   %PSF
        for t=1:s(3);
            temp3=v(x,y,t);    %3rd absolute value 前面已相乘

            G_3=G_3+abs(temp3);


        end
        brightness=1;

        G_3=G_3/s(3).*brightness^3;

        cumulant3(x,y)=G_3;

    end
end

cumulant3_0=power(cumulant3,1/1);

cumulant3_0=int32(cumulant3_0);
save('cumulant3_0.mat','cumulant3_0');
% disp('0');
% toc

