module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// State transition logic based on q
	always @(*) begin
		q_next = q[4:1];    // Assign q_next with q except the LSB bit
		q_next[4] = q[0];   // Assign q_next[4] with the LSB bit
		q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with the LSB bit
	end

	// Update q at the positive edge of clk or reset
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1;   // Assign reset value
		end else begin
			q <= q_next; // Assign state transition value
		end
	end

endmodule
