module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal signals
	reg [31:0] next_q;

	// Flip-flop to hold the reset state
	reg reset_ff;

	// Galois LFSR taps
	reg tap_32;
	reg tap_22;
	reg tap_2;
	reg tap_1;

	// Assign values to taps
	always @* begin
		tap_32 = q[31];
		tap_22 = q[21];
		tap_2 = q[1];
		tap_1 = q[0];
	end

	// Register to hold the next value of q
	always @(posedge clk) begin
		if (reset == 1) begin
			reset_ff <= 1;
			next_q <= 32'h1;
		end else if (reset_ff == 1) begin
			reset_ff <= 0;
			next_q <= 32'h1;
		end else begin
			reset_ff <= 0;
			next_q <= {q[30:0], tap_32 ^ tap_22 ^ tap_2 ^ tap_1};
		end
	end

	// Assign next_q value to q
	always @* begin
		q = next_q;
	end

endmodule
