function indexes = getLine(picture, p1, p2)
	[rowCount, colCount] = size(picture);              %# Get the image size
	maxLength = max([rowCount, colCount]);             %# Get the maximum line length
	rowPoints = linspace(p1(1), p2(1), maxLength);   %# A set of row points for the line
	colPoints = linspace(p1(2), p2(2), maxLength);   %# A set of column points for the line
	indexes = sub2ind([rowCount colCount], round(rowPoints), round(colPoints));  %# Compute a linear index

