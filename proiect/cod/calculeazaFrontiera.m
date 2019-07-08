function img = calculeazaFrontiera(img1,img2,opt,suprapunere)
%calculez functia de energie ptr suprafata de suprapunere, apoi aflu drumul
%de cost minim si la final intorc imaginea rezultata dupa ce am reasamblat
%suprapunerea
[h,w,c] = size(img1);

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

E = (E1 - E2) .* (E1 - E2);
d = aflaDrum(E);

imgS = uint8(zeros(h,suprapunere,3));
for i = 1:h
    for j = 1 : d(i,2)
        imgS(i,j,:)=img1S(i,j,:);
    for j = d(i,2)+1:suprapunere
        imgS(i,j,:)=img2S(i,j,:);
    end
    end
end

img = uint8(zeros(h,w,3));
img(:,1:suprapunere,:)=imgS(1:h,1:suprapunere,:);
img(:,suprapunere+1:w,:)=img2(:,suprapunere+1:w,:);

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
E = (E1 - E2) .* (E1 - E2);
Etranspus = E.';
d = aflaDrum(Etranspus); %din cauza faptulu ca am aflat drumul pe matricea transpusa, d va contine pe o linie perechi de numere ce reprezinta coloana-linie si nu linie-coloana

imgS=uint8(zeros(suprapunere,w,3));
for j = 1:w
    for i = 1:d(j,2)
        imgS(i,j,:)=img1S(i,j,:);
    for i = d(j,2)+1:suprapunere
        imgS(i,j,:)=img2S(i,j,:);
    end
    end
end

img = uint8(zeros(h,w,3));
img(1:suprapunere,:,:)=imgS(1:suprapunere,1:w,:);
img(suprapunere+1:h,:,:)=img2(suprapunere+1:h,:,:);
        
end


end

