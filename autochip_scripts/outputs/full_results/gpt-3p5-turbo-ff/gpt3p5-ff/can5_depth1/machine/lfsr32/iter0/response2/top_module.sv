module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk) begin
		// update q_next on every clock cycle
		q_next[0] = q[31];
		q_next[1] = q[0] ^ q[31] ^ q[21] ^ q[1];
		// update q register on rising edge of clk
		if (reset)
			q <= 32'h1; // reset to initial value
		else
			q <= q_next;
	end

endmodule
