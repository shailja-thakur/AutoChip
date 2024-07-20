module top_module(
	input clk,
	input reset,
	output reg [3:0] q
);

	// Always block triggered on positive edge of clk
	always @(posedge clk)
	begin
		// If reset input is asserted or current value of q is equal to 9, then q is reset to 0
		if (reset || (q == 9))
			q <= 0;
		// Otherwise, q is incremented by 1
		else
			q <= q + 1;
	end

endmodule
