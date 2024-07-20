module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Declare intermediate wires
	wire [3:0] in_shifted;
	wire [1:0] in_shifted_both;
	wire [2:0] in_shifted_any;
	wire [3:0] in_shifted_different;
	
	// Shift input vector to the right
	assign in_shifted = {in[2:0], in[3]};
	
	// Calculate out_both
	assign out_both = {in[2] & in_shifted[2], in[1] & in_shifted[1], in[0] & in_shifted[0]};
	
	// Calculate out_any
	assign in_shifted_both = {in[2] | in_shifted[2], in[1] | in_shifted[1]};
	assign in_shifted_any = {in_shifted_both[1] | in[0], in_shifted_both[0] | in_shifted[0]};
	assign out_any = {in_shifted_any[2], in_shifted_any[1], in_shifted_any[0]};
	
	// Calculate out_different
	assign in_shifted_different = {in[2] ^ in_shifted[2], in[1] ^ in_shifted[1], in[0] ^ in_shifted[0], in[3] ^ in[0]};
	assign out_different = in_shifted_different;

endmodule
