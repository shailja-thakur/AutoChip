module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] in_d; // Delayed input signal to detect transition.

	always @(posedge clk) begin
		if (reset) begin
			out <= 32'b0;
		end else begin
			in_d <= in;
			out <= out | (in_d & ~in); // Update out when the change from 1 to 0 is detected.
		end
	end

endmodule
