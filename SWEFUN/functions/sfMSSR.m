%GMSSR(x0, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh)
function IMSSR = sfMSSR(varargin)
    [x0, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh] = ParseInputs(varargin{:});
    type = "meanshift";
    x1 = double(x0);
    if amp > 1
        if lower(interp) == "bicubic"
            AMP = imresize(x1,amp);% Image magnification by bicubic interpolation
        else
            AMP = FourierMag(x1,amp);% Image magnification by Fourier interpolation
        end
        if(mesh == 1)
            AMP = compGrid(AMP, ceil(amp/2), 1);
        end
    else 
        AMP = x1;
    end
    MS = CoreAnalysisType(type, AMP, psf, amp);

    I3 = MS/max(MS(:));
    x3 = AMP/max(AMP(:));
    % calculate MSSRD with a given order
    for i = 1:order
        I4 = x3 - I3; % Diff
        I5 = max(I4(:)) - I4; % Diff complement
        I5 = I5/max(I5(:)); % Normalization
        I6 = I5.*I3; % Intensity weighting
        I7 = I6/max(I6(:)); % final normalization
        x3 = I3;
        I3 = I7; 
    end
    I3(isnan(I3))=0;
    I3(isnan(I3))=0;
    IMSSR = I3;

    if(excOL)
        th = (100 - OutLiersTh)/100;
%         [f,x] = ecdf(AMP(:));
%         mnX = min(x(f>th));
%         AMP(AMP>mnX) = mnX;
%         [f,x] = ecdf(IMSSR(:));
%         mnX = min(x(f>th));
%         IMSSR(IMSSR>mnX) = mnX;
    end
    if(intNorm)
        IMSSR = IMSSR.*AMP;
    end
end

% Mesh compensation
function imgHVC = compGrid(img, desp, prp)
  [height,width,~] = size(img);
  imgPad = padarray(img,[desp,desp],'symmetric'); % create padding to deal with borders
  imgVI =  imgPad((1+desp):(height+desp), 1:width);
  imgVD =  imgPad((1+desp):(height+desp), (2*desp + 1):(2*desp + width));
  imgHI =  imgPad(1:height, (1+desp):(width+desp));
  imgHD =  imgPad((2*desp + 1):(2*desp + height), (1+desp):(width+desp));

%   imgVI =  imgPad(1:height, 1+desp:width+desp);
%   imgVD =  imgPad(1+(desp*2):height+(desp*2), 1+desp:width+desp);
%   imgHI =  imgPad(1+desp:height+desp, 1:width);
%   imgHD =  imgPad(1+desp:height+desp, 1+(desp*2):width+(desp*2));
  imgHVC = (img + prp*(imgHD  + imgHI + imgVD  + imgVI)) / (1+(4*prp));
end

function iFM = FourierMag(Img, mg)
    img = fft2(Img);
    sz = size(img);
    mdX = ceil(sz(1)/2);
    mdY = ceil(sz(2)/2);
    szF = sz*mg;
    fM = zeros(szF);
    lnX = length((mdX + 1):sz(1));% disp("lnX: " + lnX);
    lnY = length((mdY + 1):sz(2));% disp("lnY: " + lnY);

    img = szF(1)/sz(1) * szF(2)/sz(2) * img;
    
    fM(1:mdX, 1:mdY) = img(1:mdX, 1:mdY); %izq sup cuadrante
    fM(1:mdX, (szF(2)-lnY+1):szF(2)) = img(1:mdX, (1+mdY):sz(2)); %der sup cuadrante
    fM((szF(1)-lnX+1):szF(1), 1:mdY) = img((1+mdX):sz(1), 1:mdY); %izq inf cuadrante
    
    fM((szF(1)-lnX+1):szF(1), (szF(2)-lnY+1):szF(2)) = img((1+mdX):sz(1), (1+mdY):sz(2)); %der inf cuadrante
    iFM = ifft2(fM,'symmetric');
end
function [x0, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh] = ParseInputs(varargin)
    narginchk(6,9);
    x0 = varargin{1};
    amp = varargin{2};
    psf = varargin{3};
    order = varargin{4};
    mesh = varargin{5};
    interp = varargin{6};
    interp = validatestring(interp,{'bicubic','fourier'},mfilename,'INTERP',6);
    if length(varargin) < 7
        intNorm = false;
        excOL = false;
        OutLiersTh = 0.3;
    elseif length(varargin) == 7
        intNorm = varargin{7};
        excOL = false;
        OutLiersTh = 0.3;
    elseif length(varargin) == 8
        intNorm = varargin{7};
        excOL = false;
        OutLiersTh = 0.3;
    elseif length(varargin) == 9
        intNorm = varargin{7};
        excOL = false;
        OutLiersTh = varargin{9};
    end
end
