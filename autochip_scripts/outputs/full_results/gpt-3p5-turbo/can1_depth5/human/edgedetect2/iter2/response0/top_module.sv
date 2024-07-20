module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in = 8'b0;
	reg [7:0] current_in = 8'b0;

	always @(posedge clk) begin
		prev_in <= current_in;
		current_in <= in;
	end

	always @* begin
		anyedge = (current_in & ~prev_in) | (anyedge & ~in);
	end

endmodule
