module top_module (
	input clock,
	input a,
	output reg p,
	output reg q
);

	reg p_reg, q_reg;

	always @(negedge clock)
		q_reg <= a;

	always @(a)
		if (clock)
			p_reg <= a;

	assign p = p_reg;
	assign q = q_reg;

endmodule
