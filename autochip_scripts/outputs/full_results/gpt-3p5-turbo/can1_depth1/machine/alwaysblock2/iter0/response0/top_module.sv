module top_module (
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

  assign out_assign = a ^ b;  // logical xor operation
  always @* begin
    out_always_comb = out_assign;  // assign out_assign to out_always_comb
  end

  always @(posedge clk) begin
    out_always_ff <= out_assign;  // assign out_assign to out_always_ff on rising edge of clk
  end

endmodule
