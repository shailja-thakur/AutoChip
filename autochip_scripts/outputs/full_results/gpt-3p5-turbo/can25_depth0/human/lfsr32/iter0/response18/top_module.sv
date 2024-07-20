module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] q_next;

	// LFSR taps
	parameter [31:0] taps = 32'b10000000000000000000000100000011;

	// Synchronous reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= q_next;
		end
	end

	// LFSR logic
	always @(posedge clk) begin
		if (reset) begin
			q_next <= 32'h1;
		end else begin
			q_next[0] <= q[31] ^ q[21] ^ q[1] ^ q[0];
			q_next[31:1] <= q[30:0];
		end
	end

endmodule
