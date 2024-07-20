module top_module(
	input clk,
	input d,
	output reg q);

	// Initial block to set the initial value of q
	initial begin
		q = 1'bx;
	end

	// Always block to update q at every rising edge of the clock
	always @(posedge clk) begin
		q <= d;
	end

endmodule
