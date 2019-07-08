function val = eroare2(img1,img2,img3,overlap)

[h,w,c]=size(img1);
suprapunere = ceil(w * overlap);

%calculam eroare pentru vecinul din stanga
img1V = uint8(zeros(h,suprapunere,3));
img3V = uint8(zeros(h,suprapunere,3));

for i = 1 : h
    for j = w - suprapunere + 1 : w
        img1V(i,(j - w + suprapunere),:) = img1(i,j,:);
    end
    
    for k = 1 : suprapunere
        img3V(i,k,:) = img3(i,k,:);
    end
end

E1v = calculeazaEnergie(img1V);
E3v = calculeazaEnergie(img3V);

val1= sum(sum((E1v - E3v) .* (E1v-E3v)));

%calculam eroare ptr vecinul de sus
img2o = uint8(zeros(suprapunere,w,3));
img3o = uint8(zeros(suprapunere,w,3));

for j = 1 : w
            for i = 1 : suprapunere
                img2o(i,j,:)=img2(h-suprapunere+i,j,:);
            end
            
            for k = 1 : suprapunere
                img3o(k,j,:) = img3(k,j,:);
            end
        end
        
        
E2o = calculeazaEnergie(img2o);
E3o = calculeazaEnergie(img3o);

val2 = sum (sum ((E2o - E3o) .* (E2o - E3o)));

val = val1 + val2;

end

