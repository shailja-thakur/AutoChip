module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Intermediate wires
	wire intermediate1;
	wire intermediate2;

	// First layer AND gates
	and gate1 (a, b, intermediate1);
	and gate2 (c, d, intermediate2);

	// Second layer OR gate
	or gate3 (intermediate1, intermediate2, out);

	// Inverter
	not gate4 (out, out_n);

endmodule
