module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// First always block for state transition
	always @(*) begin
		q_next = q[4:1];  // q_next gets q[4:1]
		q_next[4] = q[0];  // q_next[4] gets q[0]
		q_next[2] ^= q[0]; // q_next[2] is XORed with q[0]
	end

	// Second always block for sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'h1;  // Reset value for q
		else
			q <= q_next;  // State transition
	end

endmodule
