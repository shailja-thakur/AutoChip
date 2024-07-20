module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Output Declaration
	wire [2:0] temp_out_both;
	wire [2:0] temp_out_any;
	wire [3:0] temp_out_different;
	
	// Check if both input bit and the previous bit are '1'
	assign temp_out_both[2] = in[2] & in[3];
	assign temp_out_both[1] = in[1] & in[2];
	assign temp_out_both[0] = in[0] & in[1];
	
	// Check if any input bit or the previous bit are '1'
	assign temp_out_any[2] = in[2] | in[1];
	assign temp_out_any[1] = in[1] | in[0];
	assign temp_out_any[0] = in[0] | in[3];
	
	// Check if input bit is different from the previous bit (wrapping around)
	assign temp_out_different[3] = in[3] ^ in[0];
	assign temp_out_different[2] = in[2] ^ in[3];
	assign temp_out_different[1] = in[1] ^ in[2];
	assign temp_out_different[0] = in[0] ^ in[1];
	
	// Assigning outputs
	assign out_both = temp_out_both;
	assign out_any = temp_out_any;
	assign out_different = temp_out_different;

endmodule
