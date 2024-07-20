module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal signals
	wire s, c;

	// Instantiate half adder
	half_adder ha(
		.a(a),
		.b(b),
		.s(s),
		.c(c)
	);

	// Assign output ports
	assign sum = s;
	assign cout = c;

endmodule
module half_adder (
	input a,
	input b,
	output s,
	output c
);
	assign {s, c} = a + b;
endmodule
