function imgSintetizata = realizeazaSintezaTexturii(parametri)

dimBloc = parametri.dimensiuneBloc;
nrBlocuri = parametri.nrBlocuri;

[inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = size(parametri.texturaInitiala);
H = inaltimeTexturaInitiala;
W = latimeTexturaInitiala;
c = nrCanale;

H2 = parametri.dimensiuneTexturaSintetizata(1);
W2 = parametri.dimensiuneTexturaSintetizata(2);
overlap = parametri.portiuneSuprapunere;

% o imagine este o matrice cu 3 dimensiuni: inaltime x latime x nrCanale
% variabila blocuri - matrice cu 4 dimensiuni: punem fiecare bloc (portiune din textura initiala) 
% unul peste altul 
dims = [dimBloc dimBloc c nrBlocuri];
blocuri = uint8(zeros(dims(1), dims(2),dims(3),dims(4)));

%selecteaza blocuri aleatoare din textura initiala
%genereaza (in maniera vectoriala) punctul din stanga sus al blocurilor
y = randi(H-dimBloc+1,nrBlocuri,1);
x = randi(W-dimBloc+1,nrBlocuri,1);
%extrage portiunea din textura initiala continand blocul
for i =1:nrBlocuri
    blocuri(:,:,:,i) = parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
end

imgSintetizata = uint8(zeros(H2,W2,c));
nrBlocuriY = ceil(size(imgSintetizata,1)/dimBloc);
nrBlocuriX = ceil(size(imgSintetizata,2)/dimBloc);


imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * dimBloc,nrBlocuriX * dimBloc,size(parametri.texturaInitiala,3)));

switch parametri.metodaSinteza
    
    case 'blocuriAleatoare'
        %%
        %completeaza imaginea de obtinut cu blocuri aleatoare
        for y=1:nrBlocuriY
            for x=1:nrBlocuriX
                indice = randi(nrBlocuri);
                imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:)=blocuri(:,:,:,indice);
            end
        end
        
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        title('Rezultat obtinut pentru blocuri selectatate aleator');
        return

    
    case 'eroareSuprapunere'
        %%
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere 
        
        %generam o matrice care va retine indicii blocurlor care alcatuiesc
        %imaginea
        
        contor = 1;
        nrTotal = nrBlocuriX * nrBlocuriY;
        mBlocuri = zeros(nrBlocuriX,nrBlocuriY);
        indice = randi(nrBlocuri);
        mBlocuri(1,1)=indice;
        
        %adaugam prima linie, blocurile avand un singur vecin
        for i = 2:nrBlocuriY
            disp(['Adaugam blocul ' num2str(contor+1) ' dintr-un total de ' num2str(nrTotal)]);
            contor=contor+1;
            min = intmax('int32');
            for k = 1:nrBlocuri
                val = eroare(blocuri(:,:,:,indice),blocuri(:,:,:,k),overlap,'vecinLinie');
                if val < min
                    min= val;
                    indiceK = k;
                end
            end
            mBlocuri(1,i)=indiceK;
            indice = indiceK;
        end
        
        
        indice = mBlocuri(1,1);
        %adaugam prima coloana, blocurile avand un singur vecin
        for i=2:nrBlocuriX
            disp(['Adaugam blocul ' num2str(contor+1) ' dintr-un total de ' num2str(nrTotal)]);
            contor=contor+1;
            min = intmax('int32');
            for k = 1:nrBlocuri
                 val = eroare(blocuri(:,:,:,indice),blocuri(:,:,:,k),overlap,'vecinColoana');
                if val < min
                    min= val;
                    indiceK = k;
                end
            end
            mBlocuri(i,1)=indiceK;
            indice=indiceK;
        end
        
        %adaugam restul vecinilor
        for i = 2:nrBlocuriX
            for j = 2:nrBlocuriY
                disp(['Adaugam blocul ' num2str(contor+1) ' dintr-un total de ' num2str(nrTotal)]);
                contor=contor+1;
                min=intmax('int32');
                for k = 1:nrBlocuri
                    val = eroare2(blocuri(:,:,:,mBlocuri(i,j-1)),blocuri(:,:,:,mBlocuri(i-1,j)),blocuri(:,:,:,k),overlap);
                    if val < min
                        min = val;
                        indiceK = k;
                    end
                end
                mBlocuri(i,j)=indiceK;
            end
        end
         imgSintetizata = alcatuiesteImagine(parametri,mBlocuri,blocuri);
         


            
        
     
        
        
	case 'frontieraCostMinim'
        %%
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere 
        
        %generam o matrice care va retine indicii blocurlor care alcatuiesc
        %imaginea
        
        contor = 1;
        nrTotal = nrBlocuriX * nrBlocuriY;
        mBlocuri = zeros(nrBlocuriX,nrBlocuriY);
        indice = randi(nrBlocuri);
        mBlocuri(1,1)=indice;
        
        %adaugam prima linie, blocurile avand un singur vecin
        for i = 2:nrBlocuriY
            disp(['Adaugam blocul ' num2str(contor+1) ' dintr-un total de ' num2str(nrTotal)]);
            contor=contor+1;
            min = intmax('int32');
            for k = 1:nrBlocuri
                val = eroare(blocuri(:,:,:,indice),blocuri(:,:,:,k),overlap,'vecinLinie');
                if val < min
                    min= val;
                    indiceK = k;
                end
            end
            mBlocuri(1,i)=indiceK;
            indice = indiceK;
        end
        
        
        indice = mBlocuri(1,1);
        %adaugam prima coloana, blocurile avand un singur vecin
        for i=2:nrBlocuriX
            disp(['Adaugam blocul ' num2str(contor+1) ' dintr-un total de ' num2str(nrTotal)]);
            contor=contor+1;
            min = intmax('int32');
            for k = 1:nrBlocuri
                 val = eroare(blocuri(:,:,:,indice),blocuri(:,:,:,k),overlap,'vecinColoana');
                if val < min
                    min= val;
                    indiceK = k;
                end
            end
            mBlocuri(i,1)=indiceK;
            indice=indiceK;
        end
        
        %adaugam restul vecinilor
        for i = 2:nrBlocuriX
            for j = 2:nrBlocuriY
                disp(['Adaugam blocul ' num2str(contor+1) ' dintr-un total de ' num2str(nrTotal)]);
                contor=contor+1;
                min=intmax('int32');
                for k = 1:nrBlocuri
                    val = eroare2(blocuri(:,:,:,mBlocuri(i,j-1)),blocuri(:,:,:,mBlocuri(i-1,j)),blocuri(:,:,:,k),overlap);
                    if val < min
                        min = val;
                        indiceK = k;
                    end
                end
                mBlocuri(i,j)=indiceK;
            end
        end
         imgSintetizata = alcatuiesteImagineFrontiera(parametri,mBlocuri,blocuri);

        
        
       
end
end
       
    
