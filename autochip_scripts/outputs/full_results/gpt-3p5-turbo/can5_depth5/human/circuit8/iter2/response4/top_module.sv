module top_module (
	input wire clock,
	input wire a, 
	output reg p,
	output reg q
);

reg temp;

always @(posedge clock) begin
	temp <= a;
	p <= temp;
	q <= p & ~temp;
end

endmodule
