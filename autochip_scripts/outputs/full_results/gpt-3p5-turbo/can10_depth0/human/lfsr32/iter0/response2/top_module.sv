module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] lfsr;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			lfsr <= 32'h1;
		end else begin
			lfsr[31] <= lfsr[31] ^ lfsr[22] ^ lfsr[2] ^ lfsr[1];
			lfsr[30:0] <= lfsr[31:1];
		end
	end

	assign q = lfsr;

endmodule
