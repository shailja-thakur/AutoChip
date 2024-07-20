module top_module(
	input clk,
	input d,
	output reg q);

	// Initial block to set q to an unknown state
	initial begin
		q = 1'hx;
	end

	// Always block triggered by the rising edge of clk
	always @(posedge clk) begin
		q <= d;
	end
	
endmodule
