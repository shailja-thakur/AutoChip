module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);
	
	reg [7:0] prev_in;
	
	always @(posedge clk) begin
		// Detect any edge
		anyedge <= in ^ prev_in;
		// Store the previous input
		prev_in <= in;
	end

endmodule
