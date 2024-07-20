module top_module (
	input clock,
	input a,
	output reg p,
	output reg q
);

	reg p_next, q_next;

	always @(posedge clock) begin
		if (a == 1 || p_next == 1)
			p <= 1;
		else
			p <= 0;
		
		if (a == 1 && p_next == 0)
			q <= 1;
		else
			q <= 0;
		
		p_next <= p;
		q_next <= q;
	end

endmodule
