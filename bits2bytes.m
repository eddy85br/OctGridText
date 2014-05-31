function byteMatrix = bits2bytes(bitMatrix)
	% Converts a matrix of N bits per row into N/8 bytes per row
	byteMatrix = [];
	% Run the convertion for each matrix row
	for rowN = 1:size(bitMatrix)(1)
		% Converts a vector of bits into bytes
		powers = repmat(0:7, length(bitMatrix(rowN,:)) / 8, 1);
		bytes = 2 .^ powers;
		byteMatrix = [byteMatrix; sum(bytes .* vec2matrix(bitMatrix(rowN,:), 8), 2)'];
	end

