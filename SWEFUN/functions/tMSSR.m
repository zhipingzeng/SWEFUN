%tMSSR(imgName, dimz, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh)
function iMSSR = tMSSR(varargin)
    disp(varargin);
    [imgName, dimz, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh] = ParseInputs(varargin{:});
    for j = 1:dimz
%         disp("Image " + j);
        Img = double(imread(imgName,j));
        [iMSSR(:,:,j)] = sfMSSR(Img, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh);
    end
%     disp("--- Termine ---")
end

function [imgName, dimz, amp, psf, order, mesh, interp, intNorm, excOL, OutLiersTh] = ParseInputs(varargin)
    narginchk(7,10);
    imgName = varargin{1};
    dimz = varargin{2};
    amp = varargin{3};
    psf = varargin{4};
    order = varargin{5};
    mesh = varargin{6};
    interp = varargin{7};
    interp = validatestring(interp,{'bicubic','fourier'},mfilename,'INTERP',7);
    if length(varargin) < 8
        intNorm = false;
        excOL = false;
        OutLiersTh = 0.3;
    elseif length(varargin) == 8
        intNorm = varargin{8};
        excOL = false;
        OutLiersTh = 0.3;
    elseif length(varargin) == 9
        intNorm = varargin{8};
        excOL = false;
        OutLiersTh = 0.3;
    elseif length(varargin) == 10
        intNorm = varargin{8};
        excOL = false;
        OutLiersTh = varargin{10};
    end
end
