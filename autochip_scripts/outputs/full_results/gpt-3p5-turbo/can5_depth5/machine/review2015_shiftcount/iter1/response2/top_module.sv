module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] q_next; // New variable to hold next value of q

  always @(posedge clk) begin
    if (shift_ena)
      q_next <= data;
    else if (count_ena)
      q_next <= q - 1;
    else
      q_next <= q; // Keep the current value of q if no enable signals are high
      
    q <= q_next; // Assign next value of q to q
  end
endmodule
