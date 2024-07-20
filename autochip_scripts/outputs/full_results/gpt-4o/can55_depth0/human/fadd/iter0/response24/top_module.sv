module top_module (
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    // Internal signals
    wire sum_ab, carry_ab, carry_sumcin;

    // Half adder for a and b
    assign sum_ab = a ^ b;
    assign carry_ab = a & b;

    // Sum and carry out
    assign sum = sum_ab ^ cin;
    assign carry_sumcin = sum_ab & cin;
    assign cout = carry_ab | carry_sumcin;

endmodule
