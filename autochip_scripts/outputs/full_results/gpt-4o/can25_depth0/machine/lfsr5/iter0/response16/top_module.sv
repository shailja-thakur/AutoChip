module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	// First Always Block - State transition
	always @(*) begin
		q_next = {q[4:1], q[0]}; // Assign q[4:1] to q_next[3:0] and q[0] to q_next[4]
		q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
	end

	// Second Always Block - State Update
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 5'h1; // Reset value
		end else begin
			q <= q_next; // State transition
		end
	end
endmodule
