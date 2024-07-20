module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] state = 32'h1;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 32'h1;
		else begin
			state[0] <= state[31] ^ state[21] ^ state[1] ^ state[0];
			state[31:1] <= state[30:0];
		end
	end

	assign q = state;
	
endmodule
