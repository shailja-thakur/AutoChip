module top_module (
	input [99:0] in,
	output [98:0] out_both,
	output [99:1] out_any,
	output [99:0] out_different
);

	// Define intermediate wires
	wire [98:0] temp_both;
	wire [99:1] temp_any;
	
	// Check if both bits are '1'
	assign temp_both = in[98:0] & in[99:1];
	
	// Check if any bit is '1'
	assign temp_any = in[99:1] | in[98:0];
	
	// Check if bits are different
	assign out_different[98:0] = in[98:0] !== in[99:1];
	assign out_different[99] = in[99] !== in[0];
	
	// Assign outputs
	assign out_both = temp_both;
	assign out_any = temp_any;
	
endmodule
