module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next; // Register to store the next value of q

	always @(posedge clk) begin
		if (reset)
			q <= 32'h1; // Reset to initial value
		else
			q <= q_next; // Update q with q_next value
	end

	always @(posedge clk) begin
		q_next[0] <= q[31]; // Shift bit 31 to bit 0

		// Bit 0 is XORed with bit 1 and bit 21
		q_next[0] <= q[0] ^ q[1] ^ q[21];

		// Update rest of the bits by shifting
		q_next[1:31] <= q[0:30];
	end

endmodule
