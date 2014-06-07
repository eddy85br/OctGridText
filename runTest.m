function [r tops populations fitvalues] = runTest(level)
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
		otherwise
			picture = level;
	end
	
	[numRows, numCols] = size(picture);                 # Get the image size
	sliceNumber = 0;
	for rowNumber = 1:255:numRows
		sliceNumber++;
		sliceSize = rowNumber + 254;
		if sliceSize > numRows
			sliceSize = numRows;
		endif
		slice = picture(rowNumber:sliceSize, :, 1);
		disp(['rowNumber: ' num2str(rowNumber) "\t\tsliceSize: " num2str(sliceSize)]);
		imshow(slice);
		figure;
		if ~ isbool(slice)
			m = median(median(slice));
			slice(find(slice > m * 1.1)) = 255;
			slice(find(slice < m * 0.9)) = 0;
			#slice(find(slice >  60)) = 255;
			#slice(find(slice <= 60)) = 0;
		endif
		
		## Setting variables "GA Options" to gaGnuOct
		gaOptions.InitialPopulation = [];
		gaOptions.MutationRate      = 0.5;
		gaOptions.PopulationSize    = 5000;
		gaOptions.EliteCount        = 2500;
		gaOptions.Generations       = 25;
		
		[topIndividual pop popFitVals] = gaGnuOct(@(bits)fitGrid(slice, bits), 16, gaOptions);
		tops(sliceNumber, :)           = topIndividual;
		populations(:, :, sliceNumber) = pop
		fitvalues(:, sliceNumber)      = popFitVals;
		
		%[rowSize, colSize] = size(slice);
		%yPos = bits2bytes(topLines(pop, popFitVals));
		
		%yPos(find(yPos <= 0)) = 1;
		%yPos(find(yPos > rowSize)) = rowSize;
		
		%diff = abs(yPos(:,1) - yPos(:,2));
		%mediana = median(diff);
		#media = mean(diff);
		#diffMetric = mediana + media;
		
		#yFiltered = yPos(find(diff) <= diffMetric, :);
		%yFiltered = yPos(find(diff <= mediana * 1.25), :);
		
		%xPos = [ones(size(yFiltered)(1),1), repmat(colSize, size(yFiltered)(1),1)];
		%drawLine(slice, yFiltered, xPos);
		%figure;
	end
	imshow(picture);
	figure;
	
	for sliceI = 1:sliceNumber
		pop        = populations(:, :, sliceNumber);
		popFitVals = fitvalues(:, sliceNumber);
		
		yPos = bits2bytes(topLines(pop, popFitVals));
		
		yPos(find(yPos <= 0)) = 1;
		yPos(find(yPos > numRows)) = numRows;
		
		diff = abs(yPos(:,1) - yPos(:,2));
		mediana = median(diff);
		#media = mean(diff);
		#diffMetric = mediana + media;
		
		#yFiltered = yPos(find(diff) <= diffMetric, :);
		yFiltered = yPos(find(diff <= mediana * 1.25), :);
		
		xPos = [ones(size(yFiltered)(1),1), repmat(numCols, size(yFiltered)(1),1)];
		drawLine(picture, yFiltered, xPos);
	end
	r = picture;

