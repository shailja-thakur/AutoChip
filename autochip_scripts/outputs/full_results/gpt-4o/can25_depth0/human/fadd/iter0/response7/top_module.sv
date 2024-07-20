module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal wires to hold intermediate results
    wire sum1, carry1, carry2;

    // Compute the sum of a and b
    assign sum1 = a ^ b;

    // Compute the sum with the carry-in
    assign sum = sum1 ^ cin;

    // Compute the carry from a and b
    assign carry1 = a & b;

    // Compute the carry from the sum1 and carry-in
    assign carry2 = sum1 & cin;

    // Compute the final carry-out
    assign cout = carry1 | carry2;

endmodule
