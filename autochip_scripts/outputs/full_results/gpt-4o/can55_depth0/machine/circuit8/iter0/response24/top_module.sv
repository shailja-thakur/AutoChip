module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

always @(negedge clock) begin
	q <= a;
end

always @(a) begin
	if (clock)
		p <= a;
end

endmodule
