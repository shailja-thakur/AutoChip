module top_module (
	input a,
	input b,
	output sum,
	output cout
);

	// Declare internal wire for sum and carry bit
	wire s, c;

	// Instantiate a half adder submodule
	half_adder ha1 (
		.a(a),
		.b(b),
		.s(s),
		.c(c)
	);

	// assign half adder outputs to the top module outputs
	assign sum = s;
	assign cout = c;

endmodule
module half_adder (
	input a,
	input b,
	output s,
	output c
);
	assign s = a ^ b; // XOR gate to calculate sum
	assign c = a & b; // AND gate to calculate carry-out
endmodule
