module top_module(
	input clk,
	input d,
	output reg q);

	// Register signal q initialization
	initial
	begin
		q = 1'hx;
	end

	// Register signal q update on rising edge of clk
	always @(posedge clk)
	begin
		q <= d;
	end

endmodule
