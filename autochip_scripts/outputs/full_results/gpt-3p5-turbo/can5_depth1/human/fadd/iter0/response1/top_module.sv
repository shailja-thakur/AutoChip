module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Define internal signals
	wire w1, w2, w3;

	// Implement the full adder logic
	xor gate_xor1(w1, a, b);
	xor gate_xor2(sum, w1, cin);
	and gate_and1(w2, a, b);
	and gate_and2(w3, w1, cin);
	or gate_or1(cout, w2, w3);

endmodule
