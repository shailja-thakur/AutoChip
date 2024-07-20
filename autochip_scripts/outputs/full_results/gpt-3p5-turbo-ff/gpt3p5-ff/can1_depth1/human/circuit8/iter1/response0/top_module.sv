module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg p_reg;
	reg q_reg;

	always @(posedge clock) begin
		if (a)
			p_reg <= 1'b1;
		else
			p_reg <= 1'b0;

		if (p_reg)
			q_reg <= 1'b1;
		else
			q_reg <= 1'b0;
	end
	
	assign p = p_reg;
	assign q = q_reg;
endmodule
