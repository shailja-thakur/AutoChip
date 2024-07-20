module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg prev_a;

always @(posedge clock) begin
	prev_a <= a;
	p <= a;
end

always @(negedge clock) begin
	q <= p;
end

endmodule
