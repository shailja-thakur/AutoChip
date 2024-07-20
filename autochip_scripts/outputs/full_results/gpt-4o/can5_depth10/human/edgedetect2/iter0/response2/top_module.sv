module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in;
	
	always @(posedge clk) begin
		// Detect any edge by checking if current input differs from previous input
		anyedge <= (in != prev_in) & ~in & (in | prev_in);
		// Store current input as previous input for next clock cycle
		prev_in <= in;
	end

endmodule
