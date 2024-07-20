module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declare internal wires for computing the outputs
	wire [98:0] both_wire;
	wire [99:1] any_wire;
	wire [99:0] different_wire;

	// Compute out_both
	assign both_wire[98] = in[98] & in[99];
	assign both_wire[97:0] = in[97:0] & in[98:1];

	// Compute out_any
	assign any_wire[2:99] = in[1:98] | in[0:97];

	// Compute out_different
	assign different_wire[98] = in[98] ^ in[99];
	assign different_wire[97:0] = in[97:0] ^ in[98:0];

	// Assign outputs
	assign out_both = both_wire;
	assign out_any = any_wire;
	assign out_different = different_wire;

endmodule
