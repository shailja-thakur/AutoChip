module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire xor1, and1, and2;

    // 1-bit full adder
    assign xor1 = a ^ b;
    assign sum = xor1 ^ cin;
    assign and1 = a & b;
    assign and2 = xor1 & cin;
    assign cout = and1 | and2;

endmodule
