module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] lfsr;

	always @(posedge clk or posedge reset) begin
		if (reset)
			lfsr <= 32'h1;
		else begin
			lfsr[31] <= lfsr[22] ^ lfsr[1];
			lfsr[30:0] <= lfsr[29:0];
		end
	end

	assign q = lfsr;

endmodule
