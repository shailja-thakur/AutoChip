module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);
	assign {o2, o1, o0} = vec; // Connect individual bits to outputs
	assign outv = vec; // Connect input vector to output vector
endmodule
