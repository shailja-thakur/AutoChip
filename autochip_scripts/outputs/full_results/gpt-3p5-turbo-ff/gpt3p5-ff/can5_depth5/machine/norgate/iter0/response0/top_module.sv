module top_module(
	input a, 
	input b,
	output out
);
	// Logic for the top module
	assign out = ~ (a | b);
endmodule
