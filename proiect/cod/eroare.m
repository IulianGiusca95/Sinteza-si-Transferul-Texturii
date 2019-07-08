function val = eroare(img1,img2,overlap,opt)
%calculeaza eroarea de suprapunere dintre doua imagini

[h,w,c] = size(img1);
suprapunere = ceil(w * overlap);

switch opt
    case 'vecinLinie'

img1S = uint8(zeros(h,suprapunere,3));
img2S = uint8(zeros(h,suprapunere,3));

for i = 1 : h
    for j = w - suprapunere + 1 : w
        img1S(i,(j - w + suprapunere),:) = img1(i,j,:);
    end
    
    for k = 1 : suprapunere
        img2S(i,k,:) = img2(i,k,:);
    end
end

E1 = calculeazaEnergie(img1S);
E2 = calculeazaEnergie(img2S);

val = sum (sum ((E1 - E2) .* (E1 - E2)));

    case 'vecinColoana'
        img1S = uint8(zeros(suprapunere,w,3));
        img2S = uint8(zeros(suprapunere,w,3));
        
        for j = 1 : w
            for i = 1 : suprapunere
                img1S(i,j,:)=img1(h-suprapunere+i,j,:);
            end
            
            for k = 1 : suprapunere
                img2S(k,j,:) = img2(k,j,:);
            end
        end
        
        
E1 = calculeazaEnergie(img1S);
E2 = calculeazaEnergie(img2S);

val = sum (sum ((E1 - E2) .* (E1 - E2)));

end




end

