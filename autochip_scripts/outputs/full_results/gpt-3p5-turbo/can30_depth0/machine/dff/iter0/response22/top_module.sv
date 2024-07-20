module top_module(
	input clk,
	input d,
	output reg q);
	
	// Initial block
	initial begin
		q = 1'hx;
	end
	
	// Always block
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
