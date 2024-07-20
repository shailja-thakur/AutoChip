module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);
	
	reg [7:0] prev_in;

	always @(posedge clk) begin
		// Detect edges by comparing current input with the previous input
		anyedge <= (in ^ prev_in);
		// Store the current input for comparison in the next clock cycle
		prev_in <= in;
	end

endmodule
