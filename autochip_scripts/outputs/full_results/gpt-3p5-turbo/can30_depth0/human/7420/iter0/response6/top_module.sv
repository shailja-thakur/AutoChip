module top_module(
	input p1a, 
	input p1b, 
	input p1c, 
	input p1d, 
	output p1y, 
	input p2a, 
	input p2b, 
	input p2c, 
	input p2d, 
	output p2y
);
	// Declare internal signals
	wire p1y_int;
	wire p2y_int;

	// Instantiate NAND gates
	// First NAND gate
	nand_gate_4_input u1(
		.a(p1a),
		.b(p1b),
		.c(p1c),
		.d(p1d),
		.y(p1y_int)
	);

	// Second NAND gate
	nand_gate_4_input u2(
		.a(p2a),
		.b(p2b),
		.c(p2c),
		.d(p2d),
		.y(p2y_int)
	);

	// Output assignments
	assign p1y = p1y_int;
	assign p2y = p2y_int;
endmodule
module nand_gate_4_input(
	input a,
	input b,
	input c,
	input d,
	output y
);
	// Intermediate signal declaration
	wire w1, w2, w3;

	// Intermediate signal assignments
	nand_gate_2_input u1(
		.a(a),
		.b(b),
		.y(w1)
	);
	nand_gate_2_input u2(
		.a(c),
		.b(d),
		.y(w2)
	);
	nand_gate_2_input u3(
		.a(w1),
		.b(w2),
		.y(w3)
	);

	// Output assignment
	assign y = w3;
endmodule
module nand_gate_2_input(
	input a,
	input b,
	output y
);
	// Output assignment
	assign y = ~(a & b);
endmodule
