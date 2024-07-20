module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	assign f = (~x2 & x1) | (x3 & ~x1);

endmodule
