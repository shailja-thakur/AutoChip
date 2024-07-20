module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Internal wires
	wire [3:1] in_right;
	wire [3:0] in_left;
	
	// Connect in to in_right and in_left
	assign in_right = {in[2:0], 1'b0};
	assign in_left = {in[3], in[2:0]};
	
	// Logic for out_both
	assign out_both[0] = in[0] && in_left[0];
	assign out_both[1] = in[1] && in_left[1];
	assign out_both[2] = in[2] && in_left[2];
	
	// Logic for out_any
	assign out_any[1] = in[1] || in_right[1];
	assign out_any[2] = in[2] || in_right[2];
	assign out_any[3] = in[3] || in_right[3];
	
	// Logic for out_different
	assign out_different[0] = in[0] ^ in_left[0];
	assign out_different[1] = in[1] ^ in_left[1];
	assign out_different[2] = in[2] ^ in_left[2];
	assign out_different[3] = in[3] ^ in_left[3];
	
endmodule
