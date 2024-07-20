module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

// internal signals
wire s0, s1, s2;

// first half adder
xor x1(s0, a, b);
and a1(s1, a, b);

// second half adder
xor x2(sum, s0, cin);
and a2(cout, s0, cin);

// third half adder
xor x3(sum, sum, s1);
and a3(cout, sum, s1);

endmodule
