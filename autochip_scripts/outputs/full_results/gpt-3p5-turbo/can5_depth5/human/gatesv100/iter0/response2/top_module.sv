module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Internal wires to store intermediate values
	wire [98:0] both;
	wire [99:2] any;
	wire [99:0] different;

	// Logic to calculate both
	assign both[0] = in[0] & in[99];
	assign both[1:98] = in[1:98] & in[0:97];

	// Logic to calculate any
	assign any[2:99] = in[1:98] | in[0:97];

	// Logic to calculate different
	assign different[0:97] = in[0:97] ^ in[1:98];
	assign different[98] = in[98] ^ in[99];
	assign different[99] = in[99] ^ in[0];

	// Assigning outputs
	assign out_both = both;
	assign out_any = any;
	assign out_different = different;
	
endmodule
