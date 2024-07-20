module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// First always block for state transitions
	always @(*) begin
		q_next = q[4:1];    // Assign q[4:1] to q_next
		q_next[4] = q[0];   // Assign LSB to q_next[4]
		q_next[2] = q[2] ^ q[0]; // XOR q[2] with q[0]
	end

	// Second always block for sequential logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1;    // Reset value
		end else begin
			q <= q_next; // State transition
		end
	end

endmodule
