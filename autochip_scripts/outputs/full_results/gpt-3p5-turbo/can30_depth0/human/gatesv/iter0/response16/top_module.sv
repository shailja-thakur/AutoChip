module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);
	// Declare intermediate wire variables
	wire [2:0] both_int;
	wire [2:0] any_int;

	// Determine if both the bit and its neighbor to the left are 1
	assign both_int[0] = in[0] & in[3];
	assign both_int[1] = in[1] & in[0];
	assign both_int[2] = in[2] & in[1];

	// Determine if any of the bit and its neighbor to the right are 1
	assign any_int[0] = in[1] | in[2];
	assign any_int[1] = in[2] | in[3];
	assign any_int[2] = in[3] | in[0];

	// Assign outputs
	assign out_both = both_int;
	assign out_any = {1'b0, any_int};
	assign out_different = {in[3], in[2] ^ in[3], in[1] ^ in[2], in[0] ^ in[3]};
endmodule
