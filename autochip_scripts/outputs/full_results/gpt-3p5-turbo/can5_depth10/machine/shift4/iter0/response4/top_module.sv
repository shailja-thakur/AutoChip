module top_module(
  input clk,
  input areset,
  input load,
  input ena,
  input [3:0] data,
  output reg [3:0] q);
  
  // Register
  always @(posedge clk or posedge areset)
  if (areset)
    q <= 4'b0000;   // Reset the register to 0
  else if (load)
    q <= data;      // Load data into register
  else if (ena)
    q <= q << 1;    // Shift the register left by 1 bit

endmodule
