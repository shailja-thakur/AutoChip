module top_module(
  output reg out);

  // Assign the output port to 0
  always @(posedge clk)
    out <= 1'b0;

endmodule
