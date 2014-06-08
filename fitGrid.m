function out = fitGrid(picture, bits)
	[rowCount, colCount] = size(picture);              %# Get the image size
	yPos = bits2bytes(bits);
	out = 1;
	if (yPos(1) <= 0)
		yPos(1) = 1;
		out += 500;
	endif
	if (yPos(2) <= 0)
		yPos(2) = 1;
		out += 500;
	endif
	if (yPos(1) > rowCount)
		yPos(1) = rowCount;
		out += 500;
	endif
	if (yPos(2) > rowCount)
		yPos(2) = rowCount;
		out += 500;
	endif
	indexes = getLine(picture, [yPos(1) 1], [yPos(2) colCount]);	%% indexes = getLine(picture, p1, p2)
	rowLine = picture(indexes);
	out += sum(rowLine) * -1;

