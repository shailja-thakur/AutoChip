module top_module(
  input x,
  input y,
  output z);

  wire xor_output;
  wire and_output;

  xor_gate xor_1(x, y, xor_output);
  and_gate and_1(xor_output, x, and_output);

  assign z = and_output;

endmodule
module xor_gate(
  input a,
  input b,
  output c);

  assign c = a ^ b;

endmodule
module and_gate(
  input a,
  input b,
  output c);

  assign c = a & b;

endmodule
