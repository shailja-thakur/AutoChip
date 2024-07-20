module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk)
	begin
		if (reset == 1'b1)
			q <= 4'b0;
		else if (slowena == 1'b1)
		begin
			if (q == 4'b1001)
				q <= 4'b0;
			else
				q <= q + 1;
		end
	end

endmodule
