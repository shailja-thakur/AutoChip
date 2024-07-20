module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

	// Intermediate wires for the circuit
	wire and1, and2, or1, not1, not2, or2, or3, and3, and4, pos0, pos1;

	// Logical AND of inputs c and d
	assign and1 = c & d;

	// Logical NOT of inputs a and b
	assign not1 = ~a;
	assign not2 = ~b;

	// Logical AND of not1, not2, and c
	assign and2 = not1 & not2 & c;

	// Logical OR of and1 and and2
	assign or1 = and1 | and2;

	// Assign out_sop to or1
	assign out_sop = or1;

	// Logical OR of not1 and b
	assign or2 = not1 | b;

	// Logical OR of c and or2
	assign or3 = c | or2;

	// Logical AND of or3 and d
	assign and3 = or3 & d;

	// Logical AND of not1 and d
	assign and4 = not1 & d;

	// Assign pos0 to and3
	assign pos0 = and3;

	// Assign pos1 to and4
	assign pos1 = and4;

	// Ternary expression to assign out_pos based on pos0 and pos1
	assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
