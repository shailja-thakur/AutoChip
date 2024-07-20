module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
	// wire declarations for intermediate signals
	wire [2:0] left_shifted_in;
	wire [2:0] right_shifted_in;

	// assign signals for left and right shifted inputs
	assign left_shifted_in = {in[2:0], in[3]};
	assign right_shifted_in = {in[0], in[3:1]};

	// assign out_both
	assign out_both[2] = (in[2] & in[3]);
	assign out_both[1] = (in[1] & in[2]);
	assign out_both[0] = (in[0] & in[1]);

	// assign out_any
	assign out_any[3] = (in[3] | in[0]);
	assign out_any[2] = (in[2] | in[1]);
	assign out_any[1] = (in[1] | in[0]);

	// assign out_different
	assign out_different[3] = (in[3] ^ in[0]);
	assign out_different[2] = (in[2] ^ in[1]);
	assign out_different[1] = (in[1] ^ in[0]);

endmodule
