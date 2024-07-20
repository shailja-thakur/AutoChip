module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal signals
    wire sum1, carry1, carry2;

    // First stage: Half adder for a and b
    assign sum1 = a ^ b;
    assign carry1 = a & b;

    // Second stage: Half adder for sum1 and cin
    assign sum = sum1 ^ cin;
    assign carry2 = sum1 & cin;

    // Carry out
    assign cout = carry1 | carry2;

endmodule
