module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Internal signal for the next state
	reg [4:0] q_next;

	// First always block for state transition logic
	always @(q) begin
		// Assign q_next with q[4:1] (q excluding the LSB bit)
		q_next = {q[4:1], q[0]};
		// Assign q_next[4] with q[0] (LSB bit)
		q_next[4] = q[0];
		// XOR q_next[2] with q[0] (LSB bit)
		q_next[2] = q_next[2] ^ q[0];
	end

	// Second always block triggered at positive edge of clk
	always @(posedge clk or posedge reset) begin
		// If reset is active, assign q with reset value 5'h1
		if (reset) begin
			q <= 5'h1;
		end
		else begin
			// If reset is inactive, assign q with q_next
			q <= q_next;
		end
	end

endmodule
