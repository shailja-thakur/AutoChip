module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	always @(posedge clk) begin
		anyedge <= anyedge | (in ^ anyedge); // Detect any edge
	end
endmodule
