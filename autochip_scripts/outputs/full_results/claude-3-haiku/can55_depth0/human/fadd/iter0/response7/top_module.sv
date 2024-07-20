module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Full adder implementation
    assign s1 = a ^ b;
    assign c1 = a & b;
    assign sum = s1 ^ cin;
    assign c2 = s1 & cin;
    assign cout = c1 | c2;

endmodule
