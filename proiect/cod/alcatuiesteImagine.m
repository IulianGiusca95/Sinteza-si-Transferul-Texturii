function img = alcatuiesteImagine(parametri,mBlocuri,blocuri)

[nr_linii nr_coloane] = size(mBlocuri);
suprapunere = ceil(parametri.portiuneSuprapunere * parametri.dimensiuneBloc);
dim = parametri.dimensiuneBloc;

lungime = nr_coloane * parametri.dimensiuneBloc - suprapunere * (nr_coloane-1);
latime = nr_linii * parametri.dimensiuneBloc - suprapunere * (nr_linii-1);
img = uint8(zeros(lungime,latime,3));

for i = 1:nr_linii
    for j = 1:nr_coloane
        if i == 1 && j == 1
            img(1:dim,1:dim,:)=blocuri(:,:,:,mBlocuri(1,1));
        else if i == 1 && j > 1
                img(1:dim,(dim-suprapunere)*(j-1)+1:(dim-suprapunere)*(j-1)+dim,:)=blocuri(:,:,:,mBlocuri(1,j));
            else if i > 1 && j == 1
                    img((dim-suprapunere)*(i-1)+1:(dim-suprapunere)*(i-1)+dim,1:dim,:)=blocuri(:,:,:,mBlocuri(i,1));
                else
                    img((dim-suprapunere)*(i-1)+1:(dim-suprapunere)*(i-1)+dim,(dim-suprapunere)*(j-1)+1:(dim-suprapunere)*(j-1)+dim,:)=blocuri(:,:,:,mBlocuri(i,j));
                end
            end
        end
    end
end



end

