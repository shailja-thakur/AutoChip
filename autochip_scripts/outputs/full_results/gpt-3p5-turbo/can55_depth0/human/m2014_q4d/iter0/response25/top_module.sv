module top_module (
  input clk,
  input in,
  output logic out
);

  logic xor_output;
  logic d_ff_input;

  xor u1 (.a(in), .b(out), .z(xor_output));
  d_ff_posedge_clk u2 (.clk(clk), .d(xor_output), .q(out));
endmodule
module xor (
  input logic a,
  input logic b,
  output logic z
);
  assign z = a ^ b;
endmodule
module d_ff_posedge_clk (
  input logic clk,
  input logic d,
  output logic q
);
  always @(posedge clk)
    q <= d;
endmodule
