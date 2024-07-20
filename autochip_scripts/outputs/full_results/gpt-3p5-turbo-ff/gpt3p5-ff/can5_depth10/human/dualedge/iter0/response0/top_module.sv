module top_module(
	input clk,
	input d,
	output reg q);

  reg q_temp;
  always @(posedge clk)
    q_temp <= d;
  always @(negedge clk)
    q <= q_temp;

endmodule
