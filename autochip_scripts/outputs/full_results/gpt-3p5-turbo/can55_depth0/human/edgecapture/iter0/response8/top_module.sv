module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Register for storing the previous input value
	reg [31:0] prev_in;

	// Combiantional logic to detect the rising edge and change of input from 1 to 0
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			prev_in <= 0;
			out <= 0;
		end else begin
			prev_in <= in;
			out <= out | (prev_in & ~in);
		end
	end
endmodule
