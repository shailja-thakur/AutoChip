module top_module(
	input clk,
	input d,
	output reg q);
	
	// Initialize q to an unknown state
	initial begin
		q = 1'hx;
	end
	
	// Always block to update q on the rising edge of clk
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
