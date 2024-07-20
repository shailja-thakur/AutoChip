module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_next, q_next;

always @(posedge clock) begin
	if (a == 1'b1) begin
		p_next = 1'b0;
		q_next = 1'b0;
	end else begin
		p_next = ~p;
		q_next = p;
	end
end

always @(posedge clock) begin
	p <= p_next;
	q <= q_next;
end

endmodule
