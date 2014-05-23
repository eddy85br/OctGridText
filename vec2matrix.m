function M = vec2matrix(vect, rowLength)
	% Transform a vector 'vect' into a matrix of rows with size 'rowLength'
	if mod(length(vect), rowLength) == 0
		oneM = ones(rowLength, (length(vect) / rowLength));
		oneM(find(oneM)) = vect;
		M = oneM';
	else
		M = ['Impossible to divide a vector of size ' num2str(length(vect)) ' into ' num2str(length(vect) / rowLength) ' rows with ' num2str(rowLength) ' elements!'];
		%oneM = ones(rowLength, ceil(length(vect) / rowLength));
		%oneM(find(oneM)) = vect;
		%M = oneM';
	end

