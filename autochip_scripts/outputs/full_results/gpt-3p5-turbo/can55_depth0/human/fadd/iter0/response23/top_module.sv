module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

wire w1, w2, w3;

and gate_a(w1, a, b);
and gate_b(w2, a, cin);
and gate_c(w3, b, cin);

xor xor1(sum, a, b);
xor xor2(sum, sum, cin);

or or1(cout, w1, w2);
or or2(cout, w3);

endmodule
