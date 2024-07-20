module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg p_reg;
	reg q_reg;
	
	always @(posedge clock) begin
		p_reg <= a & p_reg;
		q_reg <= ~a | q_reg;
	end
	
	assign p = p_reg;
	assign q = q_reg;
	
endmodule
