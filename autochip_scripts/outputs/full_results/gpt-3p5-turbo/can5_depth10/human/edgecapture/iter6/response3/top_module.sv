module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] previous_in;

	always @(posedge clk) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			
			// Check for rising edge
			out <= previous_in & ~in;
		end
	end

endmodule
