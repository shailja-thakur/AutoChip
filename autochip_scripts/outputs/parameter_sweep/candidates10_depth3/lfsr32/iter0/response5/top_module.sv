module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Registers for the LFSR
	reg [31:0] state;
	reg [31:0] tap_positions;
	reg [31:0] feedback;

	// Assign the taps positions
	// Bit 32 - 1'b1
	// Bit 22 - 1'b1
	// Bit 2  - 1'b1
	// Bit 1  - 1'b1
	assign tap_positions = 32'b0100_0000_0000_0000_0000_0000_0000_0001;

	// Combintional logic for generating feedback value
	always @(*) begin
		feedback = state & tap_positions;
	end

	// Sequential logic for the LFSR
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 32'h1; // Reset to 32'h1 when reset is active high
		end else begin
			state <= state >> 1; // Shift the state to the right
			state[0] <= feedback ^ state[0]; // Calculate the new bit based on feedback
		end
	end

	// Output assignment
	assign q = state;
	
endmodule
