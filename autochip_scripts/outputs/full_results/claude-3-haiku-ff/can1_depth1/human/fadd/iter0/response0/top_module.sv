module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire x, y, z;

    // Sum
    assign sum = a ^ b ^ cin;

    // Carry
    assign x = a & b;
    assign y = a & cin;
    assign z = b & cin;
    assign cout = x | y | z;

endmodule
