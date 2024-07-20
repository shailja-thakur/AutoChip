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
	q_reg <= p;
end

always @(posedge clock) begin
	if (q_reg) begin
		p <= 1'b0;
	end else if (p_reg) begin
		p <= 1'b1;
	end else begin
		p <= 1'b0;
	end
end

always @(posedge clock) begin
	q <= q_reg;
end

endmodule
