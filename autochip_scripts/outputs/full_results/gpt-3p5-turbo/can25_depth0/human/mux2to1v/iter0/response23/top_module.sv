module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);
	
	// Create the 2-1 multiplexer
	assign out = sel ? b : a;
	
endmodule
