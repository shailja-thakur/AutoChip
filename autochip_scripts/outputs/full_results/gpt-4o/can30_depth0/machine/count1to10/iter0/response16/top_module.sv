module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Always block triggered on the rising edge of the clock or the reset signal
	always @(posedge clk or posedge reset) begin
		// If the reset signal is active, set q to 1
		if (reset) begin
			q <= 4'b0001;
		end else begin
			// If q reaches 10, reset it to 1, otherwise increment it by 1
			if (q == 4'b1010) begin
				q <= 4'b0001;
			end else begin
				q <= q + 1;
			end
		end
	end
endmodule
