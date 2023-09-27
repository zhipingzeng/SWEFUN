[filename_mssr,pathname_mssr] = uigetfile({'*.*';'*.jpg';'*.tif';'*.tiff';'*.png';'*.bmp'},'Select the original image for MSSR processing');
all_name = strcat(pathname_mssr,filename_mssr);
mssr_pic = double(imread(all_name,1));
filename_2 = filename_mssr;
imwrite(uint16(mssr_pic), 'mssr_OR.tif');
msgbox('MSSR running','Running','help');
imgName = 'mssr_OR.tif';
amp = app.mssr_amp;
psf = app.mssr_psf;
order = app.mssr_order;
frames = app.mssr_frames;
mesh = 1;
interp = "bicubic";
% interp = "fourier";
intNorm = true;
excOL = true;
OutLiersTh = 0.3;
imgResult = tMSSR(imgName, 1, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh);
ITPMD = TPM(imgResult);
IMEAND = mean(imgResult, 3);
IVARD= var(imgResult, 0 ,3);
imwrite(uint16(imgResult(:,:,1)),[filename_2 '_mssr.tif'])
if frames >1
    for i=2:frames
        mssr_pic = double(imread(all_name,i));
        imwrite(uint16(mssr_pic), 'mssr_OR.tif');
        imgName = 'mssr_OR.tif';

        % interp = "fourier";
        intNorm = true;
        excOL = true;
        OutLiersTh = 0.3;

        imgResult = tMSSR(imgName, 1, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh);

        ITPMD = TPM(imgResult);
        IMEAND = mean(imgResult, 3);
        IVARD= var(imgResult, 0 ,3);

        %figure; imshow(imgResult(:,:,1), []); title("First")
        imwrite(uint16(imgResult(:,:,1)),[filename_2 '_mssr.tif'],'WriteMode','append')
        %figure; imshow(IVARD, []);
        %figure; imshow(IMEAND, []);
        i
        
    end
end
