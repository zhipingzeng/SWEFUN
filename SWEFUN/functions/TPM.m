function ITemp = TPM(I)
    ITemp = zeros(size(I,1),size(I,2));
    ITempSum = zeros(size(I,1),size(I,2));
    for i = 1:size(I,3)
        ITempSum = ITempSum + I(:,:,i);
    end
    for i = 1:size(I,3)
        ITemp = ITemp +  (I(:,:,i).*ITempSum); 
    end
end

function ITemp = Var(I)
ITemp = zeros(size(I,1),size(I,2));
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            ITemp(i,j) = var(I(i,j,:)); 
        end
    end

end

function TRAC= trac(I, t)

Avg = mean(I,3);

d0 = abs(I-Avg);
d1 = d0(:,:,2:end);
d2 = d0(:,:,3:end);
d3 = d0(:,:,4:end);

if(t==2)
    TRAC = mean(d0(:,:,2:end).*d1,3);
elseif(t==3)
    TRAC = mean(d0(:,:,3:end).*d1(:,:,2:end).*d2,3);
else
    TRAC = abs(mean(d0(:,:,4:end).*d1(:,:,3:end).*d2(:,:,2:end).*d3,3)-...
        mean(d0(:,:,4:end).*d1(:,:,3:end),3).*mean(d2(:,:,2:end).*d3,3)-...
        mean(d0(:,:,4:end).*d2(:,:,2:end),3).*mean(d1(:,:,3:end).*d3,3)-...
        mean(d0(:,:,4:end).*d3,3).*mean(d1(:,:,3:end).*d2(:,:,2:end),3));
end
end

