module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_next, q_next;

always @(posedge clock) begin
	if (a) begin
		p_next <= ~p;
		q_next <= q;
	end else begin
		p_next <= p;
		q_next <= ~q;
	end
end

always @(posedge clock) begin
	p <= p_next;
	q <= q_next;
end

endmodule
