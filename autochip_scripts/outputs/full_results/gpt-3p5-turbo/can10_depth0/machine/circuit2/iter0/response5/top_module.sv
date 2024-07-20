module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

  wire [3:0] xor_result;
  wire q_invert;

  assign xor_result = a ^ b ^ c ^ d;
  assign q_invert = ~xor_result;
  assign q = q_invert;

endmodule
