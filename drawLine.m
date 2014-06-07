function [indexes pic] = drawLine(picture, yPos, xPos)
	## Draw lines in picture based on a matrix of pairs of Y-axis positions of 2 points
	[rowSize, colSize] = size(picture);                  # Get the image size
	maxLength = max([rowSize, colSize]);                 # Get the maximum line length
	for rowN = 1:size(yPos)(1)
		rowPoints = linspace(yPos(rowN, 1), yPos(rowN, 2), maxLength);   # A set of row points for the line
		colPoints = linspace(xPos(rowN, 1), xPos(rowN, 2), maxLength);   # A set of column points for the line
		indexes = sub2ind([rowSize colSize], round(rowPoints), round(colPoints));  # Compute a linear index
		picture(indexes) = 0;                            # Set the line points to black
	end
	imshow(picture);                                     # Display the image
	pic = picture;

