module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next; // Declare q_next register

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1; // Reset the register to initial value
		end else begin
			q <= q_next; // Update q register with q_next value
		end
	end

	always @(posedge clk) begin
		q_next[0] <= q[31]; // Shift the value of q[31] to q_next[0]
		q_next[1] <= q[0] ^ q[0]; // XOR bit 0 with bit 0
		q_next[2:31] <= q[1:30]; // Shift remaining bits by 1
		q_next[21] <= q_next[2] ^ q_next[0]; // XOR bit 0 with bit 2 and store in q_next[21]

		// XOR bit 0 with bit 1 and store in q_next[1]
		q_next[1] <= q_next[1] ^ q_next[0];
	end

endmodule
