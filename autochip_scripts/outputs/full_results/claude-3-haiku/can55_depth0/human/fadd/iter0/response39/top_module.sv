module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire x, y, z;

    // Full adder implementation
    assign x = a ^ b;
    assign y = a & b;
    assign z = x & cin;
    assign sum = x ^ cin;
    assign cout = y | z;

endmodule
