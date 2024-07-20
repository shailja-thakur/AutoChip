module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 32'h1;
		end else begin
			state <= {state[30:0], state[0] ^ state[20] ^ state[30] ^ state[31]};
		end
	end

	assign q = state;

endmodule
