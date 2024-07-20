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

	always @(*) begin
		q_next[0] = q[31];
		q_next[1] = q[0] ^ q[31];
		q_next[21] = q[20] ^ q[31];
		q_next[31:2] = q[30:1];
	end
	
endmodule
