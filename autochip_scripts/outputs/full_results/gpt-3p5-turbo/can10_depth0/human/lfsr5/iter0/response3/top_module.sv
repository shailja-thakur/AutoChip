module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Register to hold the LFSR state
	reg [4:0] lfsr;

	// Output register
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 1;
		else
			q <= lfsr;
	end

	// LFSR logic
	always @(posedge clk) begin
		if (reset)
			lfsr <= 0;
		else begin
			lfsr[4] <= lfsr[3] ^ lfsr[0];
			lfsr[3] <= lfsr[2];
			lfsr[2] <= lfsr[1];
			lfsr[1] <= lfsr[0];
			lfsr[0] <= lfsr[4];
		end
	end

endmodule
