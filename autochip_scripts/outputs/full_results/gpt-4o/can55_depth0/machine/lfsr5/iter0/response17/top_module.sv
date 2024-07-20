module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// First always block for state transitions
	always @(q) begin
		q_next = q[4:1];    // q_next takes the value of q except the LSB bit
		q_next[4] = q[0];   // q_next[4] takes the LSB bit of q
		q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with the LSB of q
	end

	// Second always block for sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'h1;    // Reset value
		else
			q <= q_next;  // State transition
	end

endmodule
