module half_adder (
    input a,
    input b,
    output sum,
    output cout
);

	assign sum = a ^ b;
	assign cout = a & b;

endmodule
module top_module (
    input a,
    input b,
    output sum,
    output cout
);

	half_adder u1(
		.a(a),
		.b(b),
		.sum(sum),
		.cout(cout)
	);

endmodule
