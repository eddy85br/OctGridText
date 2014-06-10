function [distVector m middle] = distVec(yPos)
	## Calculate distance vector between Y positions of points, mode and interline middle.
	uSorted = unique(sort(yPos), "rows");
	[rowCount, colCount] = size(uSorted);
	
	minimumSize = 5;
	prevDist    = 0;
	lineCount   = 0;
	lineSizes   = [];
	distVector  = [];
	
	for rowN = 1:(rowCount - 1)
		lineCount++;
		distance = abs(uSorted(rowN, 1) - uSorted(rowN + 1, 1));
		distVector = [distVector distance];
		if (abs(prevDist - distance) > minimumSize)
			lineSizes = [lineSizes lineCount];
			lineCount = 0;
			prevDist  = 0;
		else
			prevDist = distance;
		endif
	end
	m = mode(distVector(find(distVector > minimumSize)));
	middle = round(mean(lineSizes) / 2);

