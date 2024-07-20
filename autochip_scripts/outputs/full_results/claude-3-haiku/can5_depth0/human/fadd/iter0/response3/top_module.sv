module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire x, y, z;

    // Half adder for a + b
    assign x = a ^ b;
    assign y = a & b;

    // Full adder with carry-in
    assign sum = x ^ cin;
    assign z = x & cin;
    assign cout = y | z;

endmodule
