module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_reg;
reg q_reg;

always @(posedge clock) begin
	if (a == 0) begin
		p_reg <= p_reg;
		q_reg <= q_reg;
	end else begin
		if (p_reg == 1) begin
			p_reg <= 0;
		end else begin
			p_reg <= 1;
		end
		
		if (q_reg == 1) begin
			q_reg <= 0;
		end else begin
			q_reg <= 1;
		end
	end
end

assign p = p_reg;
assign q = q_reg;

endmodule
