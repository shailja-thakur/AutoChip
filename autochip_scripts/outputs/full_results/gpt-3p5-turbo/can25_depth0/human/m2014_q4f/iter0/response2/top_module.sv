module top_module (
	input in1,
	input in2,
	output logic out
);
// Implement the AND gate with an inverter on the in2 input
and_gate and_gate_inst (
	.in1(in1),
	.in2(inv_in2), // inverted in2
	.out(and_out)
);

// Implement the inverter for in2
not_gate not_gate_inst (
	.in(in2),
	.out(inv_in2)
);

// Assign the output of the AND gate to the 'out' signal
assign out = and_out;

endmodule
module and_gate (
	input in1,
	input in2,
	output logic out
);
assign out = in1 & in2;
endmodule
module not_gate (
	input in,
	output logic out
);
assign out = ~in;
endmodule
