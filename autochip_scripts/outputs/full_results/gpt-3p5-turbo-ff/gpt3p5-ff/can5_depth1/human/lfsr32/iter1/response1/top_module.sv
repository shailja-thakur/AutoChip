module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] q_next;

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
		else begin
			q_next[31] <= q[22] ^ q[1] ^ q[0];
			q_next[30:0] <= q[31:1];
			q <= q_next;
		end
	end

endmodule
