module top_module (
	input clock,
	input a,
	output reg p,
	output reg q
);
	
	always @(negedge clock)
		q <= a;
	
	always @(a or clock)
		if (clock)
			p <= a;

endmodule
