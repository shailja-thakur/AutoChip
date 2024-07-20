module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half adder for a and b
    assign s1 = a ^ b;
    assign c1 = a & b;

    // Half adder for s1 and cin
    assign sum = s1 ^ cin;
    assign c2 = s1 & cin;

    // Combine the carry bits
    assign cout = c1 | c2;

endmodule
