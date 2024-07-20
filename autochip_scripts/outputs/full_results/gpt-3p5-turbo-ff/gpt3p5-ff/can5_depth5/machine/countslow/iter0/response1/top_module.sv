module top_module(
	input clk,
	input slowena,
	input reset,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (reset)
			q <= 0;
		else begin
			if (slowena) begin
				if (q == 4'd9)
					q <= 0;
				else
					q <= q + 1;
			end
		end
	end

endmodule
