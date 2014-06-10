function [pic indexes] = drawLine(picture, yPos, xPos)
	## Draw lines in picture based on a matrix of pairs of Y-axis positions of 2 points
	[rowCount, colCount, zCount] = size(picture);        # Get the image size
	maxLength = max([rowCount, colCount]);               # Get the maximum line length
	for rowN = 1:size(yPos)(1)
		rowPoints = linspace(yPos(rowN, 1), yPos(rowN, 2), maxLength);   # A set of row points for the line
		colPoints = linspace(xPos(rowN, 1), xPos(rowN, 2), maxLength);   # A set of column points for the line
		indexes(:, 1) = sub2ind([rowCount colCount], round(rowPoints), round(colPoints));  # Compute a linear index
		picture(indexes(:, 1)) = 0;                            # Set the line points to black
		for zN = 2:zCount
			indexes(:, zN) = indexes(:, 1) .+ (prod(size(picture)(1:2)) * (zN - 1));
			picture(indexes(:, zN)) = 0;
		end
	end
	imshow(picture);                                     # Display the image
	pic = picture;

