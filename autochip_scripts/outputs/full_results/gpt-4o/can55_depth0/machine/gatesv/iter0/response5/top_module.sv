module top_module (
	input [3:0] in,
	output [2:0] out_both,
	output [3:0] out_any,
	output [3:0] out_different
);

  // Bitwise AND operation on specified bits
  assign out_both = in[2:0] & in[3:1];
  
  // Bitwise OR operation on specified bits
  assign out_any = in[2:0] | in[3:1];

  // Bitwise XOR operation on specified bits
  assign out_different[3:1] = in[3:1] ^ in[2:0];
  assign out_different[0] = in[0];

endmodule
