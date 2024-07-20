module top_module(
	input clk,
	input reset,
	output reg [3:0] q);
	
	always @(posedge clk or posedge reset) begin
		if (reset) // add reset condition
			q <= 0;
		else begin
			if (q == 15) // check for maximum value
				q <= 0;
			else
				q <= q + 1;
		end
	end
	
endmodule
