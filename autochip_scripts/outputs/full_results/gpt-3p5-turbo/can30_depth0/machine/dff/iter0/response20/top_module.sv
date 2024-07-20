module top_module(
	input clk,
	input d,
	output reg q);

	// initialize register signal q to 1'hx
	initial
		q = 1'hx;

	// always block triggered by rising edge of clock signal
	always @(posedge clk)
		q <= d;

endmodule
