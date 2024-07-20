module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	// Register to store the previous value of the input signal
	reg [7:0] d_last;

	// Always block triggered on the rising edge of the clock signal
	always @(posedge clk) begin
		// Store the current value of the input signal
		d_last <= in;
		// Compute the rising edge detection
		pedge <= in & (~d_last);
	end

endmodule
