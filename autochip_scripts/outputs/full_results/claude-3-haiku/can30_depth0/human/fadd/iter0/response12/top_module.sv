module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum_wire, carry_wire1, carry_wire2;

    // Half Adder for a and b
    half_adder ha1 (
        .a(a),
        .b(b),
        .sum(sum_wire),
        .carry(carry_wire1)
    );

    // Half Adder for sum_wire and cin
    half_adder ha2 (
        .a(sum_wire),
        .b(cin),
        .sum(sum),
        .carry(carry_wire2)
    );

    // OR gate for the two carry outputs
    assign cout = carry_wire1 | carry_wire2;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output carry
);

    assign sum = a ^ b;
    assign carry = a & b;

endmodule
