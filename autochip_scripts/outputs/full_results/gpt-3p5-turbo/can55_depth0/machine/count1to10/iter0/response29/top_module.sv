module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// internal signal declarations
	reg [3:0] counter;

	// flip-flop to store the previous value of reset signal
	reg prev_reset;

	always @(posedge clk) begin
		// store the previous value of reset
		prev_reset <= reset;

		// if reset signal is active, set output register to 1
		if (reset)
			q <= 1;

		else begin
			// if output register reaches 10, reset it to 1
			if (q == 4'b1010)
				q <= 1;

			else
				q <= q + 1;
		end
	end
endmodule
