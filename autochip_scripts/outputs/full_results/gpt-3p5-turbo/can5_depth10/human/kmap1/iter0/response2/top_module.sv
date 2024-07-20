module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Internal wire declarations
wire w1, w2;

// Logic gates
and gate1(w1, a, ~b);
and gate2(w2, c, w1);
or gate3(out, w1, w2);

endmodule
module and(
	input a,
	input b,
	output y
);
	assign y = a & b;
endmodule
module or(
	input a,
	input b,
	output y
);
	assign y = a | b;
endmodule
