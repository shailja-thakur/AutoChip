module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Declare intermediate signals
	wire [2:0] in_right; // Input bit and its neighbour to the right
	wire [2:0] in_left; // Input bit and its neighbour to the left
	
	// Generate the input bit and its neighbour to the right
	assign in_right[2] = in[3];
	assign in_right[1:0] = in[2:1];
	
	// Generate the input bit and its neighbour to the left
	assign in_left[0] = in[3];
	assign in_left[2:1] = in[2:1];
	
	// Generate out_both
	assign out_both[2] = in[2] && in_left[2];
	assign out_both[1] = in[1] && in_left[1];
	assign out_both[0] = in[0] && in_left[0];
	
	// Generate out_any
	assign out_any[3] = in[2] || in_right[2];
	assign out_any[2] = in[1] || in_right[1];
	assign out_any[1] = in[0] || in_right[0];
	
	// Generate out_different
	assign out_different[3] = in[3] ^ in_left[0];
	assign out_different[2] = in[2] ^ in_left[2];
	assign out_different[1] = in[1] ^ in_left[1];
	assign out_different[0] = in[0] ^ in_right[0];
	
endmodule
