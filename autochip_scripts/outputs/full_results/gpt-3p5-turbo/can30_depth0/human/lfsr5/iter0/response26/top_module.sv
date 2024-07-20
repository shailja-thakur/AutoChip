module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	/* 5-bit maximal-length Galois LFSR with taps at bit positions 5 and 3 */
	reg [4:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 5'b1;
		else begin
			state[4] <= state[3] ^ state[2] ^ state[0];
			state[3:0] <= state[4:1];
		end
	end

	assign q = state;

endmodule
