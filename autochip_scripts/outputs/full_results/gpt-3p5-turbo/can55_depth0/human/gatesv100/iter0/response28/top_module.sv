module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Declare intermediate signals for each output
	wire [98:0] both_temp;
	wire [99:1] any_temp;
	wire [99:0] different_temp;
	
	// Logic for out_both
	assign both_temp[0] = in[0] & in[99];
	assign both_temp[1:98] = in[1:98] & in[0:97];
	assign out_both = both_temp;
	
	// Logic for out_any
	assign any_temp[99] = in[99] | in[0];
	assign any_temp[0:98] = in[0:98] | in[1:99];
	assign out_any = any_temp;
	
	// Logic for out_different
	assign different_temp[0] = (in[99] != in[0]);
	assign different_temp[1:99] = (in[1:99] != in[0:98]);
	assign out_different = different_temp;

endmodule
