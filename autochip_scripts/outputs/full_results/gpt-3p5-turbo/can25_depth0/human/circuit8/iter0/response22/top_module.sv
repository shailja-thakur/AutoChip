module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_next;
reg q_next;

always @(posedge clock) begin
	if (a) begin
		p_next <= 1'b1;
		q_next <= p_next;
	end else begin
		p_next <= 1'b0;
		q_next <= p_next;
	end
end

always @(posedge clock) begin
	p <= p_next;
	q <= q_next;
end

endmodule
