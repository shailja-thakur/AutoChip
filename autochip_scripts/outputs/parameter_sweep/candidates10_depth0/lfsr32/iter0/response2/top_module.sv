module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Register to hold the current state of the LFSR
	reg [31:0] lfsr_reg;

	// Define the tap positions
	parameter [31:0] TAPS = 32'b1_0000_0000_0000_0000_0000_0000_0001_0001; // bit positions 32, 22, 2, and 1

	// Output assignment
	assign q = lfsr_reg;

	// Synchronous reset
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			lfsr_reg <= 32'h1; // Reset the LFSR to initial value
		else begin
			// Generate next state of LFSR
			lfsr_reg <= {lfsr_reg[30:0], lfsr_reg[31]} ^ (lfsr_reg & TAPS);
		end
	end

endmodule
