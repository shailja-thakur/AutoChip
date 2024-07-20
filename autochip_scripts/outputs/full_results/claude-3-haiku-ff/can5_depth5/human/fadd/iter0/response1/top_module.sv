module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire c1, c2, s1;

    // Half adder for a + b
    assign s1 = a ^ b;
    assign c1 = a & b;

    // Full adder with carry-in
    assign sum = s1 ^ cin;
    assign c2 = s1 & cin;
    assign cout = c1 | c2;

endmodule
