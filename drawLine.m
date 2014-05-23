function indexes = drawLine(picture, p1, p2)
	[rowSize, colSize] = size(picture);              %# Get the image size
	maxLength = max([rowSize, colSize]);             %# Get the maximum line length
	rowPoints = linspace(p1(1), p2(1), maxLength);   %# A set of row points for the line
	colPoints = linspace(p1(2), p2(2), maxLength);   %# A set of column points for the line
	indexes = sub2ind([rowSize colSize], round(rowPoints), round(colPoints));  %# Compute a linear index
	picture(indexes) = 0;                            %# Set the line points to white
	imshow(picture);                                 %# Display the image

