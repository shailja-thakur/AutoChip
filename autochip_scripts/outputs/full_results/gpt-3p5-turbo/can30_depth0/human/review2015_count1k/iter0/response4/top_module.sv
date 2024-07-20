module top_module(
	input clk,
	input reset,
	output reg [9:0] q );

	always @(posedge clk or posedge reset) //added posedge reset
	begin
		if (reset) //added reset
			q <= 0;
		else if (q == 999) // changed 1000 to 999
			q <= 0;
		else
			q <= q + 1;
	end

endmodule
