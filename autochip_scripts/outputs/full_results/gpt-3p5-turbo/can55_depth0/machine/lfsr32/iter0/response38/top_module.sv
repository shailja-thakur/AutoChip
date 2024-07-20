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
			
		q_next[31:1] = q[30:0];
		q_next[21] = q[0] ^ q[1];
		q_next[1] = q[0] ^ q[0];
	end

endmodule
