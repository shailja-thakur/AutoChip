module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Wire declarations
	wire [98:0] both_temp;
	wire [99:0] any_temp;
	wire [99:0] different_temp;

	// Logic to compute out_both
	assign both_temp = in[98:0] & in[99:1];
	assign out_both = {both_temp, 1'b0};

	// Logic to compute out_any
	assign any_temp = in[99:1] | in[98:0];
	assign out_any = {1'b0, any_temp};

	// Logic to compute out_different
	assign different_temp = in[0] ^ in[99:1];
	assign out_different = {different_temp[99], different_temp[98:0]};

endmodule
