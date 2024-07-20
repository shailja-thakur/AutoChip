module top_module(
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

  // Perform XOR operation and assign to out_assign
  assign out_assign = a ^ b;

  // use always_comb block for out_always_comb
  always @(*) begin
    out_always_comb = out_assign;
  end

  // use always_ff block for out_always_ff
  always @(posedge clk) begin
    out_always_ff = out_assign;
  end

endmodule
