module top_module(
	input clk,
	input reset,
	output reg [9:0] q);

	always @(posedge clk or posedge reset) begin
		if (reset)
			q <= 10'b0;
		else begin
			if (q == 999)
				q <= 10'b0;
			else
				q <= q + 10'b1;
		end
	end

endmodule
