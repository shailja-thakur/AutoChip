module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	// Define the initial value of the output
	initial begin
		q = 8'h0;
	end

	// Always block triggered on the rising edge of the clock
	always @(posedge clk) begin
		q <= d; // Store the input data in the register
	end

endmodule
