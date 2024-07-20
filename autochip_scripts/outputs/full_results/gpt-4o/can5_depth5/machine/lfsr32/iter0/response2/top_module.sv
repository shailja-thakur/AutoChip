module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Intermediate register for next state
	reg [31:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Reset the register to the initial value
			q <= 32'h1;
		end else begin
			// Update q register with the value of q_next on clk rising edge
			q <= q_next;
		end
	end
	
	always @(*) begin
		// Compute next value with shifting and XOR operations
		q_next[31] = q[0]; // Bit 0 shifted to Bit 31
		q_next[30:1] = q[29:0]; // Shift remaining bits
		q_next[0] = q[0] ^ q[1] ^ q[21]; // New Bit 0 is XOR of old Bit 0, Bit 1, and Bit 21
	end

endmodule
