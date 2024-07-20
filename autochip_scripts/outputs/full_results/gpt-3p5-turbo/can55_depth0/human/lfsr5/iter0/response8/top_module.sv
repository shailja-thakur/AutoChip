module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define internal signals
	reg [4:0] lfsr_reg;
	reg feedback;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr_reg <= 5'b1; // Reset to 1 when active-high synchronous reset is triggered
		else begin
			feedback = lfsr_reg[4] ^ lfsr_reg[2]; // XOR the bits at positions 5 and 3
			lfsr_reg <= {lfsr_reg[3:0], feedback}; // Shift the register and assign the feedback to the leftmost bit
		end
	end
	
	// Assign the output
	assign q = lfsr_reg;

endmodule
