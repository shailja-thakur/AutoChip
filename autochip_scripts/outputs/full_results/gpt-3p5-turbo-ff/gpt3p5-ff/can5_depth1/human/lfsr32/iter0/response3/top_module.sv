module top_module(
	input clk,
	input reset,
	output reg [31:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 32'h1;
		else begin
			q[31] <= q[22] ^ q[1] ^ q[0];
			q[30:0] <= q[31:1];
		end
	end

endmodule
