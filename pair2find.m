function indexes = pair2find(pairs, M)
	[rowsize colsize] = size(M);
	numpairs = size(pairs, 2);
	if ( (max(pairs(1, :)) > rowsize) || (max(pairs(2, :)) > colsize) )
		indexes = ['Invalid X and Y positions to the size of the matrix. Matrix row size: ' rowsize '. Matrix column size: ' colsize '. Greater index of row and column: ' max(pairs(1, :)) ' e ' max(pairs(2, :)) '.'];
	else
		for col = 1:size(pairs, 2)
			xpos = pairs(1, col);
			ypos = pairs(2, col);
			indexes(col) = ((xpos - 1) * colsize) + ypos;
		end
	end

