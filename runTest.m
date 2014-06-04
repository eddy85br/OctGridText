## easyDNA = imread('../DNApics/easyDNA.png');
## fasta   = imread('../DNApics/fasta_dna.png');
## letras  = imread('../DNApics/letras.jpg');
## DNAimg  = imread('../DNApics/DNA.jpg');

## DNA = easyDNA(1:255, 1:255);
## DNA = fasta(1:255, 1:255);
## DNA = letras(1:255, 1:255, 1);
DNA = DNAimg(1:255, 1:255, 1);

DNA(find(DNA > median(median(DNA) * 1.1))) = 255;
DNA(find(DNA < median(median(DNA) * 0.9))) = 0;

#DNA(find(DNA >  60)) = 255;
#DNA(find(DNA <= 60)) = 0;

## Setting variables "GA Options" to gaGnuOct
gaOptions.InitialPopulation = [];
gaOptions.MutationRate      = 0.5;
gaOptions.PopulationSize    = 5000;
gaOptions.EliteCount        = 2500;
gaOptions.Generations       = 25;

[x pop fitvals] = gaGnuOct(@(bits)fitGrid(DNA, bits), 16, gaOptions);
[rowSize, colSize] = size(DNA);
yPos = bits2bytes(topLines(pop, fitvals));

yPos(find(yPos <= 0)) = 1;
yPos(find(yPos > rowSize)) = rowSize;

desvio = abs(yPos(:,1) - yPos(:,2));
mediana = median(desvio);
#media = mean(desvio);
#metrica = mediana + media;

#yFiltered = yPos(find(desvio) <= metrica, :);
yFiltered = yPos(find(desvio <= mediana * 1.25), :);

xPos = [ones(size(yFiltered)(1),1), repmat(colSize, size(yFiltered)(1),1)];
drawLine(DNA, yFiltered, xPos);

