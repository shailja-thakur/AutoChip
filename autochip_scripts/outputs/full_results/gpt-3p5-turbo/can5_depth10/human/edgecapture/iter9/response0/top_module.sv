module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] previous_in;
	reg [31:0] prev_out;

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;
			prev_out <= out;

			// Check for rising edge
			out <= prev_out | (previous_in & ~in);
		end
	end

endmodule
