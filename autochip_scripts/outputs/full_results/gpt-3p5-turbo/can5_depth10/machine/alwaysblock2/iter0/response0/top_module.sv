module top_module(
  input clk,
  input a,
  input b,
  output out_assign,
  output out_always_comb,
  output reg out_always_ff
);

  // Assigning out_assign port using an assign statement
  assign out_assign = a ^ b;

  // Assigning out_always_comb port using an always block triggered on a or b change
  always @(a or b)
    out_always_comb <= a ^ b;

  // Assigning out_always_ff port using an always block triggered on the rising edge of clk
  always @(posedge clk)
    out_always_ff <= a ^ b; 

endmodule
