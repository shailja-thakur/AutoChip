module top_module(
	input clk,
	input reset,
	output reg [31:0] q
);

	reg [31:0] state;

	always @(posedge clk or posedge reset) begin
		// Reset logic
		if (reset) begin
			state <= 32'h1;
		end
		else begin
			// LFSR logic
			state <= {state[30:0], state[31] ^ state[21] ^ state[1] ^ state[0]};
		end
	end

	assign q = state;

endmodule
