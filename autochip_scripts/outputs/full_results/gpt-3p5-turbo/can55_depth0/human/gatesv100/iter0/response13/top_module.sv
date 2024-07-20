module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Wire for out_both
	wire [98:0] both_intermediate;
	
	// Assigning values to out_both
	assign both_intermediate = in[98:0] & in[99:1];
	assign out_both = {1'b0, both_intermediate};
	
	// Wire for out_any
	wire [99:1] any_intermediate;
	
	// Assigning values to out_any
	assign any_intermediate = in[99:1] | in[98:0];
	assign out_any = {any_intermediate, 1'b0};
	
	// Wire for out_different
	wire [99:0] different_intermediate;
	
	// Assigning values to out_different
	assign different_intermediate = in[99:1] ^ in[98:0];
	assign out_different = {different_intermediate, in[99] ^ in[0]};
	
endmodule
