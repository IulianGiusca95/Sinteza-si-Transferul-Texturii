# Sinteza-si-Transferul-Texturii
Proiect realizat in Matlab. Se recreeaza o imagine pornind de la o alta imagine (textura) de dimensiuni mai mici. Proiect realizat in anul 3 de studii la cursul de Computer Vision, Conf. dr. Alexe Bogdan.

Proiectul consta din 2 parti:
- Extinderea unei texturi. De la o imagine de dimensiuni mai mici, se formeaza o imagine mai mare, replicand elemente ale texturii initiale
- Recrearea unei imagini (fotografii, peisaj etc) folosind extinderi de texturi

# Cod

Fisierul principal pentru executarea programului este __proiect/cod/ruleazaTema.m__. Din acest fisier se modifica parametrii programului (imaginea de modificat, textura, dimensiunile noii imagini, algoritmul de creare a imaginii etc)

Am implementat trei metode de extindere a texturilor, aprofundate in articolul de referinta mentionat mai jos.
- metoda blocurilor aleatoare
- metoda erorii minime de suprapunere
- metoda frontierei de cost minim (cel mai bun rezultat)

# Fisiere si rezultate

Enuntul intreg al proiectului: __tema3.pdf__

Articolul stiintific: _Image Quilting for Texture Synthesis and Transfer_, autori Alexei A. Efros, William T. Freeman (__articolTextura.pdf__)

Rezultatele obtinute sunt incluse in __tema3_rezultate.pdf__ si folder-ul __imagini__
