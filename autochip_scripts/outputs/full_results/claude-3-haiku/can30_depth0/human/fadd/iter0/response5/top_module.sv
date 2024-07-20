module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire carry1, carry2;

    // Half Adder for a + b
    assign carry1 = a & b;
    assign sum = a ^ b;

    // Full Adder with carry-in
    assign carry2 = (a ^ b) & cin;
    assign cout = carry1 | carry2;

endmodule
