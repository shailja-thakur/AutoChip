module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] state;

	// LFSR taps
	wire tap1 = state[32] ^ state[22] ^ state[2] ^ state[1];

	always@(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 32'h1;
		end else begin
			state <= {state[30:0], tap1};
		end
	end

	always@(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= state;
		end
	end

endmodule
