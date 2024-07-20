module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire x, y, z;

    // Compute the sum
    assign x = a ^ b;
    assign sum = x ^ cin;

    // Compute the carry-out
    assign y = a & b;
    assign z = x & cin;
    assign cout = y | z;

endmodule
