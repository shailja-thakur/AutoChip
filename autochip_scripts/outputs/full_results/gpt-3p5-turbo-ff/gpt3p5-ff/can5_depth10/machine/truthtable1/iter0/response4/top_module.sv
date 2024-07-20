module top_module (
	input x3,
	input x2,
	input x1,
	output f
);

// Define four intermediate signals based on the given conditions

wire cond1 = ~x3 & x2 & ~x1;
wire cond2 = ~x3 & x2 & x1;
wire cond3 = x3 & ~x2 & x1;
wire cond4 = x3 & x2 & x1;

// Use logical OR operation to determine the output signal f

assign f = cond1 | cond2 | cond3 | cond4;

endmodule
