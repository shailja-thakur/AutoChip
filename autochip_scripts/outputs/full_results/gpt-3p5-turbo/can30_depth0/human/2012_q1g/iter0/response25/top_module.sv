module top_module (
	input [4:1] x,
	output logic f
);

// Karnaugh map equation for f
// f = x[1]'x[2]'x[3] + x[1]x[2] + x[3]'x[4]
assign f = ~x[1] & ~x[2] & ~x[3] | x[1] & x[2] | ~x[3] & ~x[4];

endmodule
