module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Intermediate wires
	wire wire1;
	wire wire2;

	// AND gates
	and gate1 (wire1, a, b);
	and gate2 (wire2, c, d);

	// OR gate
	or gate3 (out, wire1, wire2);

	// NOT gate
	not gate4 (out_n, out);

endmodule
