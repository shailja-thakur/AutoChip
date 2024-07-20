module top_module (
	input a,
	input b,
	input sel,
	output out
);
	
	assign out = sel ? b : a;  // Use conditional operator to select between a and b based on sel

endmodule
