module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Intermediate wires for calculating the output signals
	wire [98:0] both_temp; // Temporary wire for out_both
	wire [99:1] any_temp; // Temporary wire for out_any
	wire [99:0] different_temp; // Temporary wire for out_different

	// Generate out_both
	assign both_temp[98:0] = in[98:0] & in[99:1];
	assign out_both = {both_temp, 1'b0}; // Append a 0 to the output since we don't need out_both[99]

	// Generate out_any
	assign any_temp[99:1] = in[98:0] | in[99:1];
	assign out_any = {1'b0, any_temp}; // Prepend a 0 to the output since we don't need out_any[0]

	// Generate out_different
	assign different_temp[99:0] = in[99] ^ in[98:0];
	assign out_different = different_temp;

endmodule
