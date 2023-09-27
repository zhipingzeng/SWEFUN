% Selecction core process
function CoreImage = CoreAnalysisType(type, I, psf, amp)
    if lower(type) == "meanshift"
        CoreImage = I;
        for i = 1:1
            CoreImage = ms_core(CoreImage, psf/i, amp);
        end
    end
end
