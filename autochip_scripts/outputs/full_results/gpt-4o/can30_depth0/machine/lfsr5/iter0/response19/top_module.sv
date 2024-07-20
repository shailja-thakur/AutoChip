module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	always @(*) begin
		q_next = q[4:1]; // q_next gets q[4:1]
		q_next[4] = q[0]; // q_next[4] gets q[0]
		q_next[2] = q_next[2] ^ q[0]; // q_next[2] gets q_next[2] XORed with q[0]
	end

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 5'h1; // reset value
		else
			q <= q_next; // state transition
	end

endmodule
