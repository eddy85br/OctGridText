function [r populations fitValues] = runTest(level)
	r = 'error!';
	switch level
		case 1
			picture = imread('./sampleData/easyDNA.png');
		case 2
			picture = imread('./sampleData/fasta_dna.png');
		case 3
			picture = imread('./sampleData/letras.jpg');
		case 4
			picture = imread('./sampleData/DNA.jpg');
		case 5
			picture = imread('./sampleData/fasta_dna90.png');
		case 6
			picture = imread('./sampleData/fasta_dna20.png');
		otherwise
			picture = level;
	end
	
	[numRows, numCols] = size(picture);		# Get the image size
	sliceNumber = 0;
	for rowNumber = 1:255:numRows
		sliceNumber++;
		sliceSize = rowNumber + 254;
		if sliceSize > numRows
			sliceSize = numRows;
		endif
		slice = picture(rowNumber:sliceSize, :, 1);
		disp(['rowNumber: ' num2str(rowNumber) "\t\tsliceSize: " num2str(sliceSize)]);
		
		if ~ isbool(slice)
			m = median(median(slice));
			slice(find(slice > m * 1)) = 255;
			slice(find(slice < m * 1)) = 0;
			#slice(find(slice >  60)) = 255;
			#slice(find(slice <= 60)) = 0;
		endif
		
		## Setting variables "GA Options" to gaGnuOct
		gaOptions.InitialPopulation = [];
		gaOptions.MutationRate      = 0.25;
		gaOptions.PopulationSize    = 5000;
		gaOptions.EliteCount        = 3500;
		gaOptions.Generations       = 20;
		
		[topIndividual pop popFitVals] = gaGnuOct(@(bits)fitGrid(slice, bits), 16, gaOptions);
		populations(:, :, sliceNumber) = pop;
		fitValues(:, sliceNumber)      = popFitVals;
		
		%[rowSize, colSize] = size(slice);
		%yPos = bits2bytes(topLines(pop, popFitVals));
		
		%yPos(find(yPos <= 0)) = 1;
		%yPos(find(yPos > rowSize)) = rowSize;
		
		%diff = abs(yPos(:,1) - yPos(:,2));
		%mediana = median(diff);
		%yFiltered = yPos(find(diff <= mediana * 1.25), :);
		
		%xPos = [ones(size(yFiltered)(1),1), repmat(colSize, size(yFiltered)(1),1)];
		%drawLine(slice, yFiltered, xPos);
		%figure;
	end
	
	#imshow(picture);
	xPos      = [];
	yFiltered = [];
	
	for sliceI = 1:sliceNumber
		pop        = populations(:, :, sliceI);
		popFitVals = fitValues(:, sliceI);
		
		yPos = bits2bytes(topLines(pop, popFitVals));
		
		slicePos = (sliceI - 1) * 254;
		yPos = yPos .+ slicePos;
		
		yPos(find(yPos <= 0)) = 1;
		yPos(find(yPos > numRows)) = numRows;
		
		diff = abs(yPos(:,1) - yPos(:,2));
		mediana = median(diff);
		#media = mean(diff);
		#diffMetric = mediana + media;
		
		#yFiltered = yPos(find(diff) <= diffMetric, :);
		yFiltered = [ yFiltered; yPos(find(diff <= mediana * 1), :) ];
		
		xPos = [ xPos; [ones(size(yFiltered)(1),1), repmat(numCols, size(yFiltered)(1),1)] ];
	end
	figure;
	[idx picture] = drawLine(picture, yFiltered, xPos);
	r = picture;

