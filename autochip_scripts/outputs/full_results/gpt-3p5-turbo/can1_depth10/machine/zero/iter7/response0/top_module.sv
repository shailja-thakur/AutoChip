module top_module(
  output reg zero);

  // Removed @* and used @posedge clk instead
  always @(posedge clk)
    zero <= 0;
  
endmodule
