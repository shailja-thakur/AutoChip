module top_module (
	input [7:0] in,
	output [7:0] out
);

	// Declare wire for each bit of the output
	wire out_bit[7:0];

	// Reverse the bit ordering
	assign out_bit[0] = in[7];
	assign out_bit[1] = in[6];
	assign out_bit[2] = in[5];
	assign out_bit[3] = in[4];
	assign out_bit[4] = in[3];
	assign out_bit[5] = in[2];
	assign out_bit[6] = in[1];
	assign out_bit[7] = in[0];

	// Assign the output bits to the output signal
	assign out = {out_bit[7], out_bit[6], out_bit[5], out_bit[4], out_bit[3], out_bit[2], out_bit[1], out_bit[0]};

endmodule
