module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Internal signals
    wire s1, c1, c2;

    // Sum bit
    assign s1 = a ^ b;
    assign sum = s1 ^ cin;

    // Carry out bits
    assign c1 = a & b;
    assign c2 = s1 & cin;
    assign cout = c1 | c2;

endmodule
