module top_module (
	input a, 
	input b,
	input c,
	input d,
	output reg out
);

	// Define intermediate signals
	wire x1, x2;

	// Implement logic for x1
	assign x1 = (a & b & ~(c | d)) | (~a & ~b & (c | d)) | (~a & b & ~(c | d)) | (a & b & (c | d));

	// Implement logic for x2
	assign x2 = (~a & ~b & c) | (~a & ~b & ~c & ~d) | (~a & b & (d | c)) | (a & ~b & ~(c | d));

	// Implement logic for out
	always @* begin
		if (c == 0 && d == 0)
			out = 0;
		else if (c == 0 && d == 1)
			out = 1;
		else if (c == 1 && d == 0)
			out = 1;
		else if (c == 1 && d == 1)
			out = 1;
		else
			out = 0;
	end

endmodule
