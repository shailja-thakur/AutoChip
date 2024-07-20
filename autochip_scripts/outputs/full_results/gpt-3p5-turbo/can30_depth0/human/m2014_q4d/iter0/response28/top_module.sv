module top_module (
  input clk,
  input in,
  output logic out
);

  logic xor_output;
  logic d_input;

  xor_gate xor1(
    .a(in),
    .b(out),
    .z(xor_output)
  );  

  d_ff flip_flop(
    .clk(clk),
    .d(xor_output),
    .q(out)
  );

endmodule
module xor_gate (
  input a,
  input b,
  output z
);
  assign z = a ^ b;
endmodule
module d_ff (
  input clk,
  input d,
  output logic q
);
  always @(posedge clk)
    q <= d;
endmodule
