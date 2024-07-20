module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);
	// Internal wires
	wire w1, w2, w3;

	// AND gates for generating carry out
	and gate1(w1, a, b);
	and gate2(w2, a, cin);
	and gate3(w3, b, cin);

	// XOR gates for generating sum
	xor gate4(sum, a, b);
	xor gate5(sum, sum, cin);

	// OR gate for generating final carry out
	or gate6(cout, w1, w2, w3);
endmodule
