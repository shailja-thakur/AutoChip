module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	// Use a separate register for each bit to store the previous value
	reg [31:0] prev_value;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			prev_value <= 0;
			out <= 0;
		end
		else begin
			out <= in & ~prev_value; // Capture the falling edge
			prev_value <= in; // Store the current value
		end
	end

endmodule
