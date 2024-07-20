module top_module (
  input [3:0] in,
  output out_and,
  output out_or,
  output out_xor
);

  wire [3:0] in;

  and gate_and1(out_and,in);
  or gate_or1(out_or,in);
  xor gate_xor1(out_xor,in);

endmodule
module and(
  output out,
  input [3:0] in
);
  assign out = in[0] & in[1] & in[2] & in[3];
endmodule
module or(
  output out,
  input [3:0] in
);
  assign out = in[0] | in[1] | in[2] | in[3];
endmodule
module xor(
  output out,
  input [3:0] in
);
  assign out = in[0] ^ in[1] ^ in[2] ^ in[3];
endmodule
