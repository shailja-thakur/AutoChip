module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Internal signals
    wire sum_ab;
    wire carry_ab;
    wire carry_cin;

    // Logic for sum_ab and carry_ab
    assign sum_ab = a ^ b;
    assign carry_ab = a & b;

    // Logic for sum and carry_cin
    assign sum = sum_ab ^ cin;
    assign carry_cin = sum_ab & cin;

    // Final carry out logic
    assign cout = carry_ab | carry_cin;

endmodule
