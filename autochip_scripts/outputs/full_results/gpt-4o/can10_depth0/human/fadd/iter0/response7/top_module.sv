module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);

    // Intermediate signals
    wire sum_ab;
    wire carry_ab;
    wire carry_abc;

    // First stage: add a and b
    assign sum_ab = a ^ b;
    assign carry_ab = a & b;

    // Second stage: add sum_ab with cin
    assign sum = sum_ab ^ cin;
    assign carry_abc = sum_ab & cin;
    
    // Final carry-out
    assign cout = carry_ab | carry_abc;

endmodule
