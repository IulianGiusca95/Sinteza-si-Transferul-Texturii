function val = eroareTextura(img1,img2)
E1=calculeazaEnergie(img1);
E2=calculeazaEnergie(img2);
val = sum (sum ((E1 - E2) .* (E1 - E2)));
end

