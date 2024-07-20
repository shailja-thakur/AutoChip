module top_module(
	input a, 
	input b,
	output out
);

// OR gate
wire or_out;
or #(2) or_gate(
	.a({a, b}),
	.out(or_out)
);

// Inverter
inverter inv_gate(
	.in(or_out),
	.out(out)
);

endmodule
