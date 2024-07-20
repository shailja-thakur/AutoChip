module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// First always block to handle state transitions of q
	always @(*) begin
		q_next = q[4:1];       // Assigning q except the LSB bit
		q_next[4] = q[0];      // Assigning q[0] to q_next[4]
		q_next[2] = q_next[2] ^ q[0]; // XORing q_next[2] with q[0]
	end

	// Second always block to handle logic at the positive edge of clk
	always @(posedge clk or posedge reset) begin
		if (reset) 
			q <= 5'h1;          // Reset value
		else 
			q <= q_next;        // State transition
	end

endmodule
