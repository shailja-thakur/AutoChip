module top_module(
	input clk,
	input d,
	output reg q);

	// Initialize the register signal q
	initial begin
		q = 1'bx; // Initialize to unknown state
	end

	// Always block triggered by the rising edge of the clock signal
	always @(posedge clk) begin
		q <= d; // Set the register signal q to the value of the data signal d
	end

endmodule
