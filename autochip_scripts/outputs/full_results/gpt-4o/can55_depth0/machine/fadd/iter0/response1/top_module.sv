module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Assign the sum of a, b, and cin to sum
    assign sum = a ^ b ^ cin;

    // Assign the carry-out bit
    assign cout = (a & b) | (a & cin) | (b & cin);

endmodule
