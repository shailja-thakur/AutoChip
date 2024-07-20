module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in;
	
	always @(posedge clk) begin
		prev_in <= in;                 // Store the previous value of the input
		anyedge <= (in ^ prev_in);     // Detect any edge by XORing current and previous value
	end

endmodule
