module top_module(
	input wire clk,
	input wire d,
	output reg q);

	reg q_reg;

	initial
	begin
		q_reg = 1'hx;
	end

	always @(posedge clk)
	begin
		q_reg <= d;
	end

	assign q = q_reg;

endmodule
