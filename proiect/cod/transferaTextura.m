function img = transferaTextura(parametri)

dimBloc = parametri.dimensiuneBloc ;
nrBlocuri = parametri.nrBlocuri;


[H1,W1,C1] = size(parametri.texturaInitiala);
[H2,W2,C2] = size(parametri.transferInitial);

nrBlocuriX = ceil(H2/dimBloc);
nrBlocuriY = ceil(W2/dimBloc);

contor=1;
nrTotal= nrBlocuriX*nrBlocuriY;

img = uint8(zeros(nrBlocuriX * dimBloc,nrBlocuriY*dimBloc,3));
imgRedimensionata = imresize(parametri.transferInitial,[nrBlocuriX * dimBloc,nrBlocuriY*dimBloc]);

% variabila blocuri - matrice cu 4 dimensiuni: punem fiecare bloc (portiune din textura initiala) 
% unul peste altul 
dims = [dimBloc dimBloc C2 nrBlocuri];
blocuri = uint8(zeros(dims(1), dims(2),dims(3),dims(4)));

%selecteaza blocuri aleatoare din textura initiala
%genereaza (in maniera vectoriala) punctul din stanga sus al blocurilor
y = randi(H1-dimBloc+1,nrBlocuri,1);
x = randi(W1-dimBloc+1,nrBlocuri,1);
%extrage portiunea din textura initiala continand blocul
for i =1:nrBlocuri
    blocuri(:,:,:,i) = parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
end

for i=1:nrBlocuriX
    for j=1:nrBlocuriY
        disp(['Adaugam blocul ' num2str(contor) ' dintr-un total de ' num2str(nrTotal)]);
        contor=contor+1;
        min=intmax('int32');
        max = 0;
        valori=zeros(1,nrBlocuri);
        for k=1:nrBlocuri
            val= eroareTextura(imgRedimensionata((i-1)*dimBloc+1:(i-1)*dimBloc+dimBloc,(j-1)*dimBloc+1:(j-1)*dimBloc+dimBloc ,:), blocuri(:,:,:,k));
            valori(1,k)=val;
            if val < min
                min = val;
                indiceK = k;
            end
        end
        eroareAcceptata = min + parametri.eroareTolerata * min;
        contorNrAcceptate=0;
        valoriAcceptate=zeros(1,nrBlocuri);
        for k=1:nrBlocuri
            if valori(1,k)<=eroareAcceptata
                contorNrAcceptate=contorNrAcceptate+1;
                valoriAcceptate(1,contorNrAcceptate)=k;
            end
        end
        vA=valoriAcceptate(1,1:contorNrAcceptate);
        
        img((i-1)*dimBloc+1:(i-1)*dimBloc+dimBloc,(j-1)*dimBloc+1:(j-1)*dimBloc+dimBloc ,:)=blocuri(:,:,:,vA(randi(contorNrAcceptate)));
    end
end
        
end

