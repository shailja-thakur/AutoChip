module top_module(
  output reg out);  // Declare the output as a reg type

always @(*)  // Use combinational logic
  out = 1'b0;  // Assign the output to logic low

endmodule
