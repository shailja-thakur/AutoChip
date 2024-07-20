module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Wire declarations
	wire [98:0] both_temp;
	wire [99:1] any_temp;
	wire [99:0] different_temp;

	// Logic for out_both
	assign both_temp[0] = in[0] & in[99];
	assign out_both = {both_temp[98:0], in[98] & in[99]};
	
	// Logic for out_any
	assign any_temp[99] = in[99] | in[98];
	assign out_any = {in[98:0] | any_temp[99:1]};
	
	// Logic for out_different
	assign different_temp[0] = in[0] ^ in[99];
	assign out_different = {different_temp[98:0], in[98] ^ in[99]};
			
endmodule
