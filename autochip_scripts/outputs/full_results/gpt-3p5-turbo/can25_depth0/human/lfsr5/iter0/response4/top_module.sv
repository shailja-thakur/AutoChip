module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define the LFSR's taps
	parameter TAP1 = 5;
	parameter TAP2 = 3;

	// Define the LFSR's state register
	reg [4:0] lfsr_state;

	// Output assignment
	assign q = lfsr_state[4];

	// Reset condition
	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr_state <= 5'b1;
		else begin
			// Generate the next state based on the taps
			lfsr_state[0] <= lfsr_state[TAP1] ^ lfsr_state[TAP2];
			lfsr_state[1] <= lfsr_state[0];
			lfsr_state[2] <= lfsr_state[1];
			lfsr_state[3] <= lfsr_state[2];
			lfsr_state[4] <= lfsr_state[3];
		end
	end

endmodule
