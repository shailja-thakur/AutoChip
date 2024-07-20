module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	always @(posedge clk or posedge reset)
	begin
		if (reset) // When reset is high, counter should be reset to 0
			q <= 4'b0000;
		else // When reset is low, counter should increment by 1
			q <= q + 1;
	end

endmodule
