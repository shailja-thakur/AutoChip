module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

assign f = ~x3 & ~x2 & ~x1  // 0 | 0 | 0
			| ~x3 & ~x2 & x1 // 0 | 0 | 1
			| ~x3 & x2 & ~x1 // 0 | 1 | 0
			| ~x3 & x2 & x1  // 0 | 1 | 1
			| x3 & ~x2 & ~x1 // 1 | 0 | 0
			| x3 & ~x2 & x1  // 1 | 0 | 1
			| x3 & x2 & ~x1  // 1 | 1 | 0
			| x3 & x2 & x1; // 1 | 1 | 1

endmodule
