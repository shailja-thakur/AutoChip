module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 0;
		else begin
			if (q == 9'd999)
				q <= 0;
			else
				q <= q + 1;
		end
	end
endmodule
