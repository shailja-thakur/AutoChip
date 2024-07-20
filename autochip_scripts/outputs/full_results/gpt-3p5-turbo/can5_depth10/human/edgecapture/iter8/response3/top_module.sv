module top_module(
	input clk,
	input reset,
	input [31:0] in,
	output reg [31:0] out);

	reg [31:0] previous_in;
	reg [31:0] prev_out;

	reg [31:0] rising_edge_in;
	reg [31:0] falling_edge_in;

	always @(posedge clk or posedge reset) begin
		if (reset)
			out <= 0;
		else begin
			previous_in <= in;

			// Check for rising edge
			rising_edge_in <= previous_in & ~in;
			prev_out <= out;
			out <= prev_out | rising_edge_in;

			// Check for falling edge
			falling_edge_in <= ~previous_in & in;
			prev_out <= out;
			out <= prev_out & ~falling_edge_in;
		end
	end

endmodule
