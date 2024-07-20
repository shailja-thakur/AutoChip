module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Define the taps
	parameter TAP1 = 32;
	parameter TAP2 = 22;
	parameter TAP3 = 2;
	parameter TAP4 = 1;

	// Define internal signals
	reg [31:0] state;

	// Clock edge detection
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 32'b1;
		else begin
			// XOR the taps with the current state value
			state[TAP1] <= state[TAP1] ^ state[0];
			state[TAP2] <= state[TAP2] ^ state[0];
			state[TAP3] <= state[TAP3] ^ state[0];
			state[TAP4] <= state[TAP4] ^ state[0];

			// Shift the state
			state <= {state[30:0], state[31]};
		end
	end

	// Assign the output
	assign q = state;

endmodule
