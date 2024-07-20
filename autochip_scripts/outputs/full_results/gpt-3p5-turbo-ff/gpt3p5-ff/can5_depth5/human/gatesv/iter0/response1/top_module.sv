module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// internal wires for storing intermediate values
	wire [3:1] temp_both;
	wire [3:1] temp_any;
	wire [3:0] temp_different;

	// calculate out_both
	assign temp_both[0] = in[0] & in[3];
	assign temp_both[1] = in[1] & in[0];
	assign temp_both[2] = in[2] & in[1];

	// calculate out_any
	assign temp_any[0] = in[1] | in[0];
	assign temp_any[1] = in[2] | in[1];
	assign temp_any[2] = in[3] | in[2];

	// calculate out_different
	assign temp_different[0] = in[0] ^ in[3];
	assign temp_different[1] = in[1] ^ in[0];
	assign temp_different[2] = in[2] ^ in[1];
	assign temp_different[3] = in[3] ^ in[2];

	// assign outputs
	assign out_both = temp_both[2:0];
	assign out_any = temp_any[3:1];
	assign out_different = temp_different;

endmodule
