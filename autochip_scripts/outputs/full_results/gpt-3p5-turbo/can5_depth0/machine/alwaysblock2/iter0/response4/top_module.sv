module top_module(
  input clk,
  input a,
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);
  
  // Assign the result of the logical XOR operation to out_assign
  assign out_assign = a ^ b;
  
  // Assign the same value as out_assign to out_always_comb using an always block
  always @*
    out_always_comb = out_assign;
  
  // Assign the same value as out_assign to out_always_ff using an always block triggered on the rising edge of clk
  always @(posedge clk)
    out_always_ff = out_assign;
    
endmodule
