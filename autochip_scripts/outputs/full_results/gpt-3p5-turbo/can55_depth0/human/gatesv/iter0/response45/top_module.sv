module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Declare internal wire signal for intermediate calculations
	wire [3:0] shifted_in;
	
	// Shift the input vector to the left by one bit
	assign shifted_in = {in[2:0], in[3]};
	
	// Calculate out_both by ANDing each bit of input with its left neighbor
	assign out_both = {in[2] & shifted_in[2], in[1] & shifted_in[1], in[0] & shifted_in[0]};
	
	// Calculate out_any by ORing each bit of input with its right neighbor
	assign out_any = {in[1] | in[2], in[0] | in[1], in[3] | in[0]};
	
	// Calculate out_different by comparing each bit of input with its left neighbor
	assign out_different = {in[2] ^ shifted_in[2], in[1] ^ shifted_in[1], in[0] ^ shifted_in[0], in[3] ^ in[0]};
	
endmodule
