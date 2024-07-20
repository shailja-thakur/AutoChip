module top_module (
  input clk,
  input in,
  output logic out
);

  logic flip_flop_output;

  xor2 xor_gate (
    .a(in),
    .b(flip_flop_output),
    .out(out)
  );

  always_ff @(posedge clk)
    flip_flop_output <= xor_gate.out;

endmodule
