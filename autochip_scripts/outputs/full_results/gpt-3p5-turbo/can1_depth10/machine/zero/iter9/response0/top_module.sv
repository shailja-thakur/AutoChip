module top_module(
  input wire clk,
  output reg zero);

  always @(posedge clk)
    zero <= 0;
  
endmodule
