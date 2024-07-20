module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire x, y, z;

    // Calculate the sum
    assign x = a ^ b;
    assign sum = x ^ cin;

    // Calculate the carry-out
    assign y = a & b;
    assign z = x & cin;
    assign cout = y | z;

endmodule
