module top_module (
	input a,
	input b,
	output sum,
	output cout
);

    // Define internal wires for half adder
    wire s, c;

    // Instantiate half adder
    half_adder HA (
        .a(a),
        .b(b),
        .sum(s),
        .carry(c)
    );

    // Assign sum and carry to output ports
    assign sum = s;
    assign cout = c;

endmodule
module half_adder (
	input a,
	input b,
	output sum,
	output carry
);

    // Logic to implement half adder
    xor(sum, a, b);
    and(carry, a, b);

endmodule
