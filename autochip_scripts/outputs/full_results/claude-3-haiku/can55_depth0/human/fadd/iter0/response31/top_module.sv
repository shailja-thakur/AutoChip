module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half Adder for a and b
    half_adder HA1 (
        .a(a),
        .b(b),
        .sum(s1),
        .cout(c1)
    );

    // Half Adder for s1 and cin
    half_adder HA2 (
        .a(s1),
        .b(cin),
        .sum(sum),
        .cout(c2)
    );

    // Combine the carry outs
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
