module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

  always @(posedge clk) begin
    if (shift_ena)
      q <= data;
    else if (count_ena)
      q <= q - 1;
    else
      q <= q; // added this line to retain the current value of q when both enable signals are low
  end

endmodule
