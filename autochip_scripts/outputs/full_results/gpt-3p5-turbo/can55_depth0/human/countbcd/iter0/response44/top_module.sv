module top_module(
	input clk,
	input reset,
	output [3:1] ena,
	output reg [15:0] q);
  
  always @(posedge clk or posedge reset) begin
    if (reset)
      q <= 0;
    else begin
      q <= q + 1;
      if (q[3:1] == 7)
        q[3:1] <= 0;
    end
  end
  
  assign ena = (q[3:1] == 7);
  
endmodule
