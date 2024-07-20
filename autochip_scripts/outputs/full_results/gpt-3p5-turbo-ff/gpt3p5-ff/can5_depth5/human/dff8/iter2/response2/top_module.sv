module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

	reg [7:0] q_reg;

	always @(posedge clk) begin
		q_reg <= d;
	end

	// Add a delay to the q assignment
	always @(posedge clk) begin
		#1 q <= q_reg;
	end

endmodule
