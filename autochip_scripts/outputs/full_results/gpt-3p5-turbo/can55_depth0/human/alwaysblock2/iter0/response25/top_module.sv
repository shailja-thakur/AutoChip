module top_module(
	input clk,
  input a, 
  input b,
  output out_assign,
  output reg out_always_comb,
  output reg out_always_ff
);

  // Assign statement implementation of XOR gate
  assign out_assign = a ^ b;
  
  // Combinational always block implementation of XOR gate
  always @*
    out_always_comb = a ^ b;
    
  // Clocked always block implementation of XOR gate
  always @(posedge clk)
    out_always_ff <= a ^ b;

endmodule
