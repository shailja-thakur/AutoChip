module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 32'h1;
		else begin
			state[0] <= state[31] ^ state[21] ^ state[1] ^ state[0];
			state[1] <= state[0] ^ state[22];
			state[2:31] <= state[1:30];
		end
	end

	assign q = state;

endmodule
