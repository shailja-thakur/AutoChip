module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declare intermediate wire variables
	wire [98:0] both_temp;
	wire [99:1] any_temp;
	wire [99:0] different_temp;

	// Logic for out_both
	assign both_temp = in[98:0] & in[99:1];
	assign out_both = {both_temp, 1'b0};

	// Logic for out_any
	assign any_temp = in[1:99] | in[0];
	assign out_any = {1'b0, any_temp};

	// Logic for out_different
	assign different_temp = in[99] ^ in[98:0];
	assign out_different = {in[99] ^ in[0], different_temp};

endmodule
