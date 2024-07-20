module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define internal signals
	reg [4:0] lfsr;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			lfsr <= 5'b1;
		end else begin
			// LFSR feedback logic
			lfsr[4] <= lfsr[3] ^ lfsr[0] ^ lfsr[4];
			lfsr[3:0] <= lfsr[4:1];
		end
	end

	// Output assignment
	assign q = lfsr;

endmodule
