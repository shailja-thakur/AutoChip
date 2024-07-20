module top_module(
	input a, 
	input b,
	output out
);

// Create internal wires to connect the components
wire or_out;

// OR gate to generate the logical OR of inputs a and b
or_gate or_gate_inst(
	.a(a),
	.b(b),
	.out(or_out)
);

// Inverter to invert the output of the OR gate
not_gate not_gate_inst(
	.a(or_out),
	.out(out)
);

endmodule
module or_gate(
	input a,
	input b,
	output out
);
	assign out = a | b;
endmodule
module not_gate(
	input a,
	output out
);
	assign out = ~a;
endmodule
