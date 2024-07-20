module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next;

	// Sequential block for updating the q register
	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;  // Reset the register to initial value
		else
			q <= q_next;  // Update q with q_next on every clock cycle
	end

	// Combinational block to calculate the next value of q
	always @(*) begin
		q_next[31] = q[0];  // Feedback bit 0 to bit 31
		q_next[30:1] = q[29:0];  // Shift the rest of the bits
		
		// Calculate new value for bit 0
		q_next[0] = q[0] ^ q[21] ^ q[1];
	end

endmodule
