module top_module (
  input clk,
  input in,
  output logic out
);

  logic prev_out; // previous output signal

  always_ff @(posedge clk) // triggered on positive edge of clk
    prev_out <= out;

  always_comb // combinatorial logic
    out = in ^ prev_out; // XOR of input and previous output

endmodule
