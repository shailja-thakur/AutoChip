module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
// Define the output f based on the input combinations
assign f = ~x2 & x1 | x2 & ~x1 | x2 & x1 & ~x3;
endmodule
