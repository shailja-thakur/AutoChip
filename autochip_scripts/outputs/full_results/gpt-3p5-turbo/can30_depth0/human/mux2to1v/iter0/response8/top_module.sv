module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);

// Create a 2-1 multiplexer using a conditional statement
assign out = (sel == 1'b0) ? a : b;

endmodule
