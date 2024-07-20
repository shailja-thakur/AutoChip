module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] lfsr;

	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr <= 1;
		else begin
			lfsr[0] <= lfsr[4] ^ lfsr[2];  // Tap positions
			lfsr[1:4] <= lfsr[0:3];  // Shift
		end
	end

	assign q = lfsr;

endmodule
