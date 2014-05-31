function out = fitGrid(picture, bits)
	%% display("Inside fitGrid:");
	%% display("bits:");
	% display(bits);
	[rowSize, colSize] = size(picture);              %# Get the image size
	yPos = bits2bytes(bits);
	if (yPos(1) <= 0)
		% display("yPos(1) < 0:");
		% display(yPos);
		yPos(1) = 1;
		% display(yPos);
	endif
	if (yPos(2) <= 0)
		% display("yPos(2) < 0:");
		% display(yPos);
		yPos(2) = 1;
		% display(yPos);
	endif
	if (yPos(1) > rowSize)
		display("yPos(1) > rowSize:");
		display(yPos);
		yPos(1) = rowSize;
		display(yPos);
	endif
	if (yPos(2) > rowSize)
		display("yPos(2) > rowSize:");
		display(yPos);
		yPos(2) = rowSize;
		display(yPos);
	endif
	% display("yPos:");
	% display(yPos);
	indexes = getLine(picture, [yPos(1) 1], [yPos(2) colSize]);	%% indexes = getLine(picture, p1, p2)
	% display("'indexes' size, min and max:");
	% display(size(indexes));
	% display(["   min: " num2str(min(indexes))]);
	% display(["   max: " num2str(max(indexes))]);
	rowLine = picture(indexes);
	% display("'rowLine' size:");
	% display(size(rowLine));
	out = sum(rowLine) * -1;

