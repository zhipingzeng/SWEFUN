% clear
% clc
InputFilepath=cd;
filepath1=strcat(InputFilepath,'\RawData\1\T\');
filepath2=strcat(InputFilepath,'\RawData\2\T\');
filepath3=strcat(InputFilepath,'\RawData\3\T\');
filepath4=strcat(InputFilepath,'\RawData\4\T\');
filepath5=strcat(InputFilepath,'\RawData\5\T\');
filepath6=strcat(InputFilepath,'\RawData\6\T\');
filepath7=strcat(InputFilepath,'\RawData\stack\');
outputFileName2='stack_T.tif';
delete(strcat(filepath7,outputFileName2));
for K=51:150
    img1=imread([filepath1 num2str(K) '.tif']);
    img2=imread([filepath2 num2str(K) '.tif']);
    img3=imread([filepath3 num2str(K) '.tif']);
    img4=imread([filepath4 num2str(K) '.tif']);
    img5=imread([filepath5 num2str(K) '.tif']);
    img6=imread([filepath6 num2str(K) '.tif']);
    img=img1+img2+img3+img4+img5+img6;
    img=imresize(img,500/566,'bicubic');
    imshow(uint16(img)*app.strengthen,'Parent',app.stack_t);pause(0.01)
    imwrite(img, [filepath7 outputFileName2], 'WriteMode', 'append',  'Compression','none');
end