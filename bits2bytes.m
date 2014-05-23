function byteMatrix = bits2bytes(bits)
	% Converts a matrix of bits into bytes
	powers = repmat(0:7, length(bits) / 8, 1);
	bytes = 2 .^ powers;
	byteMatrix = sum(bytes .* vec2matrix(bits, 8), 2);

