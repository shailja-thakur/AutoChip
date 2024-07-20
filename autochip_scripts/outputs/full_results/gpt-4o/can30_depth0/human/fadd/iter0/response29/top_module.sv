module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal signals
    wire sum1, carry1, carry2;

    // Sum of the first two inputs and intermediate carry
    assign sum1 = a ^ b;
    assign carry1 = a & b;

    // Final sum and carry out
    assign sum = sum1 ^ cin;
    assign carry2 = sum1 & cin;

    // Final carry-out
    assign cout = carry1 | carry2;

endmodule
