module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    wire s; // Intermediate sum without carry
    wire c1, c2; // Intermediate carries

    // Calculate intermediate sum and carries
    assign s = a ^ b;
    assign c1 = a & b;
    assign c2 = s & cin;

    // Calculate final sum and carry out
    assign sum = s ^ cin;
    assign cout = c1 | c2;

endmodule
