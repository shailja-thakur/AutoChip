module top_module(
	input x,
	input y,
	output z);

	// Declare internal signals
	reg x_delayed;
	reg y_delayed;

	// Delay x and y signals by one clock cycle
	always @(posedge clk) begin
		x_delayed <= x;
		y_delayed <= y;
	end

	// Assign value to z based on the delayed x and y signals
	assign z = (x_delayed & y_delayed);

endmodule
