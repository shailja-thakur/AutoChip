module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire c1, c2, s1;

    // Full adder implementation
    assign s1 = a ^ b ^ cin;
    assign c1 = (a & b) | (a & cin) | (b & cin);
    assign c2 = (a & b & cin);
    assign cout = c1 | c2;
    assign sum = s1;

endmodule
