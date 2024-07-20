module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);
  
  initial
  begin
    q = 8'h0; // Set the output to a default value of 8'h0
  end
  
  always @(posedge clk) // Triggered on the rising edge of the clock input
  begin
    q <= d; // Store the data input in the register
  end

endmodule
