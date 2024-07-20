module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
	reg p_reg, q_reg;

	always @(posedge clock) begin
		if (a == 1'b1) begin
			p_reg <= 1'b1;
			q_reg <= p_reg;
		end else begin
			p_reg <= 1'b0;
			q_reg <= p_reg;
		end
	end

	always @(posedge clock) begin
		p <= p_reg;
		q <= q_reg;
	end

endmodule
