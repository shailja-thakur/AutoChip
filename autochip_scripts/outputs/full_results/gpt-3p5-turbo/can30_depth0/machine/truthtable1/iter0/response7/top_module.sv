module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
	// Assign the output signal f using the logical OR operation
	assign f = (~x3 & x2 & ~x1) | (~x3 & x2 & x1) | (x3 & ~x2 & x1) | (x3 & x2 & x1);
endmodule
