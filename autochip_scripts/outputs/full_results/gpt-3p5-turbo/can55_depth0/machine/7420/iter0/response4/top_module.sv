module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
	
	and_gate and1(p1a, p1b, p1c, p1d, p1y);
	and_gate and2(p2a, p2b, p2c, p2d, p2y);

endmodule
module and_gate(
	input a,
	input b,
	input c,
	input d,
	output y
);

	wire w1, w2, w3, w4;
	
	and u1(a, b, w1);
	and u2(c, d, w2);
	and u3(w1, w2, w3);
	not u4(w3, w4);
	
	assign y = w4;

endmodule
module and(
	input a,
	input b,
	output y
);

	assign y = a & b;

endmodule
module not(
	input a,
	output y
);

	assign y = ~a;

endmodule
