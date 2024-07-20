module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] in_d; // Register to store the previous state of 'in'

	always @(posedge clk) begin
		in_d <= in; // Store the current state of 'in' in 'in_d'
		anyedge <= in & ~in_d; // Set output bits where there is a 0 to 1 transition
	end

endmodule
