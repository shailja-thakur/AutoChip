module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] d_last;

	always @(posedge clk) begin
		d_last <= in; // Store the current value of in in d_last
	end

	always @(posedge clk) begin
		anyedge <= in ^ d_last; // Perform an XOR operation to detect edges
	end
endmodule
