module top_module(
	input clk,
	input shift_enable,
	input count_enable,
	input data,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (shift_enable)
			q <= data;
		else if (count_enable)
			q <= q - 1;
	end
	
endmodule
