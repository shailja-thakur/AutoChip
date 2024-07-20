module top_module(
  input clk,
  input a,
  input b,
  output out_assign,
  output out_always_comb,
  output reg out_always_ff
);

  // Assign the out_assign port with the logical XOR operation of a and b
  assign out_assign = a ^ b;

  always @* begin
    // Assign the out_always_comb port with the same value as the out_assign port
    out_always_comb = out_assign;
  end

  always @(posedge clk) begin
    // Assign the out_always_ff port with the same value as the out_assign port
    out_always_ff <= out_assign;
  end

endmodule
