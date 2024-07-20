module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	// Register to store the input value from the previous clock cycle
	reg [7:0] prev_in;

	always @(posedge clk) begin
		// Detect any edge by comparing current input with previous input
		anyedge <= in ^ prev_in;

		// Update the previous input to the current input
		prev_in <= in;
	end

endmodule
