module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire s1, c1, c2;

    // Half adder for the lower bit
    assign s1 = a ^ b;
    assign c1 = a & b;

    // Use the half adder output and the carry-in to calculate the sum and carry-out
    assign sum = s1 ^ cin;
    assign c2 = s1 & cin;
    assign cout = c1 | c2;

endmodule
