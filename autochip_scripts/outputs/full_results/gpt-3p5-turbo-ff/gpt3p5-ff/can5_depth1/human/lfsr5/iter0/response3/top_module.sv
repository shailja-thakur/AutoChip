module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Internal register for the LFSR
	reg [4:0] lfsr;

	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr <= 5'b1; // Reset to 1
		else begin
			// Calculate the next state of the LFSR
			lfsr[0] <= lfsr[4] ^ lfsr[2]; // Feedback XOR
			lfsr[1:4] <= lfsr[0:3]; // Shift operation
		end
	end

	assign q = lfsr;

endmodule
