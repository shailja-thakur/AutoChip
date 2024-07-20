module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] lfsr;

	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr <= 32'h1;
		else begin
			lfsr[0] <= lfsr[1] ^ lfsr[2] ^ lfsr[21] ^ lfsr[31];
			lfsr[1:31] <= lfsr[0:30];
		end
	end

	assign q = lfsr;

endmodule
