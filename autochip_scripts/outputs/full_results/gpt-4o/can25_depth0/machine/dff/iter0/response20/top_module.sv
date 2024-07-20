module top_module(
	input clk,
	input d,
	output reg q);

	// Initial block to set the initial value of q
	initial begin
		q = 1'hx; // Set q to an unknown value initially
	end

	// Always block triggered by the rising edge of the clock
	always @(posedge clk) begin
		q <= d; // Sample the data signal d at the rising edge of the clock
	end

endmodule
