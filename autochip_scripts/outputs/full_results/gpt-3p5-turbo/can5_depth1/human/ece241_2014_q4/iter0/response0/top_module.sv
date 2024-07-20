module top_module (
	input clk,
	input x,
	output z
);
	
	reg d0, d1, d2;
	wire q0, q1, q2;
	
	always @(posedge clk) begin
		d0 <= x ^ q0;
		d1 <= x & ~q1;
		d2 <= x | ~q2;
	end
	
	xnor3 xnor_gate (
		.q(z),
		.a(q0),
		.b(q1),
		.c(q2)
	);
	
endmodule
module xnor3 (
	output q,
	input a,
	input b,
	input c
);
	
	assign q = ~(a^b^c);
	
endmodule
