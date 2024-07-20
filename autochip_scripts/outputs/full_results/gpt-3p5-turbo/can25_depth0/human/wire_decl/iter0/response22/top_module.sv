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

	// AND gates
	and gate1 ( .a(a), .b(b), .z(intermediate1) );
	and gate2 ( .a(c), .b(d), .z(intermediate2) );

	// OR gate
	or gate3 ( .a(intermediate1), .b(intermediate2), .z(out) );

	// Inverter gate
	not gate4 ( .a(out), .z(out_n) );

endmodule
