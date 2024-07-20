module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			q <= 32'h1;
		end else begin
			// Feedback connections
			q[31] <= q[30] ^ q[20] ^ q[0] ^ q[31];
			q[30:1] <= q[29:0];
		end
	end
endmodule
