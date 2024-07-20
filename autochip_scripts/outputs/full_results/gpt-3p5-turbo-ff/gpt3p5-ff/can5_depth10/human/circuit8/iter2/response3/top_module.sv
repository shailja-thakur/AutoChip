module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

// Sequential circuit
reg p_next, q_next;
always @(posedge clock) begin
	p <= p_next;
	q <= q_next;
end

always @* begin
	p_next = 1'b0;
	q_next = 1'b0;
	
	if (a == 1'b1) begin
		if (p == 1'b0 && q == 1'b0) begin
			p_next = 1'b1;
			q_next = 1'b1;
		end else if (p == 1'b1 || q == 1'b1) begin
			p_next = 1'b0;
			q_next = 1'b0;
		end
	end
end

endmodule
