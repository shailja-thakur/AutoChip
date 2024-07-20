module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// Internal register to store next value of q
	reg [31:0] q_next;

	// Combinational logic to compute next value of q
	always @(*) begin
		q_next[31] = q[0];  // Feedback from bit 0 to bit 31
		q_next[30:1] = q[29:0]; // Shift right
		q_next[0] = q[21] ^ q[1] ^ q[0]; // XOR bits 21, 1 with 0, and 0 with itself (effectively unchanged)
	end

	// Sequential logic to update q on rising edge of clk or reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1; // Reset q to initial value
		end else begin
			q <= q_next; // Update q with q_next
		end
	end

endmodule
