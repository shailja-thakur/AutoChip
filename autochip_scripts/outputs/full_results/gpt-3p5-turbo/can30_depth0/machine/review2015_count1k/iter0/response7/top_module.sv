module top_module(
	input wire clk,
	input wire reset,
	output reg [9:0] q);
	
	always @(posedge clk) begin
		if (reset == 1'b1)
			q <= 10'b0;
		else if (q == 10'b1111100111)
			q <= 10'b0;
		else
			q <= q + 1;
	end
	
endmodule
