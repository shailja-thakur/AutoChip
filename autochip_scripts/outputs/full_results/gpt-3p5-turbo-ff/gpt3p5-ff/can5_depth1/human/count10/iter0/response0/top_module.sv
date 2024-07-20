module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

  // Declare internal signal
  reg [3:0] count;

  // Synchronous reset
  always @(posedge clk or posedge reset)
  begin
    if (reset)
      count <= 4'b0000;
    else if (count == 4'b1001)
      count <= 4'b0000;
    else
      count <= count + 1;
  end

  // Output assignment
  assign q = count;

endmodule
