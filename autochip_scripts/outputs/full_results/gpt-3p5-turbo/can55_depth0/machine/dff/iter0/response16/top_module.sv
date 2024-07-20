module top_module(
	input clk,
	input d,
	output reg q);

	// Initialize the register value
	initial
	begin
		q = 1'hx;
	end

	// Assign the value of d to q on the rising edge of the clock
	always @(posedge clk)
	begin
		q <= d;
	end

endmodule
