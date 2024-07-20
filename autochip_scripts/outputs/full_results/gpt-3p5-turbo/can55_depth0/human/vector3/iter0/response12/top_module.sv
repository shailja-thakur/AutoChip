module top_module (
	input [4:0] a,
	input [4:0] b,
	input [4:0] c,
	input [4:0] d,
	input [4:0] e,
	input [4:0] f,
	output [7:0] w,
	output [7:0] x,
	output [7:0] y,
	output [7:0] z
);
	
	assign w = {a, b}; // Concatenate input vectors a and b
	assign x = {c, d}; // Concatenate input vectors c and d
	assign y = {e, f}; // Concatenate input vectors e and f
	assign z = {1'b1, 1'b1}; // Output two 1 bits in the LSB positions
	
endmodule
