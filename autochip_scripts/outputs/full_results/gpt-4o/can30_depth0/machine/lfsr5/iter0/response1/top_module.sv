module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// State transition always block
	always @(q) begin
		q_next = q[4:1];   // Assign q_next with q except the LSB
		q_next[4] = q[0];  // Assign q_next[4] with q[0], the LSB
		q_next[2] = q_next[2] ^ q[0];  // Assign q_next[2] with q[2] XOR q[0]
	end
	
	// Sequential always block
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'h1;  // Reset value
		else
			q <= q_next;  // State transition
	end

endmodule
