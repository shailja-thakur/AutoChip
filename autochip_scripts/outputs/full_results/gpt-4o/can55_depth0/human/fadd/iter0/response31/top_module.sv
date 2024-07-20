module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Internal signal to hold the intermediate sum and carry
    wire sum1, carry1, carry2;

    // Sum of a and b
    assign sum1 = a ^ b;
    assign carry1 = a & b;

    // Sum of sum1 and cin
    assign sum = sum1 ^ cin;
    assign carry2 = sum1 & cin;

    // Final carry out
    assign cout = carry1 | carry2;

endmodule
