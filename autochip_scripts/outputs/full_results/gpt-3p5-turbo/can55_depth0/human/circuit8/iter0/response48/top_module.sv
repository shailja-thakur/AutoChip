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
	if (q_reg)
		p <= 1'b0;
	else
		p <= a;
end

always @(posedge clock) begin
	if (a)
		q <= 1'b0;
	else
		q <= q_reg;
end

endmodule
