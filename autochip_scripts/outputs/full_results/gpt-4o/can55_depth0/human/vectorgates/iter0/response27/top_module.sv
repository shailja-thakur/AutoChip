module top_module(
	input [2:0] a,
	input [2:0] b,
	output [2:0] out_or_bitwise,
	output out_or_logical,
	output [5:0] out_not
);

    // Compute bitwise OR of a and b
	assign out_or_bitwise = a | b;
	
    // Compute logical OR of a and b
	assign out_or_logical = |(a | b);
	
	// Place the inverse of b in the upper half of out_not (bits [5:3])
	// Place the inverse of a in the lower half of out_not (bits [2:0])
	assign out_not = { ~b, ~a };

endmodule
