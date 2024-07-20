module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
		else begin
			q[0] <= q[31] ^ q[21] ^ q[1];
			for (int i = 1; i < 32; i = i+1) begin
				q[i] <= q[i-1];
			end
		end
	end
endmodule
