module top_module (
	input in1,
	input in2,
	input in3,
	output wire out
);

  wire xnor_out;
  wire xor_out;

  assign xnor_out = ~(in1 ^ in2);
  assign xor_out = xnor_out ^ in3;

  assign out = xor_out;

endmodule
