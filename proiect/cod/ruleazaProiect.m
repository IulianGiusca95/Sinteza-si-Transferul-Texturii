%citeste imaginile
img = imread('../data/img5.png');
imgTextura = imread('../data/eminescu.jpg');

%seteaza parametri
parametri.texturaInitiala = img;
parametri.transferInitial = imgTextura;
parametri.dimensiuneTexturaSintetizata = [2*size(img,1) 2*size(img,2)];
parametri.dimensiuneBloc = 36;

parametri.nrBlocuri = 2000;
parametri.eroareTolerata = 0.1;
parametri.portiuneSuprapunere = 1/6;
%parametri.metodaSinteza = 'blocuriAleatoare';
parametri.metodaSinteza = 'eroareSuprapunere';
%parametri.metodaSinteza = 'frontieraCostMinim';

%imgSintetizata = realizeazaSintezaTexturii(parametri);
%imwrite(imgSintetizata,'img5_1.jpg');
imgTransferTextura = transferaTextura(parametri);
imwrite(imgTransferTextura,'eminescu1.jpg');