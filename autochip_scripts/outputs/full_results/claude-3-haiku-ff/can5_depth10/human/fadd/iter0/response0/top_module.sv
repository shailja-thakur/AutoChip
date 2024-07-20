module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half adder for a + b
    half_adder ha1 (
        .a(a),
        .b(b),
        .sum(s1),
        .cout(c1)
    );

    // Half adder for s1 + cin
    half_adder ha2 (
        .a(s1),
        .b(cin),
        .sum(sum),
        .cout(c2)
    );

    // OR gate for carry out
    assign cout = c1 | c2;

endmodule
module half_adder (
    input a,
    input b,
    output sum,
    output cout
);

    assign sum = a ^ b;
    assign cout = a & b;

endmodule
