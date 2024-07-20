module half_adder (
    input a,
    input b,
    output sum,
    output cout
);

	// Assign the sum of the inputs to the output sum
	assign sum = a ^ b;

	// Assign the carry-out of the inputs to the output cout
	assign cout = a & b;

endmodule
module top_module (
    input a,
    input b,
    output sum,
    output cout
);

	// Instantiate the half adder module
	half_adder half_adder_inst (
	    .a(a),
	    .b(b),
	    .sum(sum),
	    .cout(cout)
	);

endmodule
