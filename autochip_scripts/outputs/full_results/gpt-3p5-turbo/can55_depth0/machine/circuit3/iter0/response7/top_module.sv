module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    wire ab_or, cd_or;
    wire q_and;

    // Bitwise OR of inputs a and b
    assign ab_or = a | b;

    // Bitwise OR of inputs c and d
    assign cd_or = c | d;

    // Bitwise AND of ab_or and cd_or
    assign q_and = ab_or & cd_or;

    // Assigning output q with the result of q_and
    assign q = q_and;

endmodule
