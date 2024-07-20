module top_module(
	input clk,
	input d,
	output reg q);

	// Initial block to set the initial value of q
	initial begin
		q = 1'hx;
	end

	// Always block triggered on the rising edge of the clock signal
	always @(posedge clk) begin
		q <= d;
	end

endmodule
