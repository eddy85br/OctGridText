function out = fitGridXY(picture, bits)
	[rowSize, colSize] = size(picture);              %# Get the image size
	yPos = bits2bytes(bits);
	if yPos(1) <= 0
		yPos(1) = 1;
	endif
	if yPos(2) <= 0
		yPos(2) = 1;
	endif
	if yPos(1) > rowSize
		yPos(1) = rowSize;
	endif
	if yPos(2) > rowSize
		yPos(2) = rowSize;
	endif
	indexes = drawLineXY(picture, 1, yPos(1), colSize, yPos(2), 0);	%% indexes = drawLineXY(picture, x1, y1, x2, y2, color)
	rowLine = picture(indexes);
	out = sum(rowLine) * -1;

