module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_d;
reg q_d;

always @(posedge clock) begin
	p_d <= a;
	q_d <= p_d;
end

always @(posedge clock) begin
	p <= p_d;
	q <= q_d;
end

endmodule
