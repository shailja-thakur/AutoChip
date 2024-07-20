module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge);

	reg [7:0] d_last;  // Register to store the value of the input signal from the previous clock cycle

	always @(posedge clk) begin
		d_last <= in;  // Store the current value of the input signal
		pedge <= in & ~d_last;  // Calculate the output signal indicating the rising edges
	end

endmodule
