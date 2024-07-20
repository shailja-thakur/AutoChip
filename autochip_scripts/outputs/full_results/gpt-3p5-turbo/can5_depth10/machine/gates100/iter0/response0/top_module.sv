module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

  wire out_and_temp;
  wire out_or_temp;
  wire out_xor_temp;

  assign out_and_temp = &in;
  assign out_or_temp = |in;
  assign out_xor_temp = ^in;

  assign out_and = out_and_temp;
  assign out_or = out_or_temp;
  assign out_xor = out_xor_temp;
  
endmodule
