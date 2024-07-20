module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);
	
	reg [31:0] previous_in;
	reg [31:0] in_delayed;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in_delayed;
			in_delayed <= in;
			
			// Check for rising edge
			out <= out | (previous_in & ~in_delayed);
		end
	end

endmodule
