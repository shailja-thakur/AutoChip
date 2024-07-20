module top_module (
	input [7:0] in,
	output parity
);

  wire [7:0] xor_result;
  
  xor_gate_1to8 U1 (
    .in1(in[0]),
    .in2(in[1]),
    .in3(in[2]),
    .in4(in[3]),
    .in5(in[4]),
    .in6(in[5]),
    .in7(in[6]),
    .in8(in[7]),
    .out(xor_result)
  );
  
  assign parity = xor_result[0];
  
endmodule
module xor_gate_1to8 (
  input in1,
  input in2,
  input in3,
  input in4,
  input in5,
  input in6,
  input in7,
  input in8,
  output out
);

  assign out = in1 ^ in2 ^ in3 ^ in4 ^ in5 ^ in6 ^ in7 ^ in8;
  
endmodule
