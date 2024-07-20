module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

	// intermediate signals
	wire int1;
	wire int2;
	wire int3;
	wire int4;

	// logic gates to compute intermediate signals
	assign int1 = ~x3 & x2 & ~x1;
	assign int2 = ~x3 & x2 & x1;
	assign int3 = x3 & ~x2 & x1;
	assign int4 = x3 & x2 & x1;

	// final output
	assign f = int1 | int2 | int3 | int4;

endmodule
