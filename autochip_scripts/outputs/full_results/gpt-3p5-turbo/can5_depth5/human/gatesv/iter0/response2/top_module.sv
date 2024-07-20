module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:1] out_any,
	output [3:0] out_different
);

	assign out_both[0] = in[0] & in[3];  // Check if in[0] and in[3] are both 1
	assign out_both[1] = in[1] & in[0];  // Check if in[1] and in[0] are both 1
	assign out_both[2] = in[2] & in[1];  // Check if in[2] and in[1] are both 1
	
	assign out_any[1] = in[1] | in[0];  // Check if either in[1] or in[0] is 1
	assign out_any[2] = in[2] | in[1];  // Check if either in[2] or in[1] is 1
	assign out_any[3] = in[3] | in[2];  // Check if either in[3] or in[2] is 1
	
	assign out_different[0] = in[0] ^ in[3];  // Check if in[0] is different from in[3]
	assign out_different[1] = in[1] ^ in[0];  // Check if in[1] is different from in[0]
	assign out_different[2] = in[2] ^ in[1];  // Check if in[2] is different from in[1]
	assign out_different[3] = in[3] ^ in[2];  // Check if in[3] is different from in[2]
	
endmodule
