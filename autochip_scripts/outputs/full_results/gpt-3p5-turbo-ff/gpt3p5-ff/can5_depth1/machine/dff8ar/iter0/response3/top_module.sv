module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);
     
  always @(posedge clk or posedge areset) // Sensitivity list should include both clk and areset
    if (areset) // Use areset directly, no need for comparison with 1
      q <= 8'd0; // Use 8'd0 instead of 0 to make it explicit that it's an 8-bit value
    else
      q <= d; // Assign the d input to the q output

endmodule
