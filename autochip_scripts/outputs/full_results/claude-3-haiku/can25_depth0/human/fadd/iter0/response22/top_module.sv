module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Define internal wires
    wire sum_1, carry_1, carry_2;

    // Half adder 1
    half_adder ha1 (
        .a(a),
        .b(b),
        .sum(sum_1),
        .carry(carry_1)
    );

    // Half adder 2
    half_adder ha2 (
        .a(sum_1),
        .b(cin),
        .sum(sum),
        .carry(carry_2)
    );

    // Combine the carry outs
    assign cout = carry_1 | carry_2;

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
