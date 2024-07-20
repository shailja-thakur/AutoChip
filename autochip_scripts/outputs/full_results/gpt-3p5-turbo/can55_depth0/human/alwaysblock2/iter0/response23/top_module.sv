module top_module(
    input clk,
    input a, 
    input b,
    output out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);

  // Implementation using assign statement
  assign out_assign = a ^ b;
  
  // Implementation using combinational always block
  always @*
    out_always_comb = a ^ b;
    
  // Implementation using clocked always block
  always @(posedge clk)
    out_always_ff <= a ^ b;

endmodule
