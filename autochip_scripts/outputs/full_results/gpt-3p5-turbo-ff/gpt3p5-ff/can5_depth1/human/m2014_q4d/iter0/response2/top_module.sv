module top_module (
  input clk,
  input in,
  output logic out
);

  logic xor_output;
  logic flop_output;

  xor_gate u1(
    .in1(in),
    .in2(out),
    .out(xor_output)
  );

  d_ff u2(
    .clk(clk),
    .d(xor_output),
    .q(flop_output)
  );

  assign out = flop_output;

endmodule
module xor_gate (
  input in1,
  input in2,
  output logic out
);
  assign out = in1 ^ in2;
endmodule
module d_ff (
  input clk,
  input d,
  output logic q
);
  
  always @(posedge clk)
    q <= d;

endmodule
