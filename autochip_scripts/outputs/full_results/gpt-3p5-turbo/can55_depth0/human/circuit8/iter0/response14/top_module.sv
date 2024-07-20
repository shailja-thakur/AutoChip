module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg p_reg, q_reg;

	always @(posedge clock) begin
		// Implement the sequential circuit here
		if (a == 1'b1) begin
			p_reg <= a;
			q_reg <= p_reg;
		end else begin
			p_reg <= 1'b0;
			q_reg <= p_reg;
		end
	end

	assign p = p_reg;
	assign q = q_reg;

endmodule
