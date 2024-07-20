module top_module (
	input [99:0] a,
	input [99:0] b,
	input sel,
	output [99:0] out
);
	// Using a conditional operator to select between 'a' and 'b' based on 'sel' signal
	assign out = sel ? b : a;
endmodule
