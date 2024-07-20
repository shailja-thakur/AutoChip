module top_module (
	input a,
	input b,
	input c,
	input d,
	output out,
	output out_n );

	// Intermediate wires
	wire inter1;
	wire inter2;

	// AND gates
	and gate1 (inter1, a, b);
	and gate2 (inter2, c, d);

	// OR gate
	or gate3 (out, inter1, inter2);

	// Inverter
	not gate4 (out_n, out);

endmodule
