module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
	// Declare internal wires for intermediate calculation
	wire [2:0] both_temp;
	wire [3:0] any_temp;
	wire [3:0] different_temp;
	
	// Calculate out_both
	assign both_temp[2] = in[2] & in[3];
	assign both_temp[1] = in[1] & in[2];
	assign both_temp[0] = in[0] & in[1];
	
	// Calculate out_any
	assign any_temp[3] = in[3] | in[2];
	assign any_temp[2] = in[2] | in[1];
	assign any_temp[1] = in[1] | in[0];
	assign any_temp[0] = in[0];
	
	// Calculate out_different
	assign different_temp[2] = in[2] ^ in[3];
	assign different_temp[1] = in[1] ^ in[2];
	assign different_temp[0] = in[0] ^ in[3];
	assign different_temp[3] = in[3] ^ in[2];
	
	// Assign outputs
	assign out_both = both_temp;
	assign out_any = any_temp;
	assign out_different = different_temp;
	
endmodule
