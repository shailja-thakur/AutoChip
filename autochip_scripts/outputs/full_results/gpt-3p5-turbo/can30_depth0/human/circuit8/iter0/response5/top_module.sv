module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_reg;
reg q_reg;

always @(posedge clock) begin
	p_reg <= a;
	q_reg <= p_reg;
end

always @(posedge clock) begin
	if (q_reg) begin
		p <= p_reg;
		q <= 0;
	end else begin
		p <= 0;
		q <= q_reg;
	end
end

endmodule
