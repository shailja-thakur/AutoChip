module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
	// Output signal f is determined by the combination of the three input signals using a logical OR operation.
	assign f = ((~x3 & x2 & ~x1) | (~x3 & x2 & x1) | (x3 & ~x2 & x1) | (x3 & x2 & x1));
endmodule
