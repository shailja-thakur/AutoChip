module top_module (
  input clk,
  input in,
  output logic out
);

  logic d;

  xor xor_gate(d, out, in);  // XOR gate

  always_ff@(posedge clk)
    out <= d;

endmodule
