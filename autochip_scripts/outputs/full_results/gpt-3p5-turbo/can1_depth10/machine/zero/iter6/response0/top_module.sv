module top_module(
  output reg zero);

  // Sensitivity list added to always block
  always @*
    zero <= 0;
  
endmodule
