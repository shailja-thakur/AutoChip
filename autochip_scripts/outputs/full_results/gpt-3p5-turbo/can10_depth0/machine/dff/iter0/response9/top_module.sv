module top_module(
  input clk,
  input d,
  output reg q
);

  // Initialize q to 1'hx
  initial
    q = 1'bx;

  // Synchronize d with the rising edge of clk
  always @(posedge clk)
    q <= d;

endmodule
