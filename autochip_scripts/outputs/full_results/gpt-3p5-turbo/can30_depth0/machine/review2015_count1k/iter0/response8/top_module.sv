module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	// Define a wire to hold the next value of q
	wire [9:0] next_q;

	// Always block triggered on positive edge of clk
	always @(posedge clk) begin
		if (reset == 1) begin
			q <= 0;
		end else begin
			// Assign the next value of q based on its current value
			if (q == 999) begin
				next_q <= 0;
			end else begin
				next_q <= q + 1;
			end
			q <= next_q;
		end
	end
endmodule
