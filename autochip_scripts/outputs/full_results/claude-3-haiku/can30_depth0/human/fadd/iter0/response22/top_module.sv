module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire ab_or_ac, bc_or_acinv;

    // Sum
    assign sum = a ^ b ^ cin;

    // Carry
    assign ab_or_ac = (a & b) | (a & cin);
    assign bc_or_acinv = (b & cin) | (a & ~cin);
    assign cout = ab_or_ac | bc_or_acinv;

endmodule
