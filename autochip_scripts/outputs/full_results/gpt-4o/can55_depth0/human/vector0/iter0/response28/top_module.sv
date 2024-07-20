module top_module(
	input [2:0] vec, 
	output [2:0] outv,
	output o2,
	output o1,
	output o0
);
	// Assign the entire vector to outv
	assign outv = vec;
	
	// Assign individual bits of the vector to separate outputs
	assign o0 = vec[0];
	assign o1 = vec[1];
	assign o2 = vec[2];
endmodule
