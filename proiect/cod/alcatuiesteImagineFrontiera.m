function img = alcatuiesteImagineFrontiera(parametri,mBlocuri,blocuri)

[nr_linii nr_coloane] = size(mBlocuri);
suprapunere = ceil(parametri.portiuneSuprapunere * parametri.dimensiuneBloc);
dim = parametri.dimensiuneBloc;

lungime = nr_coloane * parametri.dimensiuneBloc - suprapunere * (nr_coloane-1);
latime = nr_linii * parametri.dimensiuneBloc - suprapunere * (nr_linii-1);
img = uint8(zeros(lungime,latime,3));

%adaug blocurile in imagine dupa ce am efectuat taietura de cost minim
for i = 1 : nr_linii
    for j = 1:nr_coloane
        if i == 1 && j == 1
            img(1:dim,1:dim,:)=blocuri(:,:,:,mBlocuri(1,1));
        else if i == 1 && j > 1
                imgF = calculeazaFrontiera(img(1:dim,(dim-suprapunere)*(j-2)+1:(dim-suprapunere)*(j-2)+dim,:) ,blocuri(:,:,:,mBlocuri(1,j)),'vecinLinie',suprapunere);
                [h w c] = size(imgF);
                img(1:dim,(dim-suprapunere)*(j-1)+1:(dim-suprapunere)*(j-1)+dim,:)=imgF(1:h,1:w,:);
            else if i > 1 && j == 1
                    imgF = calculeazaFrontiera(img((dim-suprapunere)*(i-2)+1:(dim-suprapunere)*(i-2)+dim,1:dim,:),blocuri(:,:,:,mBlocuri(i,1)),'vecinColoana',suprapunere);
                    [h w c] = size(imgF);
                    img((dim-suprapunere)*(i-1)+1:(dim-suprapunere)*(i-1)+dim,1:dim,:)=imgF(1:h,1:w,:);
                else
                    imgF1 = calculeazaFrontiera(img((dim-suprapunere)*(i-1)+1:(dim-suprapunere)*(i-1)+dim,(dim-suprapunere)*(j-2)+1:(dim-suprapunere)*(j-2)+dim,:),blocuri(:,:,:,mBlocuri(i,j)),'vecinLinie',suprapunere);
                    imgF2 = calculeazaFrontiera(img((dim-suprapunere)*(i-2)+1:(dim-suprapunere)*(i-2)+dim,(dim-suprapunere)*(j-1)+1:(dim-suprapunere)*(j-1)+dim,:),imgF1,'vecinColoana',suprapunere);
                    [h w c] = size(imgF2);
                    img((dim-suprapunere)*(i-1)+1:(dim-suprapunere)*(i-1)+dim,(dim-suprapunere)*(j-1)+1:(dim-suprapunere)*(j-1)+dim,:)=imgF2(1:h,1:w,:);
                end
            end
        end
    end
end
                    

end

