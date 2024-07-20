module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] state;
	assign q = state[31];

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 32'h1;
		else begin
			state[31:1] <= {state[30:0], state[0] ^ state[30] ^ state[20] ^ state[0]};
		end
	end

endmodule
