module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	// Register to store the value of the input signal from the previous clock cycle
	reg [7:0] d_last;

	always @(posedge clk) begin
		// Calculate the rising edge detection by performing a bitwise AND between current input and ~d_last
		pedge <= in & ~d_last;
		// Store the current value of the input for the next cycle
		d_last <= in;
	end

endmodule
