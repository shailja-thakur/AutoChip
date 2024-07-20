module top_module (
	input a,
	input b,
	input cin,
	output cout,
	output sum
);

	// Creating signals to store intermediate results
	wire w1, w2, w3;

	// Creating the XOR gates for each input bit
	xor gate1 (.a(a), .b(b), .o(w1));
	xor gate2 (.a(w1), .b(cin), .o(sum));

	// Creating the AND gates for each input bit
	and gate3 (.a(a), .b(b), .o(w2));
	and gate4 (.a(b), .b(cin), .o(w3));
	and gate5 (.a(a), .b(cin), .o(cout));

	// Creating the OR gate for the carry-out bit
	or gate6 (.a(w2), .b(w3), .o(cout));

endmodule
