module top_module(
	input clk,
	input d,
	output reg q);

	initial begin
		q = 1'bx;
	end

	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
