module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	// internal registers
	reg [31:0] q_next;

	always @(posedge clk) begin
		if (reset)
			q <= 32'h1;
		else
			q <= q_next;
		q_next[31:1] <= q[30:0];
		q_next[0] <= q[0] ^ q[21] ^ q[1];
	end
endmodule
