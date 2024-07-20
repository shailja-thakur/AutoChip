module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
	// Specify internal signals
	wire [3:0] shifted_in;

	// Shift the input vector to the right
	assign shifted_in = {in[2:0], in[3]};

	// Logic to compute out_both
	assign out_both[0] = in[0] & shifted_in[0];
	assign out_both[1] = in[1] & shifted_in[1];
	assign out_both[2] = in[2] & shifted_in[2];

	// Logic to compute out_any
	assign out_any[1] = in[1] | shifted_in[1];
	assign out_any[2] = in[2] | shifted_in[2];
	assign out_any[3] = in[3] | shifted_in[3];

	// Logic to compute out_different
	assign out_different[0] = in[0] ^ shifted_in[0];
	assign out_different[1] = in[1] ^ shifted_in[1];
	assign out_different[2] = in[2] ^ shifted_in[2];
	assign out_different[3] = in[3] ^ shifted_in[3];
endmodule
