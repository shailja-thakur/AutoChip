module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire sum1, cout1, cout2;

    half_adder ha1 (
        .a(a),
        .b(b),
        .sum(sum1),
        .cout(cout1)
    );

    half_adder ha2 (
        .a(sum1),
        .b(cin),
        .sum(sum),
        .cout(cout2)
    );

    assign cout = cout1 | cout2;

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
