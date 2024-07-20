module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next;

	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;
	end

	always @(posedge clk) begin
		q_next[0] <= q[31];
		q_next[1] <= q[0] ^ q[0];
		q_next[2:31] <= q[1:30];
	end

endmodule
