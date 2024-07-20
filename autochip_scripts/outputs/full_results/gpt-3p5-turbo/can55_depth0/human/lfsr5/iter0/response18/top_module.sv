module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define internal signals
	reg [4:0] next_q;
	reg [4:0] feedback;

	// Define taps positions
	parameter TAP1 = 5;
	parameter TAP2 = 3;

	// Define the LFSR logic
	always @(posedge clk or posedge reset) begin
		if (reset == 1'b1) begin
			q <= 5'b1; // Active-high synchronous reset
		end else begin
			// Feedback calculation
			feedback[TAP1] <= q[TAP1];
			feedback[TAP2] <= q[TAP2];

			// Shift left and XOR feedback
			next_q[4] <= q[3];
			next_q[3] <= q[2];
			next_q[2] <= q[1];
			next_q[1] <= q[0];
			next_q[0] <= q[4] ^ feedback[TAP1] ^ feedback[TAP2];

			// Update q
			q <= next_q;
		end
	end

endmodule
