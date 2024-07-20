module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	reg [4:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 1;
		else
			q <= q_next;
	end

	always @(q) begin
		q_next[4] <= q[3];
		q_next[3] <= q[2];
		q_next[2] <= q[1];
		q_next[1] <= q[0];
		q_next[0] <= q[4] ^ q[2] ^ q[0];
	end
endmodule
