module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Declaration of internal signals
	reg [4:0] lfsr;
	reg [0:0] feedback;

	// Reset condition
	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr <= 5'b1;
		else
			lfsr <= {lfsr[3] ^ lfsr[2], lfsr[4:1]};
	end

	// Feedback calculation
	always @(lfsr[4] or lfsr[2]) begin
		feedback[0] <= lfsr[4] ^ lfsr[2];
	end

	// Output assignment
	assign q = lfsr;

endmodule
