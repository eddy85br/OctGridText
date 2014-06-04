function out = fitGrid(picture, bits)
	[rowSize, colSize] = size(picture);              %# Get the image size
	yPos = bits2bytes(bits);
	if (yPos(1) <= 0)
		yPos(1) = 1;
	endif
	if (yPos(2) <= 0)
		yPos(2) = 1;
	endif
	if (yPos(1) > rowSize)
		yPos(1) = rowSize;
	endif
	if (yPos(2) > rowSize)
		yPos(2) = rowSize;
	endif
	indexes = getLine(picture, [yPos(1) 1], [yPos(2) colSize]);	%% indexes = getLine(picture, p1, p2)
	rowLine = picture(indexes);
	out = sum(rowLine) * -1;

