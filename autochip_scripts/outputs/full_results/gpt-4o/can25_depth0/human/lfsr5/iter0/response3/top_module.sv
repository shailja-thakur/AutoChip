module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'b00001; // Reset to 1
		end else begin
			// Galois LFSR with taps at positions 5 and 3
			// Taps at positions 5 and 3 mean we XOR bit 4 and bit 2 (0-indexed) 
			q <= {q[3:0], q[4] ^ q[2]};
		end
	end
endmodule
