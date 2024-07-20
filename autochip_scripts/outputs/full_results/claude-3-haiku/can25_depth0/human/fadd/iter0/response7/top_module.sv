module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    wire ab_or_ac, bc_or_ab;

    assign ab_or_ac = a & b | a & cin;
    assign bc_or_ab = b & cin | a & b;
    assign sum = a ^ b ^ cin;
    assign cout = ab_or_ac | bc_or_ab;

endmodule
