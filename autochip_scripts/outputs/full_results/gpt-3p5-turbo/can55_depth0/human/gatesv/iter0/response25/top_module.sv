module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Wire declarations
	wire [3:0] in_shifted;
	wire [2:0] out_both_internal;

	// Assign the shifted input vector
	assign in_shifted = {in[2:0], in[3]};

	// Output both
	assign out_both_internal[2] = in[2] && in[3];
	assign out_both_internal[1] = in_shifted[1] && in_shifted[2];
	assign out_both_internal[0] = in_shifted[0] && in_shifted[1];

	// Output any
	assign out_any[3:1] = {in[2:0], in[3]} | {in[0], in[3:1]};
	
	// Output different
	assign out_different = {in[2] != in[3], in_shifted[1] != in_shifted[2], in_shifted[0] != in_shifted[1], in[0] != in[3]};
	
	// Assign the outputs
	assign out_both = out_both_internal;

endmodule
