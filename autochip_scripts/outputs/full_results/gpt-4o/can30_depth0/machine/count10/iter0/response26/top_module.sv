module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Always block triggered on the positive edge of the clk signal
	always @(posedge clk or posedge reset) begin
		// If reset is asserted or q reaches 9, reset q to 0
		if (reset) begin
			q <= 0;
		end else if (q == 9) begin
			q <= 0;
		end else begin
			q <= q + 1;
		end
	end

endmodule
