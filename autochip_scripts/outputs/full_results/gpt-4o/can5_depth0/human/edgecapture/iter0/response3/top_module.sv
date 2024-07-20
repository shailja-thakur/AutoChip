module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] prev_in;

	always @(posedge clk) begin
		if (reset) begin
			out <= 32'b0;
			prev_in <= 32'b0;
		end else begin
			// Detect falling edge from 1 to 0 on each bit and set output bit
			out <= out | (prev_in & ~in);
			// Update previous input
			prev_in <= in;
		end
	end

endmodule
