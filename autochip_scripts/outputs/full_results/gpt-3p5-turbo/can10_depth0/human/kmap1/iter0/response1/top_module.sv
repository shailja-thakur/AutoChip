module top_module(
	input a, 
	input b,
	input c,
	output out
);

// Wire declaration
wire s0, s1, s2, s3;

// And gates
and gate1(s0, ~a, ~b, c);
and gate2(s1, a, ~b, c);
and gate3(s2, a, b, c);
and gate4(s3, ~a, b, c);

// Or gate
or gate5(out, s0, s1, s2, s3);

endmodule
