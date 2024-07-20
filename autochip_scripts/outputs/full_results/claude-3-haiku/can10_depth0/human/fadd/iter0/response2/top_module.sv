module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire carry1, carry2;

    // Half Adder for a + b
    full_adder fa1 (
        .a(a),
        .b(b),
        .cin(1'b0),
        .cout(carry1),
        .sum(carry2)
    );

    // Full Adder for carry2 + cin
    full_adder fa2 (
        .a(carry2),
        .b(cin),
        .cin(1'b0),
        .cout(cout),
        .sum(sum)
    );

endmodule
module full_adder (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
