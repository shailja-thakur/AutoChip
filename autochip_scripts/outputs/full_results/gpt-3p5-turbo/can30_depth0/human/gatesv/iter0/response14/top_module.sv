module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	// Declare internal signals
	wire [2:0] both_check;
	wire [3:1] any_check;
	wire [3:0] different_check;
	
	// Logic to check for both
	assign both_check[2] = (in[2] & in[3]);
	assign both_check[1] = (in[1] & in[2]);
	assign both_check[0] = (in[0] & in[1]);
	
	// Logic to check for any
	assign any_check[3] = (in[3] | in[0]);
	assign any_check[2] = (in[2] | in[3]);
	assign any_check[1] = (in[1] | in[2]);
	
	// Logic to check for different
	assign different_check[3] = (in[3] != in[0]);
	assign different_check[2] = (in[2] != in[3]);
	assign different_check[1] = (in[1] != in[2]);
	assign different_check[0] = (in[0] != in[1]);

	// Assign outputs
	assign out_both = both_check;
	assign out_any = any_check;
	assign out_different = different_check;
	
endmodule
