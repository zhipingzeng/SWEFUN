%%%%%%%%%%%%%%%%%%%%%%%%%% Mean Shift Core %%%%%%%%%%%%%%%%%%%%%%%%%%
function MS = ms_core(I, psf, amp)
    hs = round((0.5)*psf*amp); %HS = 0.4247 * FWHM * amp
%     hs = 1;
    if(hs<1)
        hs = 1;
    end
    xPad = padarray(I,[hs,hs],'symmetric');
    int = -hs:hs; % interval to define the neigborhood
%     disp("hs: " + hs);

    M = zeros(size(I));

    [height,width,~] = size(M); % Image dimensions
    for i = int 
        for j = int 
            if  (i~=0 || j~=0) && sqrt(i^2+j^2)<=hs
                xThis =  xPad(hs+i+1:height+hs+i, hs+j+1:width+hs+j);
                M =  max(M,abs(I - xThis)); % Maxmiun value of the neigborhood          
            end
        end
    end

    weightAccum = 0; % initialize cumulative weights
    yAccum = 0; % initialize cumultative values

    for i = int
        for j = int

            if (i~=0 || j~=0) && sqrt(i^2+j^2)<=hs
                spatialKernel = exp(-(i^2+j^2)/(hs)^2);% Spatial kernel
                xThis =  xPad(hs+i+1:height+hs+i, hs+j+1:width+hs+j);
                xDiffSq0 = ((I - xThis)./M).^2; %max(AMP(:))
                intensityKernel = exp(-xDiffSq0);% Range kernel

                weightThis = spatialKernel.*intensityKernel; % Weights
                weightAccum = weightAccum + weightThis; % Cumulant weights
                yAccum = yAccum + xThis.*weightThis; % Cumulant values            
            end
        end
    end
    
    MS = I-(yAccum./weightAccum); % Meanshift value
    MS(MS < 0) = 0; % Remove negative values
    MS(isnan(MS)) = 0; % change NaN values by zeroend
end