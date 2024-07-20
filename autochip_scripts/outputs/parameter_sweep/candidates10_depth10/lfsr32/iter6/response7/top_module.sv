module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	reg [31:0] next_q;

	always @(posedge clk) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			q <= next_q;
			next_q[31:1] <= q[30:0];
			next_q[0] <= q[22] ^ q[2] ^ q[1] ^ q[0];
		end
	end
endmodule
